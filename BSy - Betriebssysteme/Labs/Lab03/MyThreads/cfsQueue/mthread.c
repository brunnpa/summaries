//******************************************************************************
// File:     mthread.h
// Purpose:  implementation of thread handling functions and data
// Author:   M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Revision: 1/2014, 2/2019: mtDelThread -> check for NULL pointer, vRuntime
// Version:  v.fs20
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "mthread.h" 

//******************************************************************************

static long currentTID = 0;			// global threadID counter

//******************************************************************************
// Function:    mtNewThread
// Purpose:     set up data structure for new threads

mthread_t* mtNewThread(tfunc_t function, void* arg, tprio_t prio, 
                                                    unsigned int stacksize) {
    mthread_t* tcb     = (mthread_t*)malloc(sizeof(mthread_t));
    assert(tcb != NULL);

    tcb->tID            = currentTID++;
    tcb->tPrio          = prio;
    tcb->readyTime      = 0;
    tcb->vRuntime       = 0.0;

    tcb->startFunction  = function;
    tcb->arg            = arg;

    if (stacksize < STACK_SIZE) {
        stacksize = STACK_SIZE;
        if (stacksize > 0)
            printf("setting stack size to %d\n", STACK_SIZE);
    }

    tcb->stack         = (unsigned long)malloc(stacksize);
    assert(tcb->stack != (unsigned long)NULL);

    tcb->stackpointer = tcb->stack + stacksize - 32;

    tcb->firstCall    = 1;
    return(tcb);
};

//******************************************************************************
// clean up thread

void mtDelThread(mthread_t* tcb) {
    if (tcb != NULL) {
        free((void*)(tcb->stack));
        free(tcb);
    }
}

//******************************************************************************

long mtGetFreeStackSize(mthread_t* tcb) {
    long retval;
    if (tcb->stackpointer > tcb->stack)
        retval = (long)(tcb->stackpointer - tcb->stack);
    else
        retval = -1;
    return retval;
}

//******************************************************************************
// Print thread control block

void mtPrintTCB(mthread_t* tcb) { 

    printf("tid: %d, prio: %d, ready time: %d, ", tcb->tID, tcb->tPrio, 
                                                  tcb->readyTime);
    printf("sp: %lX, free stack %ld\n", tcb->stack, mtGetFreeStackSize(tcb)); 

}

//******************************************************************************

unsigned int mtGetID(mthread_t* tcb) {
	return(tcb->tID);
}

//******************************************************************************

void mtSetPrio(mthread_t* tcb, tprio_t prio) {
	tcb->tPrio = prio;
}

tprio_t mtGetPrio(mthread_t* tcb) {
	return(tcb->tPrio);
}

//******************************************************************************

void mtSetReadyTime(mthread_t* tcb, unsigned int rTime) {
	tcb->readyTime = rTime;
}
	
unsigned int mtGetReadyTime(mthread_t* tcb) {
	return(tcb->readyTime);			// get ready time (clock ticks)
}

//******************************************************************************

unsigned long mtGetSP(mthread_t* tcb) {
    return tcb->stackpointer;
}

void mtSaveSP(mthread_t* tcb, unsigned long sp) {
    tcb->stackpointer = sp;
}

//******************************************************************************

tfunc_t mtGetStartFunction(mthread_t* tcb) {
    return tcb->startFunction;
}


void* mtGetArgPointer(mthread_t* tcb) {
    return tcb->arg;
}

//******************************************************************************

int mtIsFirstCall(mthread_t* tcb) {
    return tcb->firstCall;
}

void mtClearFirstCall(mthread_t* tcb) {
    tcb->firstCall = 0;
}
//******************************************************************************

