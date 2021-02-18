/******************************************************************************
// Aufgabe:    Simple Shell   
// File:       sishell.c
// Fach:       Betriebssysteme
// Autor:      M. Thaler
// Version:    v.fs20
******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h> 
#include <sys/wait.h>

#include "getLine.h"

//*****************************************************************************

#define MAX_ARGV  16                    // max number of command line arguments
#define STR_LEN  255                    // max length of command line arguments

#define TESTING 0 //Change to 1 if you want to print Testlines

//*****************************************************************************
// split command line into tokens and store tokens -> argv[]

// !!!! only one token is implemented here 

void tokenizeCommand(char *cmdLine, char *argv[]) {
    const char *errMsg = "\n*** too many arguments ***\n";
    int idx = 0;
    char* token;
    
    token = strtok(cmdLine," \t\n"); 
    argv[idx++] = token;  // get first word
    
    while((token = strtok(NULL, " \t\n"))){
        argv[idx] = NULL;
        idx++;
    }
    argv[idx] = NULL;    
    

    if (idx < MAX_ARGV)
        argv[idx] = NULL;                   // terminate argument list by NULL
    else {
        printf("%s", errMsg);
        argv[0] = NULL;
    }
}

//-----------------------------------------------------------------------------
// execute an external command, exit on failure of fork

void externalCommand(char *argv[]) {
    pid_t PID;                          // process identifier
    if ((PID = fork()) == 0) {          // fork child process
        execvp(argv[0],  &argv[0]);     // execute command
        printf("!!! panic !!!\n");      // should not come here
            exit(-1);                   // if we came here ... we have to exit
    }
    else if (PID < 0) {
        printf("fork failed\n");        // fork didn't succeed
        exit(-1);                       // terminate sishell
    }
    else  {                             // here we are parents
        wait(0);                        // wait for child process to terminate
    }
}

//-----------------------------------------------------------------------------
// execute command if not NULL pointer (invalid or "empty" command)

void executeCommand(char *argv[]) {
    if (argv[0] != NULL) {
        externalCommand(argv);
    }
}

//-----------------------------------------------------------------------------
// main program for shell

int main(void) {
    char  *argv[MAX_ARGV];               // pointer to command line arguments
    char  buf[STR_LEN];                  // buffer for command line and command

    while (1) {    
        int test = getLine("si ? ", buf, STR_LEN); // read one line from stdin 
        if(TESTING == 1){
            printf("***TESTING***\n");
            printf("Anzahl Zeichen %i \n", test);
        }
        tokenizeCommand(buf, argv);      // split command line into tokens
        executeCommand(argv);            // execute command
    }      
    exit(0);
}

//*****************************************************************************
