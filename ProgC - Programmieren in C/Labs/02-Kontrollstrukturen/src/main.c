/**
 * @file
 * @brief Lab implementation
 */

#include <stdio.h>
#include <stdlib.h>

enum {Jan=1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec};
static int daysInMonth[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

// Defining a type structure called 'Date'
typedef struct {
	int day;
	int month;
	int year;
}	Date;

Date inputDate;
Date followingDay;

// Returns 1 for a leap year and 0 for a non-leap year
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

// Returns 1(=true) for a valid year
int isValidYear() {
	if (inputDate.year >= 1583) {
		return 1;
	}
	else {
		printf("This is not a valid year. Enter a year greater than 1582.\n");
		return 0;
	}
}

// Returns 1(=true) for a valid month
int isValidMonth() {
	if ((Jan <= inputDate.month) && (inputDate.month <= Dec)) {
		return 1;	
	} 
	else {
		printf("This is not a valid month. Valid months range from 01(=Jan) to 12(=Dec).\n");
		return 0;
	}
}


// Returns 1(=true) for a valid date and 0(=false) for a date that is not valid
int isValidDay() {
	if((1 <= inputDate.day) && (inputDate.day <= daysInMonth[inputDate.month])) {
		return 1;
	}

	else {
		printf("This is not a valid day. Check your input again.\n");
		return 0;
	}

}

// Returns 1(=true) for a valid input, else 0(=false)
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

// Calculates the following day
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

/** TODO: Handling if no input is provided!
 * @brief Main entry point. Allows a user to get the following day for a given input day
 * @return EXIT_SUCCESS(=0) on success,
 * @return EXIT_FAILURE(=1) on invalid input
 */
int main(void) {
	int exitCode = EXIT_FAILURE;
	printf("Enter a random date in the following format: DD MM YYYY\n");
	while (scanf("%2d %2d %4d", &inputDate.day, &inputDate.month, &inputDate.year) != 3) {
		printf("The input has the wrong format. Please check your input.\n");
		return exitCode;
	}
	if (isValidInput() != 1) {
		return exitCode;
	}
	else {
		followingDay = inputDate;
		calculateFollowingDay();
		printf("The following day is: %d.%d.%d\n", followingDay.day, followingDay.month, followingDay.year);
		exitCode = EXIT_SUCCESS;
		return exitCode;
	}
}
