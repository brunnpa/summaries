/*******************************************************************************
* Beispiel:   Modulare Programmierung in C (und C++), 
* File:       func2.c
* Fach:       BSy
* Autoren:    J.Zeman, M. Thaler
* Version:    v.fs20
*******************************************************************************/

#include <math.h>
#include "mydefs.h"
#include "func2.h"

mydouble_t umfang(mydouble_t radius) {
   return (2 * M_PI * radius);
}
