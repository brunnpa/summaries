//******************************************************************************
// File:    main5.c
// Purpose: demo program for mythreads: Hello World (2 threads)
// Author:  M. Thaler, 2012
//          M. Thaler, 2/2019, color output and plausibilty test
// Version: v.fs20
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "mythreads.h"

#define ITERS 1000

//******************************************************************************

static const char  *message1 = "Hello";
static const char  *message2 = "\tWorld";
static const char  *message3 = "\t\tGruezi";

static int globalCounter = 0, schedCount = 0;

//******************************************************************************

void* printMessage1(void* ptr);

//******************************************************************************

int main (void) {
    mthread_t   *thread1, *thread2;

    printf("program main5 starting\n");

    mthreadCreate(thread1, printMessage1, (void *)message1, HIGH,   STACK_SIZE);
    mthreadCreate(thread1, printMessage1, (void *)message2, MEDIUM, STACK_SIZE);
    mthreadCreate(thread2, printMessage1, (void *)message3, LOW,    STACK_SIZE);

    mthreadJoin();

    if (schedCount > 0) {
        printf("\n\033[42m*** dynamic scheduling seems correct ***\033[0m\n");
    } else {
        printf("\n\033[41m*** dynmaic scheduling seems faulty ***\033[0m\n");        
    }

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void* printMessage1(void* ptr) {              // user defined thread function
    char *message;
    unsigned i, j;
    int low, high, localCounter;

    message = (char*) ptr;

    // set counter intervals according to priority
    if (message == message1) {
        low  = 2*ITERS;
        high = 3*ITERS;
    } else if (message == message2) {
        low  = 1*ITERS;
        high = 2*ITERS;
    } else {
        low  = 0;
        high = ITERS;
    }

    for (i = 0; i < ITERS; i++) {
        // atomically fetch and increment local counter (gcc built-in)
        localCounter = __sync_fetch_and_add(&globalCounter, 1);
        // check if local counter is outside its interval
        if (localCounter < low || localCounter >= high) {
            schedCount++;
        }
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

//******************************************************************************

