#include <stdlib.h>

typedef enum {
    false, true
}
bool;

typedef struct {
    char name[20];
    char firstname[20];
    unsigned age;
} Person;

size_t compareStringLength(char str1[], char str2[]);

int comparePerson(Person p1, Person p2);