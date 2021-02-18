//Aufgabe 4 Pascal Brunner (brunnpa7) 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define ENDOFINPUT "ZZZ"
#define MAXWORDSINWORDLIST 100

char *wordlist[MAXWORDSINWORDLIST];
char word[20] = {0};
int wordArrayindex = 0;
int wordlistArrayIndex = 0;

/**
* @brief Adds a word to the wordlist
* @param [char]word[]
* @param [char]*wordlist[]
* @param [int]wordlistSize
* @param [int]wordlistArrayIndex
*/
void addWordToWordlist(char word[], char *wordlist[], int wordlistSize, int wordlistArrayIndex) {
    //size_t can hold any array index
    size_t wordSize = strlen(word) + 1;
    
    //allocate an size of bytes for the new array
    void *arrayPointer = (char *) malloc(wordSize * sizeof(char));
    
    //check if there is enough free space
    if(arrayPointer && wordlistSize > wordlistArrayIndex) {
        wordlist[wordlistArrayIndex] = arrayPointer;
        //Copy the word to the new ArrayPointer and save the address in the wordlist
        strcpy(wordlist[wordlistArrayIndex], word);
        
        printf("[SUCCESS]...Your word %s has been successfully added\n", word);
    }
    else {
        printf("[FAILED]...Your word %s has NOT been added\n", word); 
    }

}
/**
* @brief Sorts the given wordlist in a alphabetical order
* @param [char]*wordlist[]
* @param [int]wordlistSize
*/
void sortWordlist (char *wordlist[], int wordlistSize) {
    int i;
    int j;
    char *tmp;
    
    for(i = 0; i < wordlistSize - 1; i++) {
        for(j = 0; j < wordlistSize - i - 1; j++) {
            /*
            with strcmp return 
                <0  if second is bigger, 
                 0  if they are equal, 
                >0  if first is bigger
                 according to the ASCII Code 
            */
            if(strcmp(wordlist[j], wordlist[j + 1]) > 0) {
                tmp = wordlist[j];
                wordlist[j] = wordlist[j + 1];
                wordlist[j + 1] = tmp;
            }
        }
    }  
}

/**
* @brief Prints the whole wordlist
* @param [char]*wordlist[]
* @param [int]wordlistArraySize
*/
void printWordlist(char *wordlist[], int wordlistArraySize) {
    int counter;
    
    for(counter = 0; counter < wordlistArraySize; counter++) {
        printf("%s \n", wordlist[counter]);
    }
}

/**
* @brief Checks if the word is already in the wordlist
* @param [char]word[]
* @param [char]*wordlist[]
* @param [int]currentSize
* @return 1 if the word is already in the wordlist
* @return 0 if the word is not in the wordlist
*/
int isWordInWordlist(char word[], char *wordlist[], int currentSize) {
    int counter;
    
    for(counter = 0; counter < currentSize; counter++) {
        if(strcmp(word, wordlist[counter]) == 0) {
            return 1;
        }
    }
    
    return 0;
}

/**
* @brief Main-method were the program starts, it allows to input some words until the word ZZZ is found
* @return EXIT_SUCCESS
*/
int main(void) {  
    do {
    printf ("Enter your word: -with 'ZZZ' you can finish your input\n");
        //Check if the input is not Null
        if(scanf("%s", word) > 0) {
            //Check if the inputword is not equal to the End of Input
            if(strcmp(word, ENDOFINPUT) != 0) {
                //convert every letter to lowercase
                for(int i = 0; word[i]; i++) {
                    word[i] = tolower(word[i]);
                }
                //Check if the inputword already exists in the wordlist
                if(isWordInWordlist(word, wordlist, wordlistArrayIndex) == 0) {
                    addWordToWordlist(word, wordlist, MAXWORDSINWORDLIST, wordlistArrayIndex);
                    wordlistArrayIndex++;
                }
                else {
                    printf("[FAILED]...The word %s is already in the wordlist!\n", word);
                }
            }
        }
        //Error-Message if the input is invalid
        else {
            printf("[FAILED]...This is not an valid word\n");
            return EXIT_FAILURE;
        }
    }while(strcmp(word, ENDOFINPUT) != 0);

    printf("[BEFORE]...This is your unsorted Wordlist: \n");
    printWordlist(wordlist, wordlistArrayIndex);
    
    sortWordlist(wordlist, wordlistArrayIndex);
    
    printf("[AFTER]...This is your sorted Wordlist - looks definitely cleaner :-)\n");
    printWordlist(wordlist, wordlistArrayIndex);
    
    return EXIT_SUCCESS;     

    
    
    
    /* 
    * frist try 

    while(!strcmp(threeLastChar, "ZZZ")) {
        scanf("%s", &c);
        checkIfTerminated(c);
        if ( c != ' ') {
            word[wordArrayindex] = c;
            wordArrayindex++;
            //c = getchar();

        }
        
        else if( c == ' ') {
            word[wordArrayindex] = '\0';
            wordSize = sizeof(word[0]);
            wordArraySize = (sizeof(word) / wordSize);
            //durch word-array itterieren in neuem Array abspeichern und  und index = 0 setzen
            cleanUp();
            //c = getchar();
        }            
    }*/
      
    
}


