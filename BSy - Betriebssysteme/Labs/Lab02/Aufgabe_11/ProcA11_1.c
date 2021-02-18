//***************************************************************************
// File:        ProcA11_1.c  
// Author:      M. Thaler
// Revision     11/2014
// Version:     v.fs20
//***************************************************************************

//***************************************************************************
// system includes
//***************************************************************************

#include <sys/types.h>
#include <sys/wait.h>
#include <sys/times.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <assert.h>

#include "workerUtils.h"

#define WORK_LOAD (500*1000)
#define FORKS     1000

//***************************************************************************
// Function: main(), parameter: shell command in "..."
//***************************************************************************

int main(int argc, char *argv[]) {

    struct tms    startT, endT;
    clock_t       StartTime, EndTime;
    double        Zeit, ticks, usr, sys;
    int           i, j, load;
    pid_t         pid;

    if (argc > 1)
        load = atoi(argv[1]);
    else
        load = 0;
    if (load > 0)
        launchWorkLoad();

    ticks = sysconf(_SC_CLK_TCK);

    StartTime = times(&startT);
    for (i = 0; i < FORKS; i++) {
        pid = fork();
        if (pid == 0) {
            for (j = 0; j < WORK_LOAD; j++) {};
            exit(0);
        }
        else if (pid > 0)
            wait(NULL);      
        else
            assert(pid >= 0);
    }
    
    for (i = 0; i < FORKS; i++) {
        for (j = 0; j < WORK_LOAD; j++) {};
    }

    EndTime = times(&endT);

    Zeit = (double)(EndTime - StartTime) / ticks;
    usr  = (double)(endT.tms_utime - startT.tms_utime) / ticks;
    sys  = (double)(endT.tms_stime - startT.tms_stime) / ticks;

    printf("\nElapsed:\t\t\t%4.3f\n", Zeit);
    printf("User CPU-time:\t\t\t%4.3f\n", usr);
    printf("System CPU-time:\t\t%4.3f\n", sys);

    if (load > 0)
        stopWorkLoad();

    exit(0);
}

//***************************************************************************

