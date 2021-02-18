#ifndef MY_FUNC1_DEF    /* verhindert Mehrfachdeklarationen */
#define MY_FUNC1_DEF   

/*******************************************************************************
* Beispiel:   Modulare Programmierung in C (und C++), 
* File:       func1.h
* Fach:       BSy 
* Autoren:    J.Zeman, M. Thaler
* Version:    v.fs20
*******************************************************************************

    Diese Header-Datei enthaelt die Deklaration(nen) der Funktion(nen), die
    das Modul func1.c exportiert: die Funktion "flaeche".
    Sie muss mit der "include-Anweisung" in folgende Module implementiert
    werden:
        a) "func1.c": Funktionsimplementierung
        b) "main.c" : Verwendung der Funktion
    Damit wird sichergestellt, dass die Funktionssignatur konsistent ist und
    die Typenüberprüfung der Paramter und des Rückgabewertes bei der Compilation    
    garantiert ist.

*******************************************************************************/


#include "mydefs.h"

/*----------------------------------------------------------------------------*/

mydouble_t flaeche(int);

/*----------------------------------------------------------------------------*/

#endif
