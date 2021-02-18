//******************************************************************************
// File:    main1.c
// Purpose: demo program for mythreads: Hello World (2 threads)
// Author:  M. Thaler, 2012
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "mythreads.h"

#define ITERS 100

//******************************************************************************

void* printMessage(void* ptr);

//******************************************************************************

int main (void)
{
    mthread_t   *thread1, *thread2, *thread3;
    const char  *message1 = "Hello";
    const char  *message2 = "\tWorld";
    const char  *message3 = "\t\tfrom mthreads";

    printf("program main1 starting\n");

    mthreadCreate(thread1, printMessage, (void *)message1, HIGH, STACK_SIZE);
    mthreadCreate(thread2, printMessage, (void *)message2, HIGH, STACK_SIZE);
    mthreadCreate(thread3, printMessage, (void *)message3, HIGH, STACK_SIZE);

    mthreadJoin();

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void* printMessage(void* ptr)                // user defined thread function
{
    char *message;
    unsigned i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

//******************************************************************************

