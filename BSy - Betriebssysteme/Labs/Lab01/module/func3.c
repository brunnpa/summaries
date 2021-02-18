#include <math.h>
#include "mydefs.h"
#include "func3.h"

mydouble_t volumen(mydouble_t radius) {
    return ((4.0/3.0) * M_PI * radius * radius * radius);
}