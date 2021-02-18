#include <stdlib.h>
#include <string.h>
#include "person.h"

size_t compareStringLength(char str1[], char str2[]) {
    size_t strLength1 = strlen(str1);
    size_t strLength2 = strlen(str2);
    size_t strCompareResult = 0;
    if (strLength1 > strLength2) {
        strCompareResult = strLength2;
    } else {
        strCompareResult = strLength1;
    }
    return strCompareResult;
}

int comparePerson(Person p1, Person p2) {
    int returnValue = 1;
    int length = compareStringLength(p1.name, p2.name);
    int result = strncmp(p1.name, p2.name, length);
    returnValue = result;
    if (result == 0) {
        length = compareStringLength(p1.firstname, p2.firstname);
        result = strncmp(p1.name, p2.name, length);
        returnValue = result;
        if (result == 0) {
            returnValue = p1.age - p2.age;
        }
    }
    return returnValue;
}
