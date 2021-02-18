#ifndef MYTHREAD_HEADER
#define MYTHREAD_HEADER

//******************************************************************************
// File:     mthread.h
// Purpose:  header file for thread handling functions and data
// Author:   M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Revision: 1/2014, 5/2019 
// Version:  v.fs20
//******************************************************************************

#include "commondefs.h"

//------------------------------------------------------------------------------
// Thread control block

typedef struct mthread_struct {
    unsigned      tID;              // thread-ID
    tprio_t       tPrio;            // thread priority
    unsigned      readyTime;        // time, when a a waiting tcbread
                                    // can be activated, in clock ticks
    float         vRuntime;         // virtual run time pr
    tfunc_t       startFunction;    // thread function (pointer)
    void          *arg;             // argument of thread function (pointer)

    unsigned long stackpointer;     // current stackpointer of the thread
    unsigned long stack;            // bottom of stack

    int           firstCall;        // thread runs for the first time
} mthread_t;

//******************************************************************************
// function prototypes 

    mthread_t* mtNewThread(tfunc_t function, void* arg, tprio_t prio, 
                                                      unsigned stacksize);
    void      mtDelThread(mthread_t* tcb);
    long      mtGetFreeStackSize(mthread_t* tcb);


    unsigned  mtGetID(mthread_t* tcb);

    tprio_t   mtGetPrio(mthread_t* tcb);

    void      mtSetReadyTime(mthread_t* tcb, unsigned rtime);    
    unsigned  mtGetReadyTime(mthread_t* tcb);

    tfunc_t   mtGetStartFunction(mthread_t* tcb);
    void*     mtGetArgPointer(mthread_t* tcb);

    void      mtSaveSP(mthread_t* tcb, unsigned long sp);
    unsigned  long mtGetSP(mthread_t* tcb);

    int       mtIsFirstCall(mthread_t* tcb);
    void      mtClearFirstCall(mthread_t* tcb);

    void      mtPrintTCB(mthread_t* tcb);
    
//******************************************************************************

#endif // MYTHREAD_HEADER
