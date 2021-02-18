#ifndef MY_THREADS_HEADER_FILES_DEFINITIONS
#define MY_THREADS_HEADER_FILES_DEFINITIONS

#include "commondefs.h"
#include "dispatcher.h"
#include "queues.h"
#include "mthread.h"

//******************************************************************************
// File:     mythreads.h
// Purpose:  user interface to the mthread modules
// Author:   M. Thaler, 
// Revision: 3/2015
// Version:  v.fs20
//******************************************************************************
//
// Initialization (singleton)       set up mythreads, initialize queues and
//                                  dispatcher
//                                  use default time slice: 1ms
//
// mthreadCreate(T,A,F,P,S)         create new thread and append to ready queue
//                                  mthread_t* T: thread handle
//                                  tfunc_t    F: thread fuction, prototype
//                                                void f(void *arg)
//                                  void*      A: argument to thread function
//                                  tprio_t    P: thread prio: HIGH, MEDIUM, LOW
//                                  unsigned   S: stack size (>= 4092)
//
// myThreadStart(), myThreadJoin()  start threading  
// myThreadYield()                  yield calling thread   
// myThreadExit()                   terminate calling thread      
// myThreadSleep(X)                 sleep for X ms , (int X)
//                  
// Macro definitions -----------------------------------------------------------
 
#define mthreadCreate(T,F,A,P,S)    { mqInit();                 \
                                      dispatchInit(0);          \
                                      T = mtNewThread(F,A,P,S); }\
                                    mqAddToQueue(T,0)
#define mthreadJoin()               dispatchTask(JOIN)
#define mthreadYield()              dispatchTask(YIELD)
#define mthreadExit()               { dispatchTask(EXIT); return NULL; }
#define mthreadSleep(X)             dispatchTask(X)

//******************************************************************************
#endif
