/******************************************************************************
// Aufgabe:    Testbench for rLine()   
// File:       rltest.c
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

#define STR_LEN  32         // max length of command line arguments

char readBuffer[STR_LEN];   // string buffer: receiving string from pipe   
char writeBuffer[STR_LEN];  // string buffer: sending string to pipe 
                                        

//*****************************************************************************
// Purpose:    use rLine() to read data from pipe and compare with sent data
// Parameters: fd    -> filedescriptor of pipe
//             len   -> length of read buffer 
//             check -> if set, check if written and read data are equal
// Return:     0 if check failed, else number of characters read by rLine()

int doReadLine(int *fd, int len) {
    int rv, rc;
    close(0);                               // close stdin
    close(fd[1]);                           // close writers side of pipe
    dup2(fd[0], 0);                         // connect pipe to stdin
    rc = getLine("", readBuffer, len);      // read one line
    rv = strcmp(readBuffer, writeBuffer);   // compare with sent string
    if (rv != 0) {                          // if strings not equal -> rc = 0
        rc = 0;
    }
    return rc;
}

//*****************************************************************************
// Purpose:    write data to pipe and wait for child to terminate
// Parameters: pid -> process to wait for
//             fd  -> file descriptor of pipe
//             writeBuffersize -> number of characters to write
//             check    -> write if passed or failed
// Return:     exit number of child -> number of read characters  

int sendAndCheck(pid_t pid, int *fd, int writeBuffersize, int check) {
    int status;
    if (pid < 0) {
        perror("fork failed");
        exit(0);
    }
    close(fd[0]);                               // close readers side of pipe         
    write(fd[1], writeBuffer, writeBuffersize); // sent string
    close(fd[1]);                               // close writers side of pipe
    waitpid(pid, &status, 0);                   // wait for child to terminate
    if (check) {
        if (WEXITSTATUS(status) != 0) printf(" passed");
        else                          printf(" failed");
        printf("\n");
    }
    return WEXITSTATUS(status);
}

//*****************************************************************************
// Purpose:     Main program for testing rLine()
// Function:    Since rLine reads from "stdin", one can only send strings
//              to rLine() from software by connecting "stdin" to a file.
//              Here we use a pipe which connects "stdin" of the child process
//              to the readers side and where the parent process writes to
//              the writes side of the pipe.
//              The child process inherits the expected result in writeBuffer 
//              (which first must be modified in certain cases) from its parent
//              process and compares it with the string by rLine(). The 
//              result is returned through exit(X) to parent process. The
//              parent process recieves the result by waitpid() and the macro
//              WEXITSTATUS(status) which then is evaluated.
//
//              "parent" -> pipe 
//                               -> stdin -> "child" -> exit(result)
//               -> "parent" -> waitpid() -> result

int main(void) {
    int   fd[2];
    pid_t pid;
    int   rv;
    int   size = 0;


    printf("\n");

    // test 1 -----------------------------------------------------------------
    // check if zero terminated string is handled correctly 

    printf("Test 1: zero terminated string -> ");
    fflush(stdout);

    pipe(fd);                                   // set up pipe
    strcpy(writeBuffer, "ls -al");              // zero terminated string
    size = strlen(writeBuffer)+1;               // string including '\0'
    
    pid = fork();                               // fork process 
    if (pid == 0) {                             // child
        rv = doReadLine(fd, STR_LEN);           // check with read strings
        exit(rv);
    }
    else {                                      // parent
        sendAndCheck(pid, fd, size, 1);
    }

    // test 2 -----------------------------------------------------------------
    // check if EOL ('\n') terminated string is handled correctly
    pipe(fd);
    printf("Test 2: EOL terminated string  -> ");
    fflush(stdout);
    strcpy(writeBuffer, "ls -a -l\n");
    size = strlen(writeBuffer);

    pid = fork();                                   // fork process 
    if (pid == 0) {                                 // child
        writeBuffer[strlen(writeBuffer)-1] = '\0';  // expected result
        rv = doReadLine(fd, STR_LEN);
        exit(rv);
    }
    else {                                          // parent
        sendAndCheck(pid, fd, size, 1); 
    }


    // test 3 -----------------------------------------------------------------
    // check if EOF is handled (which is crtl-D)

    pipe(fd);
    printf("Test 3: EOF terminated string  -> ");
    fflush(stdout);

    strcpy(writeBuffer, "cat < test.tmp\n"); 
    writeBuffer[strlen(writeBuffer)-3] = EOF;
    size = strlen(writeBuffer);

    pid = fork();                                   // fork process 
    if (pid == 0) {                                 // child
        writeBuffer[strlen(writeBuffer)-3] = '\0';  // expected result
        rv = doReadLine(fd, STR_LEN);
        exit(rv);
    }
    else {                                          // parent
        sendAndCheck(pid, fd, size, 1);
    }

    // test 4 -----------------------------------------------------------------
    // check if buffer does not overflow

    pipe(fd);
    printf("Test 4: buffer overflow check  -> ");
    fflush(stdout);
    strcpy(writeBuffer, "thisisjustalongword\n"); 
    size = strlen(writeBuffer);

    pid = fork();                                   // fork process 
    if (pid == 0) {                                 // child
        writeBuffer[7] = '\0';                      // expected string: 7 chars
        rv = doReadLine(fd, 8);                     // read 7 chars + '\0'
        exit(rv);
    }
    else {                                          // parent
        sendAndCheck(pid, fd, size, 1);
    }


    // test 5 return value check ----------------------------------------------

    int errsum = 0, expect = 0;

    pipe(fd);
    strcpy(writeBuffer, "abc");
    size   = strlen(writeBuffer) + 1;
    expect = strlen(writeBuffer);

    pid = fork();                                   // fork process 
    if (pid == 0) {                                 // child
        rv = doReadLine(fd, STR_LEN);
        exit(rv);
    }
    else {
        rv = sendAndCheck(pid, fd, size, 0);
        errsum += ((expect != rv) && (expect != rv-1)); // compare to expected 
        // note: "rv": if getLine checks for '\0', "rv-1" if it checks not
    }

    pipe(fd);
    strcpy(writeBuffer, "hello world\n");
    size = strlen(writeBuffer);
    expect = size - 1;

    pid = fork();                                   // fork process 
    if (pid == 0) {                                 // child
        writeBuffer[size-1] = '\0';
        rv = doReadLine(fd, STR_LEN);
        exit(rv);
    }
    else {
        rv = sendAndCheck(pid, fd, size, 0);
        errsum += (expect != rv);                   // compare to expected

    }

    pipe(fd);
    strcpy(writeBuffer, "hello world\n");
    writeBuffer[4] = EOF;
    expect = 4;

    pid = fork();                                   // fork process 
    if (pid == 0) {                                 // child
        writeBuffer[4] = '\0';
        rv = doReadLine(fd, STR_LEN);
        exit(rv);
    }
    else {
        rv = sendAndCheck(pid, fd, size, 0);
        errsum += (expect != rv);                   // compare to expected
    }

    if (errsum == 0) strcpy(readBuffer, " passed");
    else             strcpy(readBuffer, " failed");
    printf("Test 5: return value check     -> %s\n\n", readBuffer);

    exit(0);
}

//*****************************************************************************
