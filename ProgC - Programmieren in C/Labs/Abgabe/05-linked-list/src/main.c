#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> // import for tolower() function
#include "list.h"

void readNextLine(char container[], size_t size) {
    size_t index = 0;
    char c = getchar();
    while (c != '\n') {
        if (index < size - 1) {
            container[index] = c;
            index++;
        }
        c = getchar();
    }
    container[index] = '\0';
}

bool readAge(unsigned *container) {
    bool correct = true;
    char input;
    unsigned output = 0;
    while ((input = getchar()) != '\n') {
        if (input > '9' || input < '0') {
            correct = false;
            continue;
        }
        output *= 10;
        output += input - '0';
    }
    if (correct) {
        *container = output;
    }
    return correct;
}

void readPerson(char name[], char firstname[], unsigned *age) {
    printf("\nLastname: ");
    readNextLine(name, 20);
    printf("\nFirstname: ");
    readNextLine(firstname, 20);
    printf("\nAge: ");
    while (!readAge(age)) {
        printf("\nPlease enter a valid age\n");
    }
}

void requestPersonInput(ListElement *personList) {
    Person *person = malloc(sizeof(Person));
    readPerson(person->name, person->firstname, &(person->age));

    addElement(*person, personList);
    free(person);
}

void printPersonList(ListElement *start) {
    if (isEmpty(start)) {
        printf("\n--> The list is empty\n");
        return;
    }
    ListElement *tmp = start;
    do {
        tmp = tmp->next;
        printf("\n%s %s, %u", (tmp->content).name, (tmp->content).firstname,
               (tmp->content).age);
    } while (tmp->next != start);
}

void requestPersonRemoval(ListElement *start) {
    if (isEmpty(start)) {
        printf("\n--> The list is empty\n");
    } else {
        printf("\nPlease enter the following information to create a new person:\n");

        char name[20];
        char firstname[20];
        unsigned age;

        readPerson(name, firstname, &age);

        bool wasRemoved = removeElement(name, firstname, age, start);
        if (wasRemoved) {
            printf("\n--> The person was successfully deleted!\n");
        } else {
            printf("\n--> Person not found!\n");
        }
    }
}

int main(void) {
    ListElement *personList = malloc(sizeof(ListElement));
    personList->next = personList;
    bool continueApplication = true;

    // The application continues as long as the user does not enter 'E' or 'e'
    while (continueApplication) {
        printf("\nI(nsert), R(emove), S(how), C(lear), E(nd):");

        // Read next character from command line
        char inputChar = getchar();

        //
        bool isInputCorrect = true;

        // Read next char from stdin
        char remain = getchar();

        // Validate if input was valid by checking if the followed character is not a new line character
        while (remain != '\n') {
            remain = getchar();
            isInputCorrect = false;
        }

        // If the entered command
        if (isInputCorrect) {

            // Change input to lower case to avoid checking the command in both, capital letters and lower-case letters
            inputChar = tolower(inputChar);

            switch (inputChar) {
                case 'i':
                    requestPersonInput(personList);
                    break;
                case 'r':
                    requestPersonRemoval(personList);
                    break;
                case 's':
                    printPersonList(personList);
                    break;
                case 'c':
                    clear(personList);
                    printf("\n--> List was successfully cleared!\n");
                    break;
                case 'e':
                    continueApplication = false;
                    break;
                default:
                    printf("\nPlease enter a valid command!\n");
            }
        } else {
            printf("\nPlease enter a valid command!\n");
        }
    }
}