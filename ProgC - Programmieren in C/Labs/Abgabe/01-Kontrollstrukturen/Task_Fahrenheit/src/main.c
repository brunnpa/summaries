/**
 * @file
 * @brief Lab implementation
 */
#include <stdio.h>
#include <stdlib.h>

/**
* @brief Converts fahrenheit to celsius
* @param[int] fahrenheit temperature in fahrenheit
* @returns temperature in celsius
*/
double convertFahrenheitToCelsius(int fahrenheit) {
	return (5 * (fahrenheit - 32)) / 9.0;
	}

/**
 * @brief Calculates celsius temperatures from -100 fahrenheit to 200 fahrenheit
            in 20 degrees steps and prints celsius/fahrenheit table
 * @returns Returns EXIT_SUCCESS (=0)
 */
int main(void) {
	printf("F\'heit    Celsius\n");
	printf("-----------------\n");

	// Prints the fahrenheit/celsius table
	for(int fahrenheit = -100; fahrenheit<=200; (fahrenheit+=20)) {
			printf("%6d %10.2f\n", fahrenheit, convertFahrenheitToCelsius(fahrenheit));
	}

	return EXIT_SUCCESS;

}
