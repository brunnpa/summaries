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

#define ITERS 1000

//******************************************************************************

const char *msgs[3] = { "\033[31m one \033[0m", 
                        "\033[32m \ttwo \033[0m",
                        "\033[36m \t\tthree \033[0m" };

int cnts[3] = {0};
int prio[3] = {HIGH, MEDIUM, LOW};
int error   = 0;

double r[2][3] = {{0,0,0}, {0,0,0}};

int iters = ITERS;
int noYield = 0;

//******************************************************************************

void *printMessage(void* ptr);

//******************************************************************************

int main (int argc, char *argv[]) {
    mthread_t   *thread1, *thread2, *thread3;

    printf("argc %d\n",argc);
 
    if (argc > 1 && ((argc == 4) || (argc == 5)) ) {
        prio[0] = atoi(argv[1]); 
        prio[1] = atoi(argv[2]); 
        prio[2] = atoi(argv[3]);
        if (argc == 5) noYield = 1;   
    }

    printf("program main2 starting\n");

    mthreadCreate(thread1, printMessage, (void *)0, prio[0], STACK_SIZE);
    mthreadCreate(thread2, printMessage, (void *)1, prio[1], STACK_SIZE);
    mthreadCreate(thread3, printMessage, (void *)2, prio[2], STACK_SIZE);

    mthreadJoin();

    double sd  = 0.0;
    double si  = 0;

    double pp = (prio[0]+1) * (prio[1]+1) * (prio[2]+1);
    for (int i = 0; i < 3; i++) {
        r[0][i] = pp/((double)(prio[i]+1));
        sd      += r[0][i];
        r[1][i] = (double)cnts[i];
        si      += r[1][i];
    }

    error = 0;
    for (int i = 0; i < 3; i++) {
        r[0][i] /= sd;
        r[1][i] /= si;
        double rel = r[0][i] / r[1][i];
        if (rel < 0.98 || rel > 1.02) error++;
    }
    
    printf("\n\nAnteil Rechenleistung der Threads t0, t1, t2:\n\n");
    printf("gemessen: ");
    printf("%4.2f %4.2f %4.2f\n", r[0][0], r[0][1], r[0][2]);
    printf("erwartet: ");
    printf("%4.2f %4.2f %4.2f\n", r[1][0], r[1][1], r[1][2]);

    //printf("\n%d %d %d\n", cnts[0], cnts[1], cnts[2]);

    char *m1 = "priority scheduling seems faulty @ 2%% error";
    char *m2 = "priority scheduling seems correct @ 2%% error";
    if (error) 
        printf("\n\033[41m*** %s ***\033[0m\n", m1);
    else
        printf("\n\033[42m*** %s ***\033[0m\n", m2);

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

static int stop = 0;

void* printMessage(void* ptr) {             // user defined thread function
    int nr = (int)((long)ptr);
    for (int i = 0; i < iters; i++) {
        if (stop) break;
        cnts[nr]++;
        printf("%s  \n", msgs[nr]);

        if (noYield == 0) mthreadYield();                       // yield
        else              for (int j = 0; j < 500000; j++) {}   // do some work 
    }

    stop = 1;   

    mthreadExit();
}

//******************************************************************************
