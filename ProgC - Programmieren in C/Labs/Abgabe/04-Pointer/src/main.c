/**
 * @file
 * @brief Lab implementation
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// @brief Data fields
char word[20];
char *wordlist[100];
int wordlistCounter=0;

// @brief Reads a single word from command line. If a user provides words with more than 19 characters, the remaining characters remain in the buffer. 
void getWord() {
	
	while(scanf("%19s", word)!= 1) {
		printf("Die Ausgabe ist falsch\n");
	}
	word[19]='\0';
}

// @brief Returns the capacity(!) of the wordlist array
int getWordlistSize() {
	size_t n = sizeof(wordlist)/sizeof(*wordlist);
	return n;
}

/** @brief Checks if word is a duplicate of another word in wordlist
 *  @returns Returns 1 if the word is a duplicate, else 0
 */
int isDuplicate() {
	size_t n = getWordlistSize();
	for(int i=0;i<n;i++) {
		// Check if wordlist[i] is null. If so, do nothing, else compare string.
		if(wordlist[i] != NULL) { 
			if (strcmp(word,wordlist[i]) == 0) {
				return 1;
			}
		}
	}
	return 0;
}

// @brief Saves a single word in the wordlist array
void saveWord() {
	// Save the word in the wordlist, if it is not the terminating word "ZZZ" or a duplicate of another word in the wordlist.	
	if(!isDuplicate()) {
		size_t n = strlen(word);
		char *entry = malloc(n+1); // n+1 bytes, including end-of-string: \O 
		strcpy(entry,word);
		wordlist[wordlistCounter] = entry;
		wordlistCounter++;
	}
}

// @brief Prints the wordlist
void printWordlist() {
	size_t n = getWordlistSize();
	printf("Folgende Woerter sind in der Wordlist enthalten:\n");
	for(int i=0;i<n;i++) {		
		if(wordlist[i] != NULL) {
			printf("%s\n",wordlist[i]);
		}
	}
}

// @brief Sorts elements in wordlist from upper to lower case and in alphabetical order
void sortWordlist() {
	char *tmp;
	size_t n = getWordlistSize();
	for(int i=0; i<n; i++) {
		for(int j=(i+1); j<n; j++) {
			if (wordlist[i]!= NULL && wordlist[j]!=NULL && strcmp(wordlist[i],wordlist[j]) > 0) {
				tmp = wordlist[j];
				wordlist[j] = wordlist[i];
				wordlist[i] = tmp;
			}
		}
	}
}

/** @brief Main entry point. Allows a user to enter any amount of words. 
 *  @returns EXIT_SUCCESS(=0) on success
 */
int main(void) {
	printf("Dieses Programm speichert einzelne Woerter in einer Liste und gibt diese sortiert aus.\n");
	printf("Das Programm wird beendet mit der Eingabe 'ZZZ'.\n");	
	getWord();	
	while(strcmp(word,"ZZZ") != 0) {	
		saveWord();
		getWord();
	}
	sortWordlist();
	printWordlist();
	return EXIT_SUCCESS;
}

