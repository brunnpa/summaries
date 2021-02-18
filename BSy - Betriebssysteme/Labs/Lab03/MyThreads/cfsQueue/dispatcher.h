#ifndef DISPATCHER_HEADER
#define DISPATCHER_HEADER

//******************************************************************************
// File:     dipatcher.h
// Purpose:  header file for preemtive user space thread scheduling
// Author:   M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Revision: 2/2015
// Version:  v.fs20
//******************************************************************************

#include "commondefs.h"
#include "mthread.h"

#define START            -1 
#define JOIN             -2
#define YIELD            -3
#define EXIT             -4

#define MIN_TIME_SLICE  100                 // minimum time slice -> 0.1ms
#define DEF_TIME_SLICE 1000                 // default time slice -> 1.0ms

//******************************************************************************

void dispatchInit(int slice);               // init scheduler
void dispatchTask(int argument);            // the thread switcher

//******************************************************************************
#endif // DISPATCHER_HEADER
