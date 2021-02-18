/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zuercher Hochschule Winterthur             -
 * --  _| |_| | | | |____ ____) |  (University of Applied Sciences)           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ----------------------------------------------------------------------------
 */
/**
 * @file
 * @brief Test suite for the given package.
 */
#include <stdio.h>
#include <stdlib.h>
#include "CUnit/Basic.h"
#include "test_utils.h"

#ifndef TARGET // must be given by the make file --> see test target
#error missing TARGET define
#endif

// @brief The name of the STDOUT text file.
#define OUTFILE "stdout.txt"
/// @brief The name of the STDERR text file.
#define ERRFILE "stderr.txt"

// @brief The stimulus for a valid input
#define INFILE_VALID "stim_valid.input"

// setup & cleanup
static int setup(void)
{
	remove_file_if_exists(OUTFILE);
	remove_file_if_exists(ERRFILE);
	return 0; // success
}

static int teardown(void)
{
	// Do nothing.
	// Especially: do not remove result files - they are removed in int setup(void) *before* running a test.
	return 0; // success
}

// tests
/*
static void test_calculateMark(void) 
{
    int pointsOfStudents = 100;
    int minPointsRequiredForSix = 120;
    
    double mark = getMark(pointsOfStudents, minPointsRequiredForSix);
    
    CU_ASSERT_EQUAL(mark, 5);
}*/

static void test_valid(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter the score for each students, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the score for the next student, to complete your input type -1:\n",
	    "Enter the minimum number of points for a 6\n",
		"-----------------------------------------------------------------\n",
		"Statistics (10 students, 7 points needed for mark 6)\n",
		"\n",
		"  Mark 6: 4\n",
		"  Mark 5: 2\n",
   		"  Mark 4: 1\n",
   		"  Mark 3: 2\n",
	   	"  Mark 2: 1\n",
   		"  Mark 1: 0\n",
	  	"Best mark:        6\n",
   	  	"Worst mark:       2\n",
   		"Average mark:  4.60\n",
   		"Mark >=4:          7 (students 70.00 %)\n"
		"\nDo you want to use another minimum number? (y/n): \n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_VALID);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}


/**
 * @brief Registers and runs the tests.
 */
int main(void)
{
	// setup, run, teardown
	TestMainBasic("Selbststudium 4", setup, teardown
					, test_valid
				);
}

