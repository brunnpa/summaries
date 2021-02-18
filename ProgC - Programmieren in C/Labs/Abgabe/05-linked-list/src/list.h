#include <stdlib.h>
#include "person.h"

typedef struct LE ListElement;

struct LE {
    Person content;
    ListElement *next;
};

bool isEmpty(const ListElement *start);

void addElement(Person elementToAdd, ListElement *start);

bool removeElement(char name[], char firstname[], unsigned age, ListElement *start);

void clear(ListElement *start);