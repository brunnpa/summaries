/******************************************************************************
// File:    getLine.c
// Fach:    BSy
// Autor:   M. Thaler
// Version: v.fs20
******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "getLine.h"

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

/*****************************************************************************/
