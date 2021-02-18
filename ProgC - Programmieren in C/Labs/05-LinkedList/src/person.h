/*Header person.h*/
#ifndef PERSON_H
#define PERSON_H


typedef struct {
    char name[20];
    char firstname[20];
    unsigned age;
} Person;

//returns 1 if the person are different
int comparePersons(Person *person1, Person *person2);


Person *readPerson(void);

#endif
