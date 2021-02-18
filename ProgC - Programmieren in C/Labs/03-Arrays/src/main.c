//Aufgabe 3 Pascal Brunner (brunnpa7)

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_STUDENTS 100
#define MAX_MARK 6.00
#define MIN_MARK 1.00

// @brief Defining a type structure called 'bool'
typedef enum
{
    false,
    true
} bool;

int scores[MAX_STUDENTS] = {0};
int scoreIndex = 0;
double marks[MAX_STUDENTS] = {0};
int minScoreForSix = 0;
int bestMark = 0;
int worstMark = 7;
double sumMarks = 0;
double averageMark = 0;
int markIndex = 0;

/**
@brief calculate the mark with
@param [int]score this is the number of points the student scored
@param [int]minScore that's the minimum number of points a student must score to have a six.
@return [double]mark round to the next integer
*/
/*
double getMark (int score, int minScore) {
    double mark = 0.0;
    double result = 0;

       
    mark = (1+((5.0*score)/minScore));
    
    if(mark > MAX_MARK) {
        mark = MAX_MARK;
    }
    else if(mark < MIN_MARK) {
        mark = MIN_MARK;
    }

    mark = round(mark);

    return mark;
}*/
/** @brief Calculates mark
 *  @returns  The mark
 */
int getMark(int pointsOfStudent, int minimumPointsRequiredFor6)
{
    double preciseMark = (double)1 + (5 * pointsOfStudent / minimumPointsRequiredFor6);
    double fraction = preciseMark - ((long)preciseMark);
    int mark = (fraction >= 0.5) ? ceil(preciseMark) : floor(preciseMark);

    if (mark > 6)
    {
        mark = 6;
    }

    if (mark < 1)
    {
        mark = 1;
    }

    return mark;
}

/**
@brief calculates the grade average of the class
@param [double]sumMarks the sum of all marks
@param [int]totalStudents How many students this class have
@return [double]averageMark from the class
*/
double getAverage(double sumMarks, int totalStudents)
{
    averageMark = (sumMarks / totalStudents);

    if (averageMark > MAX_MARK)
    {
        averageMark = MAX_MARK;
    }
    else if (averageMark < MIN_MARK)
    {
        averageMark = MIN_MARK;
    }

    return averageMark;
}

/**
@brief Creates the whole static including the printing function
@param [int]scores[MAX_STUDENTS] Array with all scores from each student
*/
double getStatistic(int scores[MAX_STUDENTS])
{
    int counterSix = 0;
    int counterFive = 0;
    int counterFour = 0;
    int counterThree = 0;
    int counterTwo = 0;
    int counterOne = 0;
    int notCount = 0;
    int biggerOrEqualFour = 0;
    double percentageBiggerOrEqualFour = 0;

    for (markIndex = 2; markIndex <= scoreIndex; markIndex++)
    {
        marks[markIndex - 2] = getMark(scores[markIndex - 2], minScoreForSix);

        sumMarks += marks[markIndex - 2];

        if (marks[markIndex - 2] > bestMark)
        {
            bestMark = marks[markIndex - 2];
        }

        if (marks[markIndex - 2] < worstMark)
        {
            worstMark = marks[markIndex - 2];
        }

        switch ((int)marks[markIndex - 2])
        {
        case 6:
            counterSix++;
            break;
        case 5:
            counterFive++;
            break;
        case 4:
            counterFour++;
            break;
        case 3:
            counterThree++;
            break;
        case 2:
            counterTwo++;
            break;
        case 1:
            counterOne++;
            break;
        default:
            notCount++;
        }
    }

    getAverage(sumMarks, (markIndex - 2));

    biggerOrEqualFour = (counterFour + counterFive + counterSix);
    percentageBiggerOrEqualFour = (100 / (markIndex - 2) * biggerOrEqualFour);

    printf("-----------------------------------------------------------------\n");
    printf("Statistics (%d students, %d points needed for mark 6)\n\n", (markIndex - 2), minScoreForSix);
    printf("  Mark 6: %d\n  Mark 5: %d\n  Mark 4: %d\n  Mark 3: %d\n  Mark 2: %d\n  Mark 1: %d\n",
           counterSix, counterFive, counterFour, counterThree, counterTwo, counterOne);
    printf("Best mark: %8d\n", bestMark);
    printf("Worst mark: %7d\n", worstMark);
    printf("Average mark: %5.2f\n", averageMark);
    printf("Mark >=4: %10d (students %5.2f %%)\n", biggerOrEqualFour, percentageBiggerOrEqualFour);
}

/**
@brief main function to start the program
*/
int main(void)
{

    int continueApplication = false;

    printf("Enter the score for each students, to complete your input type -1:\n");
    while (scanf("%d", &scores[scoreIndex]) != 1)
    {
        printf("[FAILED]...That's not a number. Please Enter the score: ");
        while (getchar() != '\n')
            ;
    }
    scoreIndex++;

    while (scores[scoreIndex - 1] != -1 && scoreIndex < MAX_STUDENTS)
    {
        printf("Enter the score for the next student, to complete your input type -1:\n");
        while (scanf("%d", &scores[scoreIndex]) != 1)
        {
            printf("[FAILED]...That's not a number. Please enter the score: ");
            while (getchar() != '\n')
                ;
        }
        scoreIndex++;
    }

    do
    {
        printf("Enter the minimum number of points for a 6\n");
        while (scanf("%d", &minScoreForSix) != 1)
        {
            printf("[FAILED]...That's not a number. Please enter the minimum number of points: ");
            while (getchar() != '\n')
                ;
        }

        getStatistic(scores);
        while (getchar() != '\n')
            ;

        printf("\nDo you want to use another minimum number? (y/n): \n");
        char ch = getchar();

        if (ch == 'y' || ch == 'Y')
        {
            continueApplication = true;
        }
    } while (continueApplication);

    return EXIT_SUCCESS;
}
