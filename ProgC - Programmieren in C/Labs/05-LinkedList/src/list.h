/*Header list.h*/
#ifndef LIST_H
#define LIST_H
#include "person.h"



typedef struct ListElement {
    Person *content;
    struct ListElement *next;
}node_LE;

void createHeadElement(void);

void insert(Person *newPerson);

void removePerson(Person *newPerson);
 
void printOutList(void);

void clearList(void);

#endif
