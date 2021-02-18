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

void newArgv(char *argv[], int length, int pos, int remCount){
    //printf("\n Hier bin ich im newArgv\n");
    if(length < pos + remCount){
        return;
    }
    int i = pos;
    while(i+remCount <= length){
        argv[i] = argv[i+remCount];
        argv[i+remCount] = NULL;
        i++;
    }
}

// !!!! only one token is implemented here 

void tokenizeCommand(char *cmdLine, char *argv[], char *redir[]) {
    //printf("\n Hier bin ich im tokenizeCommand\n");
    const char *errMsg = "\n*** too many arguments ***\n";
    int idx = 0;
    char* token;
    redir[1] = NULL;
    redir[0] = NULL;
    
    token = strtok(cmdLine," \t\n"); 
    argv[idx++] = token;  // get first word
    
    while((token = strtok(NULL, " \t\n"))){
        //printf("\n Hier bin ich in der While-Schlaufe von tokenizeCommand\n");
        argv[idx] = token;
        idx++;
    }
    
    for(int i = 0; i < idx-1; i++){
        //printf("\n Hier bin ich in der For-Schlaufe von tokenizeCommand\n");
        if(strcmp(argv[i], ">") == 0){
            //printf("\n Hier bin ich im ersten If in der For-Schlaufe von tokenizeCommand\n");
            redir[1] = malloc(strlen(argv[i+1])+1);
            strcpy(redir[1], argv[i+1]);
            argv[i+1] = NULL;
            argv[i] = NULL;
            newArgv(argv, idx, i, 2);
            i -= 1;
            idx -= 2;
        }else if(strcmp(argv[i], "<") == 0) {
            //printf("\n Hier bin ich im ersten ElseIf in der For-Schlaufe von tokenizeCommand\n");
            redir[0] = malloc(strlen(argv[i+1])+1);
            strcpy(redir[0], argv[i+1]);
            argv[i+1] = NULL;
            argv[i] = NULL;
            newArgv(argv, idx, i, 2);
            i -= 1;
            idx -= 2;
        }
    }

    if (idx < MAX_ARGV){
        //printf("\n Hier bin ich im zweiten If von tokenizeCommand\n");
        argv[idx] = NULL;                   // terminate argument list by NULL
    } else {
        //printf("\n Hier bin ich im zweiten else von tokenizeCommand\n");
        printf("%s", errMsg);
        argv[0] = NULL;
    }
}

int internalCommand(char *argv[]){
    //printf("\n Nun bin ich im internalCommand angekommen \n");
    if(strcmp(argv[0], "logout") == 0 || strcmp(argv[0], "exit") == 0) {
        exit(0);
    }
    else if(strcmp(argv[0], "cd") == 0) {
        //printf("\n bin im elseIf von internalCommand \n");
        if(argv[1] == NULL){
            printf("Where is the path?\n");
        } else {
            //printf("\n bin im else des elseIf von InternalCommand \n");
            chdir(argv[1]);
        }
        //printf("\n gebe 1 als return value von internalCommand zurück \n");
        return 1;
    }
    //printf("\n gebe 0 als return value von internalCommand zurück \n");
    return 0;
}

//-----------------------------------------------------------------------------
// execute an external command, exit on failure of fork

void externalCommand(char *argv[], char *redir[]) {
    //printf("\n Nun bin ich im externalCommand angekommen \n");
    pid_t PID;                          // process identifier
    if ((PID = fork()) == 0) {          // fork child process
        //printf("\n Bin im if von externalCommand, let's fork it \n");
        if(redir[0] != NULL){
            close(0);
            open((const char*) redir[0], O_RDONLY, 0644);
        }
        if(redir[1] != NULL){
            close(1);
            open((const char*) redir[1], O_CREAT | O_TRUNC | O_WRONLY, 0644);
        }      
        execvp(argv[0],  &argv[0]);     // execute command
        printf("!!! panic !!!\n");      // should not come here
            exit(-1);                   // if we came here ... we have to exit
    }
    else if (PID < 0) {
        printf("fork failed\n");        // fork didn't succeed
        exit(-1);                       // terminate sishell
    }
    else  {                             // here we are parents
        //printf("\n Bin im else von externalCommand, nun heisst es warten \n");
        wait(0);                        // wait for child process to terminate
    }
}

//-----------------------------------------------------------------------------
// execute command if not NULL pointer (invalid or "empty" command)

void executeCommand(char *argv[], char *redir[]) {
    //printf("\n bin im executeCommand angekommen \n");
    int stdinCopy = dup(0);
    int stdoutCopy = dup(1);
    
    int infile;
    int outfile;
    
    if(redir[0] != NULL){
        //printf("\n bin im ersten If im executeCommand \n");
        infile = open(redir[0], O_RDONLY);
        dup2(infile, 0);    
    }
    
    if(redir[1] != NULL){
        //printf("\n bin im zweiten If im executeCommand \n");
        outfile = open(redir[1], O_CREAT | O_TRUNC | O_WRONLY, 0644);
        dup2(outfile, 1);
    }
    
    if (argv[0] != NULL) {
        //printf("\n bin im dritten If im executeCommand \n");
        if(internalCommand(argv) == 0){
            externalCommand(argv, redir);
        }
    }
    
    if(redir[0] != NULL){
        //printf("\n bin im vierten If im executeCommand \n");
        dup2(stdinCopy, 0);
        redir[0] = NULL;
    }
    
    if(redir[1] != NULL){
        //printf("\n bin im fünften If im executeCommand \n");
        dup2(stdoutCopy, 1);
        redir[1] = NULL;
    }
}

//-----------------------------------------------------------------------------
// main program for shell

int main(void) {
    //printf("\n Let's go \n");
    char  *argv[MAX_ARGV];               // pointer to command line arguments
    char  buf[STR_LEN];                  // buffer for command line and command
    char *redir[2];

    while (1) {    
        getLine("si ? ", buf, STR_LEN); // read one line from stdin 
        //printf("\ngetLine wurde gelesen, nun gehe ich ins tokenizeCommand\n");
        tokenizeCommand(buf, argv, redir);      // split command line into tokens
        //printf("\n tokenizeCommand erfolgreicht durchgeführt, nun gehe ich ins executeComman\n");
        executeCommand(argv, redir);            // execute command
        //printf("\n executeCommand wurde erfolgreich durchgeführt - juhu :-) \n");
    }      
    exit(0);
}

//*****************************************************************************
