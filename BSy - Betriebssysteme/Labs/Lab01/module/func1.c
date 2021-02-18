/*******************************************************************************
* Beispiel:   Modulare Programmierung in C (und C++), 
* File:       func1.c
* Fach:       BSy 
* Autoren:    J.Zeman, M. Thaler
* Version:    v.fs20
*******************************************************************************/
#include <math.h>
#include "mydefs.h"
#include "func1.h"


mydouble_t flaeche(int radius) {
   return (M_PI * radius * radius);
}
