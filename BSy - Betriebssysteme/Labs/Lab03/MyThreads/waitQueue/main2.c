//******************************************************************************
// File:    main2.c
// Purpose: demo program for mythreads
// Author:  M. Thaler, 2012, adapted 2017
//          M. Thaler, 2/2019, color output and plausibilty test
// Version: v.fs20
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "mythreads.h"

#define ITERS 100

//******************************************************************************

static const char  *message1 = "\033[36m\t\tlow   \033[0m";           // rot
static const char  *message2 = "\033[32m\tmedium  \033[0m";           // green
static const char  *message3 = "\033[31mhigh      \033[0m";           // cyan

static int checkCounter = 0, threadCounter = 0, errors = 0;

//******************************************************************************

void *printMessage(void* ptr);

//******************************************************************************

int main (void) {
    mthread_t   *thread1, *thread2, *thread3;

    printf("program main2 starting\n");

    mthreadCreate(thread1, printMessage, (void *)message1, LOW,    STACK_SIZE);
    mthreadCreate(thread2, printMessage, (void *)message2, MEDIUM, STACK_SIZE);
    mthreadCreate(thread3, printMessage, (void *)message3, HIGH,   STACK_SIZE);

    mthreadJoin();

    if ((errors > 0) || (threadCounter < 3)) {
        printf("\n\033[41m*** priority scheduling seems faulty ***\033[0m\n");
    } else {
        printf("\n\033[42m*** priority scheduling seems correct ***\033[0m\n");
    }

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void* printMessage(void* ptr) {             // user defined thread function
    char *message;
    unsigned i, j;
    int low, high, localCount;

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

        // atomically fetch and increment global localCounter (gcc built-in)
        localCount = __sync_fetch_and_add(&checkCounter, 1);

        // check if counter is outside its interval
        if (localCount < low || localCount >= high) {
            errors++;mthreadYield();
        }

        printf("%s  \n", message);
        mthreadYield();
        for (j = 0; j < 5000000; j++) {}    // do some work 
    }

    __sync_fetch_and_add(&threadCounter, 1);
    
    mthreadExit();
}

//******************************************************************************
