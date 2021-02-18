#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "person.h"
#include "list.h"

/* TODO
    - Überprüfung ob Eingabe NULL
*/

/*
@param Person1
@param Person2
@return result as an Integer

compares two person and returns a value <0 || 0 || >0
*/
int comparePersons(Person *person1, Person *person2){

    int result;
    
    result = strcmp(person1->name, person2->name);
    if(result != 0) {
        return result;
    }
    
    result = strcmp(person1->firstname, person2->firstname);
    if(result != 0){
        return result;
    }
    
    result = person1->age - person2->age;
    return result;
    
    /* erster Entwurf - würde auch gehen, aber eher unschön, da sehr tiefverschachtelt.
    Daher die "Early-Return"-Methode bevorzugen (siehe Umsetzung oben)
    if((strcmp(person1->name, person2->name)) == 0) {
        if((strcmp(person1->firstname, person2->firstname == 0) {
            if(person1->age == person2->age) {
                return 0;
            }
            else {
                return 0;
            }
        }
        else {
            return 1;
        }
    }
    else {
        return 1;
    }*/
}

Person *readPerson(void) {
    
    Person *person = malloc(sizeof(Person));
    
    printf("Please enter the name of the new person - max Size: 19\n");
    while(scanf("%19s", person->name) != 1) {
		printf("The Input can't be empty\n");
    }    
    //clears the input Buffer
    while((getchar()) != '\n');
    
    printf("Please enter the firstname of the new person - max Size: 19\n");
    while(scanf("%19s", person->firstname) != 1) {
        printf("The Input can't be empty\n");
    }
    //clears the input Buffer
    while((getchar()) != '\n');
    
    printf("Please enter the age of the new person\n");
    while(scanf("%u", &(person->age)) != 1) {
        printf("The Input can't be empty\n"); 
    }
    //clears the input Buffer
    while((getchar()) != '\n');
    
    return person;
}












