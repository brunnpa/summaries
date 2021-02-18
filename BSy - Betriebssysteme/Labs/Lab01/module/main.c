/*******************************************************************************
* Beispiel:   Modulare Programmierung in C (und C++), 
* File:       main.c
* Fach:       BSy
* Autoren:    J.Zeman, M. Thaler
* Version:    v.fs20
*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mydefs.h"   /* Headerdatei mit eigenen Typen und Konstante */
#include "func1.h"    /* Headerdatei fuer Modul func1.c   */
#include "func2.h"    /* Headerdatei fuer Modul func2.c   */
#include "func3.h"    /* Headerdatei fuer Modul func3.c   */

/*----------------------------------------------------------------------------*/
/* Funktionsprototypen: (lokale Funktionen in diesem Modul)                   */

void eingabe(mydouble_t *x);

/*----------------------------------------------------------------------------*/
/* Hauptprogramm                                                              */

int main(void) {
    mydouble_t R, F, U, V;

    eingabe(&R);
    printf("\n\n Kreisberechnung");
    printf(" (berechnet mit pi = %lf)\n", M_PI);  /* aus mydefs.h */
    U = umfang(R);
    F = flaeche(R);
    V = volumen(R);
    printf("\n Radius =\t%lf \n Umfang =\t%lf \n Flaeche =\t%lf\n Volumen =\t%lf\n", R , U, F, V);
    getchar(); getchar();                       /* dummy input -> warte hier */
    exit(0);
}

/*----------------------------------------------------------------------------*/
/* lokale Funktion                                                            */

void eingabe(mydouble_t *x) {
    printf("\n Kreisberechnung: Radius = ? ");
    scanf("%lf", x);
}

/*----------------------------------------------------------------------------*/
