#ifndef COMMONDEFS_HEADER_FILE
#define COMMONDEFS_HEADER_FILE

//******************************************************************************
// File:    commondefs.h
// Purpose: common definitions
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Version: v.fs20
//******************************************************************************

//******************************************************************************
// constant values

#define MIN_STACK_SIZE 4096
#define LOW_STACK      1024

//******************************************************************************
// types

// priorities
#define PRIORITY_QUEUES 3
typedef enum tprio { HIGH = 0, MEDIUM = 1, LOW = 2} tprio_t;


// thread function signature: void* function(void *)
typedef void (*tfunc_t)(void *);

//******************************************************************************
#endif

