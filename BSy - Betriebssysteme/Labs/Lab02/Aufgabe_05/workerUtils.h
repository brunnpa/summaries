//*******************************************************************
// Author:	    M. Thaler
// Revision:	11/2014
// Purpose:	    helper applications to consume cpu time
// Version:     v.fs20
//*******************************************************************

#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/time.h>
#include <stdio.h>

//------------------------------------------------------------------------------
#define MAX_CPUS    16
//------------------------------------------------------------------------------

void launchWorkLoad();

void stopWorkLoad();

void setRandom(void);

void justWork(unsigned int load);

void workHard(unsigned int low, unsigned int high);

void randomSleep(unsigned int low, unsigned int high);

pid_t startWorker(void);

void stopWorker(pid_t worker);
