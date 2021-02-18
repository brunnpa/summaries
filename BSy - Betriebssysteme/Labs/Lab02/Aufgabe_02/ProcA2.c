//***************************************************************************
// File:        ProcA2.c
// Author:      M. Thaler
// Revision:    11/2014
// Version:     v.fs20
//***************************************************************************

//***************************************************************************
// system includes
//***************************************************************************

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

//***************************************************************************
// Function: main(), parameter: none
//***************************************************************************

int main(void) {

    pid_t  pid;
    int    status;
    int    i;

    i = 5;

    printf("\n\ni vor fork: %d\n\n", i);

    //pid = Integer-value which returns a negative number if could not fork; zero if newly created child process; positiv number is parent process
    pid = fork(); //creates a child-process which runs concurrently with the parent process. Question: Does the program focus change to the child thread now?
    // Ab sofort wird an dieser Stelle das ganze zweimal ausgeführt (Child und Parten)
    switch (pid) {
      case -1:
        perror("Could not fork");
        break;
      case 0:
        i++;
        printf("\n... ich bin das Kind %d mit i=%d, ", getpid(),i);
        printf("meine Eltern sind %d \n", getppid());
        break;
      default:
        i--;
        printf("\n... wird sind die Eltern %d mit i=%d ", getpid(), i);
        printf("und Kind %d,\n    unsere Eltern sind %d\n", pid, getppid()); //getppid() returns the process id of the parent of the calling process. IF the calling process was created by the fork() function call, this function returns the process ID of the parent process. Otherwise this function returns a value of 1 which is the process id for init process.
        wait(&status);
        break;
    }
    printf("\n. . . . . und wer bin ich ?\n\n");
    exit(0);
}

//***************************************************************************

