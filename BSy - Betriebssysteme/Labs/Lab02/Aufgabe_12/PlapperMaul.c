/*********************************************************************
* File:     PlapperMaul.c
* Aufgabe:  plappern
* Autor:    M. Thaler
* Datum:    Rev. 11/2014
* Version:  v.fs20
*********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

//--------------------------------------------------------------------

int main(void) {
    
    while (1) {
        printf("Hallo, ich bins....  Pidi %d\n", getpid());
        usleep(500000);
    }
}

//--------------------------------------------------------------------
