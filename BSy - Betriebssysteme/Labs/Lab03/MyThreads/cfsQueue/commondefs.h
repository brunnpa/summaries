#ifndef COMMONDEFS_HEADER_FILE
#define COMMONDEFS_HEADER_FILE

//******************************************************************************
// File:     commondefs.h
// Purpose:  common definitions 
// Author:   M. Thaler, 2012
//           tha, 1/2014, 5/2019
// Version:  v.fs20
//******************************************************************************
// constant values

#ifdef __linux
    #define MIN_STACK_SIZE   (8*1024)
#endif

#ifdef __APPLE__
    #define MIN_STACK_SIZE  (16*1024)
#endif

#define STACK_SIZE  MIN_STACK_SIZE
#define LOW_STACK   (2*1024)

#define VR_DEFAULT (1000.0f)

//******************************************************************************
// priorities

#define NUM_PRIO_QUEUES 3
typedef enum tprio { HIGH = 0, MEDIUM = 1, LOW = 2} tprio_t;

//******************************************************************************
// types

// thread function signature: void* function(void *)
typedef void* (*tfunc_t)(void *);

//******************************************************************************
#endif

