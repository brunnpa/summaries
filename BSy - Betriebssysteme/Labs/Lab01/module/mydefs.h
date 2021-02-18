#ifndef MY_MYDEFS_DEF    /* verhindert Mehrfachdeklarationen */
#define MY_MYDEFS_DEF   

/*******************************************************************************
* Beispiel:   Modulare Programmierung in C (und C++), 
* File:       func1.h
* Fach:       BS 
* Autoren:    J.Zeman, M. Thaler
* Version:    v.fs20 
********************************************************************************
   Diese Datei enthaelt die Deklarationen eigener Datentypen und Konstanten,
   von in mehreren (allen) Programmmodulen benoetigt werden. Die zentrale
   Verwaltung dieser Programmkomponeneten vereinfacht Aenderungen am Programm.

   Diese Datei wird von den Quellcode-Modulen, falls benötigt, mit der 
   "include-Anweisung" eingebunden:

        main.c, func1.c, func2.c, sicherheitshalber auch in func1.h, func2.h

*******************************************************************************/
/* gemeinsame Typen, Konstanten, Macros und globale Variablen-Deklarationen   */

#define my_pi 3.14

typedef float myfloat_t;

// double has 2x more precision as compare than float
// See: https://www.tutorialspoint.com/difference-between-float-and-double-in-c-cplusplus
typedef double mydouble_t;

#endif
