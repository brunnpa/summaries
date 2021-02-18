//Aufgabe 2 Pascal Brunner (brunnpa7)

#include <stdio.h>
#include <stdlib.h>

#define MINIMUMDAY 1
#define MINIUMYEAR 1583



// enum for Months to use program internal the shortcut instead of numbers 
enum {JAN = 1, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC};

// declare the amount of days per month
static int daysInMonth[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

// declare the struct Date as Day, Month, year
typedef struct {
    int day;
    int month;
    int year;
    } Date;

//declare
Date inputDate;
Date followingDay; 

/**
* @brief
* @param [int]year
* @return 1 if true
* @return 0 if false
*/
int isValidYear(int year) {
    if(inputDate.year >= MINIUMYEAR) {
        return 1;
    }
    else {
        printf("not a valid year\n");
        return 0;
    }
}

/** 
* @brief checks if leap year
* @param [int]year
* @return 1 if true
* @return 2 if false
*/
int isLeapYear(int year) {
    if(year %400 == 0){
        return 1;
    }
    
    else if(year %4 == 0 && year %100 != 0) {
        return 1;     
    }
    
    else {
        return 0;
    }
}

/**
* @brief checks if it is a valid month
* @param [int] month
* @return 1 if true
* @return 0 if false
*/
int isValidMonth(int month) {

    if(month >= JAN && month <= DEC) {
        return 1;
    }
    else {
        printf("not a valid month\n");
        return 0;
    } 
     
}

/**
@brief checks if it is a valid day
@param [int]day
@return 1 if true
@return 0 if false
*/
int isValidDay(int day) {

    if(MINIMUMDAY <= day && day <= daysInMonth[inputDate.month]){
        return 1;
    }
    else {
        printf("not a valid day\n");  
        return 0;
    }
    
    /* This was my first try to implement the method
    for(int indexDay = 1; indexDay <= daysInMonth[inputDate.month]; indexDay++) {
    if(day == indexDay) {
        //printf("Day OK");
        return 1;
    }
    else {
        printf("not a valid day\n");  
        return 0;
    }
    }*/
}




/**
* @brief Method for calculating the following day based on the parameter inputDate
* @param Date inputDate
* @return following Day
*/
Date calculateFollowDate(Date inputDate) {
    
    followingDay.day += 1;
        if(followingDay.day > daysInMonth[inputDate.month]) {
            followingDay.day = 1;
            followingDay.month += 1;
            if(followingDay.month > DEC) {
                followingDay.month = 1;
                followingDay.year += 1;
            }    
        }
          
    return followingDay; 
    
    }

/**
* @brief Checks if the input is valid
* @param [int]year
* @param [int]month
* @param [int]day
* @return 1 if true
* @return 0 if false
*/    
int isValidInput(int year, int month, int day) {  
    int result;
    
    result = isValidYear(year);
    if(result == 0) {
        return result;
    }
    
    if(isLeapYear(year) != 0) {
        daysInMonth[FEB] = 29;
    }
    
    result = isValidMonth(month);
    if(result == 0) {
        return result;
    }
    
    result = isValidDay(day);
    
    return result;
    
    
    /*
    Wäre korrekte Lösung jedoch zu verschachtelt, daher wurde es mit der early-Return Methode gelöst
    if(isValidYear(year) == 1) {
        if(isLeapYear(year) == 1) {
            daysInMonth[FEB] = 29;
            if(isValidMonth(month) == 1) {
                if(isValidDay(day) == 1) {
                    return 1; 
                }
                else {
                    return 0;
                }
            }
            else {
                return 0;
            }
        }
        else {
            if(isValidMonth(month) == 1) {
                if(isValidDay(day) == 1) {
                    return 1; 
                }
                else {
                    return 0;
                }
            }
            else {
                return 0;
            }       
        }
    }
    else {
        return 0;
    }*/
}


/**
* @brief Main entry point, Allows a user to get the following day for a given input day
* @return returns EXIT_SUCCESS(=0) on success,
* @return returns EXIT_FAILURE(=1) on invalid input
*/
int main(void) {
    printf("Enter a random date (bigger or equal 1.1.1583) than in the following format: DD MM YYYY\n");
    while(scanf("%2d %2d %4d", &inputDate.day, &inputDate.month, &inputDate.year) != 3) {
        printf("The input has the wrong format. Please check your input.\n");
        return EXIT_FAILURE;
    }

    if(isValidInput(inputDate.year, inputDate.month, inputDate.day) == 0) {
        printf("The input is invalid\n");
        return EXIT_FAILURE;
    }
    else {
    followingDay = inputDate;
    calculateFollowDate(followingDay);
    printf("Following day: %d.%d.%d\n", followingDay.day, followingDay.month, followingDay.year);   
    return EXIT_SUCCESS;
    }
    
}

