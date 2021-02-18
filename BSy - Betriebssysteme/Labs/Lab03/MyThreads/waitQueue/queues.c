//******************************************************************************
// File:    queues.c
// Purpose: implementation of queues for scheduler
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
//          M. Thaler, 2019, CFS
// Version: v.fs20
//******************************************************************************

#include <stdlib.h>
#include <sys/types.h>
#include <sys/times.h>
#include <unistd.h>
#include <stdio.h>

#include "mlist.h"
#include "mthread.h"
#include "queues.h"

//******************************************************************************
// local function prototypes

unsigned mqGetTime(void);
void     mqPrintReadyQueueStatus(void);

//******************************************************************************
// Static data of queueing system

mlist_t*    runQueue;                       // the run queue
mlist_t*    tmpQueue;                       // the run queue
mlist_t*    waitQueue;                      // the wait queue

//******************************************************************************
//
// Queueing functions
//
//==============================================================================
// Function:    initQueues
// Purpose:     initialize queueing system
//              behaves like a singleton

static int queueState = 0;

void mqInit(void) {
    if (queueState == 0) {
        runQueue = mlNewList();
        tmpQueue = mlNewList();
        waitQueue = mlNewList();
        mqGetTime();                        // register start time
        queueState = 1;                     // now we are initialized
    }
}

//==============================================================================
// Function:    delQueues
// Purpose:     clean up dynamically allocated data
// Hint:        will be called by scheduler before termination

void mqDelete(void) {
    mlDelList(runQueue);
    mlDelList(tmpQueue);
    queueState = 0;
    printf("\n*** cleaning queues ***\n");
}

//==============================================================================
// Function:    getNextThread
// Purpose:     returns thread with highest priority in the run queue
//              if there is no thread, return value is NULL

// compares two threads for sorting
int cmp(void *a, void *b)
{
    mthread_t *ta = (mthread_t *)a;
    mthread_t *tb = (mthread_t *)b;

    if (ta->vRuntime < tb->vRuntime)
    {
        return -1;
    }

    if (ta->vRuntime > tb->vRuntime)
    {
        return 1;
    }

    return 0;
}


mthread_t* mqGetNextThread(void) {
    mthread_t* tcb;

    // Solange bereite Threads in waitQueue sind, diese in runQueue rüberschieben
    if (waitQueue != NULL){
        while ((tcb = mlReadFirst(waitQueue)) != NULL && mtGetReadyTime(tcb) <= mqGetTime()){
            mlEnqueue(runQueue, mlDequeue(waitQueue));
        }
    }

    // Threads aus runQueue nach Prio zurückgeben
    mthread_t* thread;
	  for (int i = 0; i < NUM_PRIO_QUEUES; i++){ // NUM_PRIO_QUEUES ist gegeben in COMMONDEFS.h
	    thread = mlDequeue(runQueue);
	    if(thread != NULL) {
        return thread;
      }
	  }

    // runQueue leer, aber Threads in waitQueue am schlafen
    // waitTime schlafen und Methode rekursiv wieder aufrufen
    tcb = mlReadFirst(waitQueue);
    if (thread == NULL && tcb != NULL){
      unsigned int waittime = mtGetReadyTime(tcb) - mqGetTime();
      usleep(waittime);
      return mqGetNextThread();
    }

	  return thread;
}



//==============================================================================
// Function:    add to queue
// Purpose:     initialize queueing system

void mqAddToQueue(mthread_t *tcb, int sleepTime) {
    tcb->vRuntime += mqGetRuntime() * (mtGetPrio(tcb) + 1); //code aus der Aufgabenstellung, mit der korrekten Priorität (+1)
    
    // Falls sleepTime vorhanden, Thread in waitQueue eingliedern
    if (sleepTime > 0) {
      tcb->readyTime = mqGetTime() + sleepTime;
      mlEnqueue(waitQueue, tcb);
      return;
    }
    
    mlSortIn(runQueue, tcb, *cmp); //sortiertes Einfügen
}


//==============================================================================
// Function:    printWaitQueue
// Purpose:     prints a the list with threads in the wait queue

void lqPrintWaitQueue(void) {
}

//==============================================================================
// Function:    printReadyQueueStatus
// Purpose:     prints the number of threads in the ready queues at "getTime()"

void mqPrintReadyQueueStatus(void) {
    int i;
    i = mlGetNumNodes(runQueue); // number of threads
    printf("\t\trun queue,  %d entries at time %d\n", i, mqGetTime());
    i = mlGetNumNodes(tmpQueue); // number of threads
    printf("\t\ttmp queue,  %d entries at time %d\n", i, mqGetTime());
}

//******************************************************************************
// Function:    getTime, local function
// Purpose:     returns wall clock time in 1ms resolution since program start
//              works like singleton to register start time of module             

unsigned mqGetTime(void) {
    static int    firstCall = 1;
    static struct timeval startTime;

    struct timeval currentTime;
    unsigned time;

    if (firstCall) {
        gettimeofday(&startTime, NULL);
        firstCall = 0;
    }

    gettimeofday(&currentTime, NULL);
    time = (unsigned)((currentTime.tv_sec  - startTime.tv_sec)*1000 + 
                      (currentTime.tv_usec - startTime.tv_usec)/1000);
    return time;
}

//******************************************************************************

