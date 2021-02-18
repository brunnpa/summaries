

#include <stdio.h>
#include <stdlib.h>

#define STARTVALUE -100
#define ENDVALUE 200

/**
* @brief Converts fahrenheit to celsius
* @param [int]fahrenheit temperature in fahrenheit 
* @return temperature in celsius
*/
double calculateFahrenheitToCelsius(int fahrenheit) {
    return (5*(fahrenheit-32))/9.0;    
    }

/**
* @brief Calculates celsius temperatures from -100 fahrenheit to 200 fahrenheit
    in 20 degrees steps and prints fahrenheit/celsius table
* @return returns EXIT_SUCCESS (=0)
*/
int main(void) {
    printf("F\'heit    Celsius\n");
    printf("-----------------\n");
    
    //Prints the fahrenheit/celsius table
    for(int fahrenheit = STARTVALUE; fahrenheit <= ENDVALUE; (fahrenheit+=20)){
        printf("%6d %10.2f\n", fahrenheit, calculateFahrenheitToCelsius(fahrenheit)); 
    }
       
    return EXIT_SUCCESS;
    
}

