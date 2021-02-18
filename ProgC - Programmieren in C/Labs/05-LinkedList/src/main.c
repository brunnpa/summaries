//Aufgabe 5 Pascal Brunner (brunnpa7)

/*
Fragen:
   - Weshalb geht z.B. current.next nicht? sonder man muss current->next angeben (gem. compiler)? (*p).x == p->x 
   (*head).next == head-> next
   - Wieso kann ich nicht auf head zugreifen?
   - Wie kann ich die Personendaten übergeben?
   - Ist die Verknüpfung der Headerfiles korrekt?
   - Wie kann ich das While(1) anders ausdrücken?
   - Wie ist das grundsätzliche Konstrukt der LinkedList, da wir ja keine Objektorientierte Programmierung haben?
   - push-Funktion korrekt?
   - pop-Funktion korrekt?
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#include "list.h"
#include "person.h"

#define INSERT 'I'
#define REMOVE 'R'
#define SHOW 'S'
#define CLEAR 'C'
#define END 'E'




//Main-method where the program starts
int main(void) {
    char command;
    //Create the startpoint (Anchor)
    createHeadElement();
    

    //Befehle I(nsert), R(emove), S(how), C(lear), E(nd)  
    while(1){
        printf("What would you like to do? Enter your command:\n");
        printf("I = Insert, R = Remove, S = Show, C = Clear, E = End\n");

        scanf("%c", &command); //%s unschön, da Memory überschrieben werden kann: besser %1s
        command = toupper(command);
        switch(command) {
            case INSERT:
                //Insert-Befehl
                printf("Führe Insert-Befehl aus...\n");
                insert(readPerson());
                printf("\n");
                break;
            case REMOVE:
                //Remove-Befehl
                printf("Führe Remove-Befehl aus...\n");
                removePerson(readPerson());
                printf("\n");
                break;
            case SHOW:
                //Show-Befehl
                printf("Führe Show aus...\n");
                printOutList();
                printf("\n");
                break;
            case CLEAR:
                //Clear-Befehl
                printf("Führe Clear aus...\n");
                clearList();
                printf("\n");
                break;
            case END:
                printf("The program terminate...\n");
                return EXIT_SUCCESS;
                break;
            default:
                printf("[FAILED]...This is not an valid command...\n");
                printf("\n");
        }
        printf("To enter the next command press [ENTER]");
        while((getchar())!= '\n');
        
    }         
    
    return EXIT_SUCCESS;         
}
