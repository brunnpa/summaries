#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "list.h"
#include "person.h"

static node_LE *head;

/*
creates the first element (head) in the list
It is initialized with content = NULL 
and the next-point shows it self
*/
void createHeadElement(void){
    head = malloc(sizeof(node_LE));
    if(head) {
        head->content = NULL; 
        head->next = head;
    }
    else {
        printf("[FAILED]...The head-element couldn't be created\n");
    }
}

/* 
@param Person to insert
Insert takes over ownership  
*/
void insert(Person *newPerson) {
    node_LE *current = head;


    while(current->next->content != NULL) {
        if(comparePersons(newPerson, current->next->content) > 0) {
            current = current->next;
        }
        else {
            break;
        }
    }
    if(current->next->content == NULL) {
        node_LE *new = malloc(sizeof(node_LE));
        if(new) {
            new->content = newPerson;
            new->next = current->next;
            current->next = new;
            printf("[SUCCESS]...Person has been saved successfully\n");
            printf("\n");
        }
    }
    else if(comparePersons(newPerson, current->next->content) != 0) {
        node_LE *new = malloc(sizeof(node_LE));
        if(new) {
            new->content = newPerson;
            new->next = current->next;
            current->next = new;
            printf("[SUCCESS]...Person has been saved successfully\n");
            printf("\n");
        }
        else {
            printf("[FAILED]...You didn't get enough space...");
            printf("\n");
        }
    }
    else if(comparePersons(newPerson, current->next->content) == 0) {
        printf("[FAILED]...The person is already in the list");
        printf("\n");
    }
    
    /*
    if(current->next->content != NULL) {
        while(comparePersons(newPerson, current->next->content) > 0) {
            if(current->next->next->content != NULL) {
                current = current->next;
            }
        }
        if(current->next->content == NULL) {
            node_LE *new = malloc(sizeof(node_LE));
            if(new) {
                new->content = newPerson;
                new->next = current->next;
                current->next = new;
            }
        }
        else if(comparePersons(newPerson, current->next->content) != 0) {
            node_LE *new = malloc(sizeof(node_LE));
            if(new) {
                new->content = newPerson;
                new->next = current->next;
                current->next = new;
                printf("[SUCCESS]...Person has been saved successfully\n");
                printf("\n");
            }
            else {
                printf("[FAILED]...You didn't get enough space...");
            }
        }
        else if(comparePersons(newPerson, current->next->content) == 0) {
            printf("[FAILED]...The person is already in the list");
        }
    }
    else if (current->next->content == NULL){
        node_LE *new = malloc(sizeof(node_LE));
        
        if(new){
            new->content = newPerson;
            new->next = current->next;
            current->next = new;
            printf("[SUCCESS]...The first Person has been saved successfully\n");
            printf("\n");
        }
    }*/
    

}

/*
@param -> Person to remove
If the person is in the list, name, firstname and age needs to be equal
the person is going to remove from the list
RemovePerson is also responsible to free() the person space
*/
void removePerson(Person *personToRemove){
    
    node_LE *current = head;
    
    
    while(current->next->content != NULL && (comparePersons(current->next->content, personToRemove)) != 0){
        current = current->next;
    }
    if(current->next->content != NULL) {
    
        node_LE *toRemove = current->next;
        current->next = toRemove->next;

        free(toRemove->content);
        free(toRemove); 
        printf("[SUCCESS]...Person has been successfully removed\n");
        printf("\n");
    }
    else if(current->next->content == NULL){
        printf("[FAILED]...This person is not in the list\n");
        printf("\n");
    }
    free(personToRemove);
    
    printf("\n");
}

//Prints out the whole list, without the head-element
void printOutList(void) {
    node_LE *current = head;
    
    if(current->next == current){
        printf("[EMPTY]...The list is empty\n");
        printf("\n");
    }
    
    while(current->next->content != NULL) {
        if(current->next->content != NULL) {
            printf("Name: %s \n", current->next->content->name);
            printf("Firstname: %s \n", current->next->content->firstname);
            printf("Age: %u \n", current->next->content->age);
            printf("-----------------------------------\n");
        }
        current = current->next;
    }
}

//Clears the whole list, without the head-element
void clearList(void){
    node_LE *current = head;
    
    while(current->next->content != NULL){
    
            node_LE *toRemove = current->next;
            current->next = toRemove->next;

            free(toRemove->content);
            free(toRemove); 
    }
}



