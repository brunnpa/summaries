# BSY Lab04 - Abgabe Martin, Ponbauer, David Lüscher, Pascal Brunner

## Aufgabe 1 - GetLine()
```
/*****************************************************************************/
/* getLine() reads a line or at most count-1 characters from stdin into the  */
/* buffer buf, returns the number of characters (! must be <= count-1        */

int getLine(const char *prompt, char *buf, int count) {
    const char *errorMessage = "\n --- Buffer overflow --- \n";
    
    char ch;
    int position = 0;
    
    // Ausgabe prompt-String
    printf("%s", prompt);
    
    while(position < count - 1){
        ch = getchar();
        
        // Falls Newline oder End of File, return position -> entspricht anzahl character
        if(ch == '\n' || ch == EOF){
            buf[position] = '\0';
            return position;
        } else{
            buf[position] = ch;
            position++;
        }
        
        //Ausgabe ErrorMessage
        if((ch != '\n' || ch != EOF) && position == count-1){
            printf("%s", errorMessage);
            buf[position] = ch;
            return position;
        }
        
    }
    return position;
}
```
### Testing GetLine()
![alt text](https://github.zhaw.ch/brunnpa7/BSY/blob/master/Lab04/img/TestingAufgabeGetLine.png "Testing GetLine")

## Aufgabe 2 - Die SiShell
```
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
```
### Eingabe von find in Shell
![alt text](https://github.zhaw.ch/brunnpa7/BSY/blob/master/Lab04/img/SiShellFind.png "Testing GetLine")

## Aufgabe 3 - MiShell

### neue Methode newArgv
```
void newArgv(char *argv[], int length, int pos, int remCount){
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
```
### Anpassung tokenizeCommand
```
void tokenizeCommand(char *cmdLine, char *argv[], char *redir[]) {
    const char *errMsg = "\n*** too many arguments ***\n";
    int idx = 0;
    char* token;
    redir[1] = NULL;
    redir[0] = NULL;
    
    token = strtok(cmdLine," \t\n"); 
    argv[idx++] = token;  // get first word
    
    while((token = strtok(NULL, " \t\n"))){
        argv[idx] = token;
        idx++;
    }
    
    for(int i = 0; i < idx-1; i++){
        if(strcmp(argv[i], ">") == 0){
            redir[1] = malloc(strlen(argv[i+1])+1);
            strcpy(redir[1], argv[i+1]);
            argv[i+1] = NULL;
            argv[i] = NULL;
            newArgv(argv, idx, i, 2);
            i -= 1;
            idx -= 2;
        }else if(strcmp(argv[i], "<") == 0) {
            redir[0] = malloc(strlen(argv[i+1])+1);
            strcpy(redir[0], argv[i+1]);
            argv[i+1] = NULL;
            argv[i] = NULL;
            newArgv(argv, idx, i, 2);
            i -= 1;
            idx -= 2;
        }
    }

    if (idx < MAX_ARGV)
        argv[idx] = NULL;                   // terminate argument list by NULL
    else {
        printf("%s", errMsg);
        argv[0] = NULL;
    }
}
```
### neue Methode internalCommand
```
int internalCommand(char *argv[]){
    if(strcmp(argv[0], "logout") == 0 || strcmp(argv[0], "exit") == 0) {
        exit(0);
    }
    else if(strcmp(argv[0], "cd") == 0) {
        if(argv[1] == NULL){
            printf("Where is the path?");
        } else {
            chdir)agrv[1]);
        }
        return 1;
    }
    return 0;

}
```

### Anpassung executeCommand
```
void executeCommand(char *argv[], char *redir[]) {
    int stdinCopy = dup(0);
    int stdoutCopy = dup(1);
    
    int inFile;
    int outFile;
    
    if(redir[0] != NULL){
        inFile = open(redir[0], O_RDONLY);
        dup2(inFile, 0);    
    }
    
    if(redir[1] != NULL){
        outFile = open(redir[1], O_CREAT | O_TRUNC | O_WRONLY, 0644);
        dup2(outfile, 1);
    }
    
    if (argv[0] != NULL) {
        if(internalCommand(argv) == 0){
            externalCommand(argv);
        }
    }
    
    if(redir[0] != NULL){
        dup2(stdinCopy, 0);
        redir[0] = NULL;
    }
    
    if(redir[1] != NULL){
        dup2(stdoutCopy, 1);
        redir[1] = NULL;
    }
}
```
### Anpassung externalCommand
```
void externalCommand(char *argv[], char *redir[]) {
    pid_t PID;                          // process identifier
    if ((PID = fork()) == 0) {          // fork child process
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
        wait(0);                        // wait for child process to terminate
    }
}
```
### Output dlist.txt
```
insgesamt 88
drwxr-xr-x 2 pascalbrunner pascalbrunner  4096 Apr 18 11:03 .
drwxr-xr-x 6 pascalbrunner pascalbrunner  4096 Mai 15  2019 ..
-rw-r--r-- 1 pascalbrunner pascalbrunner     0 Apr 18 11:03 dlist.txt
-rw-r--r-- 1 pascalbrunner pascalbrunner  1437 Apr 12 18:55 getLine.c
-rw-r--r-- 1 pascalbrunner pascalbrunner   450 Sep  5  2019 getLine.h
-rw-r--r-- 1 pascalbrunner pascalbrunner  6592 Apr 12 18:55 getLine.o
-rw-r--r-- 1 pascalbrunner pascalbrunner   423 Sep  5  2019 makefile
-rwxr-xr-x 1 pascalbrunner pascalbrunner 18680 Apr 18 11:03 MiShell.e
-rw-r--r-- 1 pascalbrunner pascalbrunner  7165 Apr 18 11:03 siShell.c
-rwxr-xr-x 1 pascalbrunner pascalbrunner 17680 Apr 12 19:20 SiShell.e
-rw-r--r-- 1 pascalbrunner pascalbrunner 12192 Apr 18 11:03 siShell.o

```

### Output tmp.txt
```
        ch = getchar();

```

## Aufgabe 4 - Die "readline" Bibliothek

### Einbinden der Header-Files
```
#include <readline/readline.h>
#include <readline/history.h>
```

### Anpassungen im main
```
int main(void) {
    //printf("\n Let's go \n");
    char  *argv[MAX_ARGV];               // pointer to command line arguments
    char  *buf;                  // buffer for command line and command
    char *redir[2];

    while (1) {    
        buf = readline("si ? "); // read one line from stdin 
        if(strlen(buf) > 0){
            add_history(buf);
            if(!history_is_stifled()) stifle_history(100);
        }
        tokenizeCommand(buf, argv, redir);      // split command line into tokens
        executeCommand(argv, redir);            // execute command
        free(buf);                              // readline malloc's a new buffer every time.
    }      
    exit(0);
}
```

### Test ob File-Ausgabe gemäss Aufgabe 3 funktioniert
```
insgesamt 124
drwxr-xr-x 2 pascalbrunner pascalbrunner  4096 Apr 18 11:31 .
drwxr-xr-x 6 pascalbrunner pascalbrunner  4096 Mai 15  2019 ..
-rw-r--r-- 1 pascalbrunner pascalbrunner  1515 Apr 18 11:15 getLine.c
-rw-r--r-- 1 pascalbrunner pascalbrunner   450 Sep  5  2019 getLine.h
-rw-r--r-- 1 pascalbrunner pascalbrunner  7160 Apr 18 11:16 getLine.o
-rw-r--r-- 1 pascalbrunner pascalbrunner   433 Apr 18 11:09 makefile
-rwxr-xr-x 1 pascalbrunner pascalbrunner 18680 Apr 18 11:03 MiShell.e
-rwxr-xr-x 1 pascalbrunner pascalbrunner 24176 Apr 18 11:30 MiShellMaBelle.e
-rw-r--r-- 1 pascalbrunner pascalbrunner  7087 Apr 18 11:30 siShell.c
-rwxr-xr-x 1 pascalbrunner pascalbrunner 17680 Apr 12 19:20 SiShell.e
-rw-r--r-- 1 pascalbrunner pascalbrunner 21216 Apr 18 11:30 siShell.o
-rw-r--r-- 1 pascalbrunner pascalbrunner     0 Apr 18 11:31 testMaBell.txt
```
