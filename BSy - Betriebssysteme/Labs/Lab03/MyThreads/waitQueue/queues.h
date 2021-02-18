#ifndef QUEUES_HEADER_FILE
#define QUEUES_HEADER_FILE

//******************************************************************************
// File:    queues.h
// Purpose: header file of queues for scheduler
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Version: v.fs20
//******************************************************************************

#include <sys/time.h>

#include "commondefs.h"
#include "mthread.h"

//******************************************************************************

#define mqGetRuntime() VR_DEFAULT

//******************************************************************************
void       mqInit(void);
void       mqDelete(void);

mthread_t* mqGetNextThread(void);
void       mqAddToQueue(mthread_t* tcb, int sleepTime);

//******************************************************************************

#endif // QUEUES_HEADER
