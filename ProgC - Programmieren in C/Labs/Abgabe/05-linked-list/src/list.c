#include <stdlib.h>
#include <string.h>
#include "list.h"

bool isEmpty(const ListElement *start) {
    return start == start->next ? true : false;
}

void addElement(Person personToAdd, ListElement *start) {
    ListElement *actual = start->next;
    ListElement *before = start;
    bool found = false;
    while (!found && actual != start) {
        int result = comparePerson(actual->content, personToAdd);
        if (result >= 0) {
            ListElement *elementToAdd = malloc(sizeof(ListElement));
            elementToAdd->content = personToAdd;
            elementToAdd->next = actual;
            before->next = elementToAdd;

            found = true;
            continue;
        }
        before = actual;
        actual = actual->next;
    }
    if (!found) {
        ListElement *elementToAdd = malloc(sizeof(ListElement));
        elementToAdd->content = personToAdd;
        elementToAdd->next = start;
        before->next = elementToAdd;
    }
}

bool removeElement(char name[], char firstname[], unsigned age, ListElement *start) {
    ListElement *actual = start->next;
    ListElement *before = start;
    bool found = false;
    while (!found && actual != start) {
        if (strcmp(actual->content.name, name) != 0 || strcmp(actual->content.firstname, firstname) != 0 ||
            actual->content.age != age) {
            before = actual;
            actual = actual->next;
            continue;
        }
        found = true;
    }
    if (found) {
        before->next = actual->next;
        free(actual);
    }
    return found;
}

void clear(ListElement *start) {
    ListElement *actual = start->next;
    ListElement *next = actual->next;
    start->next = start;

    while (actual != start) {
        free(actual);
        actual = next;
        next = actual->next;
    }
}                      

