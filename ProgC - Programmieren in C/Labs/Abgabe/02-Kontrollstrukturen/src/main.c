/**
 * @file
 * @brief Lab implementation
 */

#include <stdio.h>
#include <stdlib.h>


enum {Jan=1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec};
// @brief The number of days per month
static int daysInMonth[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

// @brief Defining a type structure called 'Date'
typedef struct {
	int day;
	int month;
	int year;
}	Date;

// @brief Data fields for input date and the following date
Date inputDate;
Date followingDay;

/** @brief Checks if a given year is a leap year
 * @returns 1 if the year is leap year, else 0.  
 */

int isLeapYear() {
	if((inputDate.year % 4 == 0) && (inputDate.year % 100 != 0)) {
		return 1;
	}

	else if(inputDate.year % 400 == 0) {
		return 1;
	}

	else {
		return 0;
	}
}

/** @brief Checks if year is valid
 *  @returns 1(=true) for a valid year, else 0
 */
int isValidYear() {
	if (inputDate.year >= 1583) {
		return 1;
	}
	else {
		printf("This is not a valid year. Enter a year greater than 1582.\n");
		return 0;
	}
}

/** @brief Checks if month is valid
 *  @returns 1(=true) for a valid month, else 0
 */
int isValidMonth() {
	if ((Jan <= inputDate.month) && (inputDate.month <= Dec)) {
		return 1;	
	} 
	else {
		printf("This is not a valid month. Valid months range from 01(=Jan) to 12(=Dec).\n");
		return 0;
	}
}


/** @brief Checks if a day is valid
 *  @returns 1(=true) for a valid day, else 0
 */
int isValidDay() {
	if((1 <= inputDate.day) && (inputDate.day <= daysInMonth[inputDate.month])) {
		return 1;
	}

	else {
		printf("This is not a valid day. Check your input again.\n");
		return 0;
	}

}

/** @brief Checks if input date is valid
 *  @returns 1(=true) for a valid input, else 0
 */
int isValidInput() {
	if(!isValidYear()) {
		return 0;
	}

	if(!isValidMonth()) {
		return 0;
	}

	if(isLeapYear()) {
		daysInMonth[2] = 29;	
	}

	if(!isValidDay()) {
		return 0;
	}

	else {
		return 1;
	}
}

// @brief Calculates the following day
void calculateFollowingDay() {
	if (inputDate.day >= daysInMonth[inputDate.month]) {
		followingDay.day = 1;
		followingDay.month+= 1;
		if(followingDay.month > Dec) {
			followingDay.month = 1;
			followingDay.year += 1;
		}
	}
	else {
		followingDay.day+=1;
	}
}

/**
 * @brief Main entry point. Allows a user to get the following day for a given input day
 * @returns Returns EXIT_SUCCESS(=0) on success,
 * 					EXIT_FAILURE(=1) on invalid input
 */
int main(void) {
	printf("Enter a random date in the following format: DD MM YYYY\n");
	while (scanf("%2d %2d %4d", &inputDate.day, &inputDate.month, &inputDate.year) != 3) {
		printf("The input has the wrong format. Please check your input.\n");
		return EXIT_FAILURE;
	}
	if (isValidInput()) {
		followingDay = inputDate;
		calculateFollowingDay();
		printf("The following day is: %d.%d.%d\n", followingDay.day, followingDay.month, followingDay.year);
		return EXIT_SUCCESS;	
	} 
	return EXIT_FAILURE;
}
