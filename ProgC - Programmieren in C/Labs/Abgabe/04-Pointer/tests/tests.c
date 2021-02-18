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

// @brief The stimulus for an empty input
#define INFILE_EMPTY "stim_empty.input"

// @brief The stimulus for a input with duplicates
#define INFILE_DUPLICATES "stim_duplicates.input"

// @brief The stimulus for a word with more than 19 characters
#define INFILE_LONG_WORD "stim_long_word.input"

// @brief The stimulus for an input, which is not in alphabetical order 
#define INFILE_SORT "stim_sort.input"

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
static void test_empty(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Dieses Programm speichert einzelne Woerter in einer Liste und gibt diese sortiert aus.\n",
	    "Das Programm wird beendet mit der Eingabe 'ZZZ'.\n",
		"Folgende Woerter sind in der Wordlist enthalten:\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_EMPTY);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_duplicates(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Dieses Programm speichert einzelne Woerter in einer Liste und gibt diese sortiert aus.\n",
	    "Das Programm wird beendet mit der Eingabe 'ZZZ'.\n",
		"Folgende Woerter sind in der Wordlist enthalten:\n",
		"hans\n",
		"muster\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_DUPLICATES);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}


static void test_longword(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Dieses Programm speichert einzelne Woerter in einer Liste und gibt diese sortiert aus.\n",
	    "Das Programm wird beendet mit der Eingabe 'ZZZ'.\n",
		"Folgende Woerter sind in der Wordlist enthalten:\n",
		"jjjjjjjjjjjjjjj\n",
		"jjjjjjjjjjjjjjjjjjj\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_LONG_WORD);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_sort(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Dieses Programm speichert einzelne Woerter in einer Liste und gibt diese sortiert aus.\n",
	    "Das Programm wird beendet mit der Eingabe 'ZZZ'.\n",
		"Folgende Woerter sind in der Wordlist enthalten:\n",
		"Ananas\n",
		"Apfel\n",
		"Avocado\n",
		"Banane\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_SORT);

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
					, test_empty
					, test_duplicates
					, test_longword
					, test_sort
				);
}

