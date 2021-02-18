//******************************************************************************
// File:     dispatcher.c
// Purpose:  implementation preemtive user space thread scheduling
// Author:   M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Revision: 2/2015
//******************************************************************************

#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

#include "commondefs.h"
#include "dispatcher.h"
#include "mthread.h"
#include "queues.h"

//******************************************************************************
// assembler-macros to switch threads

#include "asm.h"

//******************************************************************************
// local function prototypes

void startTimeSlice(void);
void finishTimeSlice(void);

void signalHandler(int sig);
void preemptionHandler(int sig);

//******************************************************************************
// Static data of scheduler

unsigned long    threadSP;              // storage for stackptr of thread 
unsigned long    scheduSP;              // storage for stackptr of scheduler

int              schedArg;              // parameter passed to scheduler

mthread_t*       activeThread;          // currently active thread
int              timeSlice;             // length of time slice in usec

struct sigaction sigAction;             // signal handler 
int    shutdown = 0;                    // flag, to indicate reception of CTRL-C

//******************************************************************************
// scheduler functions
//******************************************************************************
// Function: dispatcherInit()
// Purpose:  initialize scheduler: set signal handlers, time slice, etc 
//           behaves like a singleton

void dispatchInit(int slice) {
    static int dispatcherState = 0;
    if (dispatcherState == 0) {
        sigAction.sa_flags = SA_RESTART;
        sigemptyset(&sigAction.sa_mask);

        sigAction.sa_handler = signalHandler;           // signal handler CTRLC
        sigaction(SIGINT, &sigAction, NULL);

        sigAction.sa_handler = preemptionHandler;       // signal handler timer
        sigaction(SIGVTALRM, &sigAction, NULL);

        if (slice == 0)
            timeSlice = DEF_TIME_SLICE; 
        else if (slice < MIN_TIME_SLICE)
            timeSlice = MIN_TIME_SLICE;
        else                     
            timeSlice = slice; 
        dispatcherState = 1;                              // set to initialized
    }
}

//******************************************************************************
// Function:    dispatchTask()
// Purpose:     switch threads
// Argument:    JOIN:
//              START: first call of scheduler (initialize if necssessary)
//              YIELD: active thread yields
//              EXIT:  active thread terminates
//              n > 0: active thread waits for n clocks tics

void dispatchTask(int argument)
{
    tfunc_t   startFunction;              // start function of a thread

    finishTimeSlice();                    // finish time slice (block signal)

    schedArg = argument;                  // save argument to static variable

    /*if (activeThread != NULL) {
        printf("not NULL\n");
    if (mtGetFreeStackSize(activeThread) <= LOW_STACK) {
        printf("LOW_STACK %d %ld\n", LOW_STACK, mtGetFreeStackSize(activeThread));
        schedArg = EXIT;
    }*/

    /* --- check how we were called ----------------------------------------- */

    switch (schedArg)    {
        case START:
        case JOIN:
            dispatchInit(DEF_TIME_SLICE);   // init with defaults
            break;
        case EXIT :                         // thread exits with mythread_exit()
            {
            RESTORE_SP(scheduSP);           // scheduler: restore stackpointer
            RESTORE_REGS();                 // scheduler: restore regs and flags
            } 
            mtDelThread(activeThread);      // thread:    is deleted
        break;
        default :                           // thread yields or waits
            {
            SAVE_REGS();                    // thread:    save regs and flags
            SAVE_SP(threadSP);              // thread:    save stackpointer
            RESTORE_SP(scheduSP);           // scheduler: restore stackpointer
            RESTORE_REGS();                 // scheduler: restore regs and flags
            }                                          
            mtSaveSP(activeThread, threadSP); // thread:  store stackpointer
            //if (mtGetFreeStackSize(activeThread) > LOW_STACK) {
                if (schedArg == YIELD)
                    mqAddToQueue(activeThread, 0);
                else
                    mqAddToQueue(activeThread, schedArg);
            //}
            /*else {
                printf("\n*** terminating thread %d, reason: low stack ***\n",
                                                    mtGetID(activeThread));
                mtDelThread(activeThread); 
            }*/
            break;
    }

    /* --- now we have to look for the next thread to be scheduled ---------- */
        
    activeThread = mqGetNextThread();               // get next ready thread

    if  ((shutdown) || (activeThread == NULL)) {
        if (shutdown)
            printf("\n*** got CTRL_C\n");
        else {
            printf("\n*** no more threads to schedule ***\n");
        }
        mqDelete();
    } 
    else {

        /* --- now start or restart thread -----------------------------------*/

        threadSP = mtGetSP(activeThread);           // thread:    get stackptr

        if (mtIsFirstCall(activeThread)) {          // if thread never run
            mtClearFirstCall(activeThread);         // thread: mark as started
            {  
              SAVE_REGS();                          // scheduler: save regs
              SAVE_SP(scheduSP);                    // scheduler: save SP
              RESTORE_SP(threadSP);                 // thread:    set SP
            }
            startFunction = mtGetStartFunction(activeThread);// get start func
            startTimeSlice();                                // start time slice
            startFunction(mtGetArgPointer(activeThread));    // call start func
        }
        else {
            SAVE_REGS();                            // scheduler: save regs
            SAVE_SP(scheduSP);                      // scheduler: save stackptr
            RESTORE_SP(threadSP);                   // thread:    set stackptr
            RESTORE_REGS();                         // thread:    restore regs
            startTimeSlice();                       // start time slice
        }
    }

    return;
}

//******************************************************************************
// timer stuff for preemptive scheudling
//      - we use interval timer ITIMER_VIRTUAL to prevent problems with 
//        sleep and alarm
//      - a  signal is blocked during execution of the handler and only
//        deblocked on exiting the handler: since we use a handler to switch
//        threads, the signal stays blocked, which has to be unblocked for
//        the new thread
//------------------------------------------------------------------------------

void finishTimeSlice(void)  {
    // block signal
    sigset_t sigSet;
    sigemptyset(&sigSet);
    sigaddset(&sigSet, SIGVTALRM);
    sigprocmask(SIG_BLOCK, &sigSet, NULL);
}

//------------------------------------------------------------------------------

void startTimeSlice(void) {
    // unblock signal
    sigset_t sigSet;
    sigemptyset(&sigSet);
    sigaddset(&sigSet, SIGVTALRM);
    sigprocmask(SIG_UNBLOCK, &sigSet, NULL);

    // start one shot timer
    struct itimerval it;
    it.it_interval.tv_sec  = 0;
    it.it_interval.tv_usec = 0;
    it.it_value.tv_sec     = 0;
    it.it_value.tv_usec    = timeSlice;
    setitimer(ITIMER_VIRTUAL, &it, NULL);
 
}

//******************************************************************************
// Functions: signal handlers
// Purpose:   - catch CTRL-C and set the shutdown to true, to allow
//              the scheduler to shut down at a save point
//            - catch SIGVTALRM -> preempt current thread    
// Parameter: not used

void signalHandler(int sig) {
    shutdown = 1;               // set shutdown flag
}

void preemptionHandler(int sig) {        // preempt current thread
    dispatchTask(YIELD);
}
//******************************************************************************

