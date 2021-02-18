//******************************************************************************
// File:    main4.c
// Purpose: demo program for mythreads: sleeping threads
// Author:  M. Thaler, 2012, adapted 2017, 2018 
// Version: v.fs20
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>

#include "mythreads.h"

#define ITERS   300
#define TICTACS  10

//******************************************************************************
time_t tictacTime = 0;
int shortSleeperCount = 0;
//******************************************************************************

void *printMessage(void *ptr);
void *printMessageSleep(void *ptr);
void *printMessageShortSleeper(void *ptr);

//******************************************************************************

int main (void)
{
    mthread_t   *thread1, *thread2, *thread3;
    const char  *msg1 = "Hello";
    const char  *msg2 = "\tWorld";


    printf("program main4 starting\n");

    mthreadCreate(thread1, printMessage, (void *)msg1, HIGH, STACK_SIZE);
    mthreadCreate(thread2, printMessageSleep, (void *)msg2, HIGH, STACK_SIZE);
    mthreadCreate(thread3, printMessageShortSleeper, NULL, HIGH, STACK_SIZE);

    mthreadJoin();

    if (tictacTime < TICTACS) {
        printf("\n\n\t*********************************************\n");
        printf("\t*** your scheduler does not work properly ***\n");
        printf("\t*********************************************\n\n");
    }

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void *printMessage(void* ptr) {              // user defined thread function
    char *message;
    unsigned i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    shortSleeperCount++;
    mthreadSleep(4000);
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

//******************************************************************************

void *printMessageSleep(void* ptr) {         // user defined thread function

    char *message;
    unsigned i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    shortSleeperCount++;
    mthreadSleep(2000);
    printf("-> thread %s sleeping for 2s\n", message);
    mthreadSleep(1000);

    tictacTime = time(NULL);
    for (i = 0; i < TICTACS; i++) {
        if (!(i%2))
            printf(" -> tic\n");
        else
            printf(" -> tac\n");
        mthreadSleep(1000);
    }
    tictacTime = time(NULL) - tictacTime;
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

//******************************************************************************
// Message must be displayed before all other threads are sleeping

unsigned int getTime(void);

void *printMessageShortSleeper(void *ptr) {
    unsigned int dt   = getTime();
    unsigned int time = 100;
    mthreadSleep(time);
    dt = getTime() - dt;
    if (shortSleeperCount > 0) {
        printf("\n\nYou should not be able to read the following message:\n\n");
        printf("    I slept for %dms and you kept me waiting for %dms!\n\n\n",
                                                                      time, dt);
    }
    mthreadExit();
}


unsigned int getTime(void) {
    static int    firstCall = 1;
    static struct timeval startTime;

    struct timeval currentTime;
    unsigned time;

    if (firstCall) {
        gettimeofday(&startTime, NULL);
        firstCall = 0;
    }

    gettimeofday(&currentTime, NULL);
    time = (unsigned int)((currentTime.tv_sec  - startTime.tv_sec)*1000 + 
                         (currentTime.tv_usec - startTime.tv_usec)/1000);
    return time;
}

//******************************************************************************

