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
#define INFILE_VALID_DATE "stim_valid.input"

// @brief The stimulus for a leap year input
#define INFILE_LEAP_YEAR "stim_leapYear.input"

// @brief The stimulus for an invalid year
#define INFILE_INVALID_YEAR "stim_invalidYear.input"

// @brief The stimulus for an invalid month
#define INFILE_INVALID_MONTH "stim_invalidMonth.input"

// @brief The stimulus for an invalid day
#define INFILE_INVALID_DAY "stim_invalidDay.input"

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
static void test_validInput(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter a random date in the following format: DD MM YYYY\n",
		"The following day is: 22.3.1990\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_VALID_DATE);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_leapYear(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter a random date in the following format: DD MM YYYY\n",
		"The following day is: 29.2.2004\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_LEAP_YEAR);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}


static void test_invalidYear(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter a random date in the following format: DD MM YYYY\n",
		"This is not a valid year. Enter a year greater than 1582.\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_INVALID_YEAR);

	// assert
	CU_ASSERT_EQUAL(exit_code, 1);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_invalidMonth(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter a random date in the following format: DD MM YYYY\n",
		"This is not a valid month. Valid months range from 01(=Jan) to 12(=Dec).\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_INVALID_MONTH);

	// assert
	CU_ASSERT_EQUAL(exit_code, 1);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_invalidDay(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter a random date in the following format: DD MM YYYY\n",
		"This is not a valid day. Check your input again.\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_INVALID_DAY);

	// assert
	CU_ASSERT_EQUAL(exit_code, 1);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

/**
 * @brief Registers and runs the tests.
 */
int main(void)
{
	// setup, run, teardown
	TestMainBasic("Selbststudium2 - Calculate the following day", setup, teardown
					, test_validInput
					, test_leapYear
					, test_invalidYear
					, test_invalidMonth
					, test_invalidDay
				);
}
