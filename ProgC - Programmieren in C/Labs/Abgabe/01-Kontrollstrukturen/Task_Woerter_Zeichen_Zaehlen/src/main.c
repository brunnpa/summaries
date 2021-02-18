/**
 * @file
 * @brief Lab implementation
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define NEWLINE '\n'
#define BLANK ' '
#define TAB '\t'

typedef enum {
	false,
	true
} boolean;

/**
 * @brief Reads the user input from terminal and prints out the number of characters and words
 */
static void processTextInput() {
	boolean wasWord = false;
    int characterCounter = 0;
    int wordCounter = 0;
    
	char inputCharacter = getchar();

    while(inputCharacter != EOF && inputCharacter != NEWLINE) {
		characterCounter++;
		if(inputCharacter == TAB || inputCharacter == BLANK) {
			if(wasWord) {
				wordCounter++;
				wasWord = false;
			}
		}
		else {
				wasWord = true;		
			}
		inputCharacter = getchar();
	}
	// Decide if last word has to be added
	if (wasWord && (inputCharacter == EOF || inputCharacter == NEWLINE)) {
		wordCounter++;
	}
	// Prints the number of characters and words	
    printf("number of characters: %d\n", characterCounter);
	printf("number of words: %d\n", wordCounter);

}

/**
 * @brief Asks for user input from terminal and processes input
 * @returns Returns EXIT_SUCCESS (=0) on success
 */
int main(void){
	printf("Enter any character string:\n");    
	processTextInput();
	return EXIT_SUCCESS;
}

