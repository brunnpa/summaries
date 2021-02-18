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

// @brief The stimulus for input with spaces & tabs only
#define INFILE_BLANKS_TABS "stim_blanks_tabs.input"

// @brief The stimulus for input with 3 words
#define INFILE_SENTENCE "stim_sentence.input"

// @brief The stimulus for a word with 320 characters
#define INFILE_BIGWORD "stim_bigword.input"

// @brief The stimulus for a word with 320 characters
#define INFILE_SENTENCE_TABS "stim_sentence_with_trailing_tabs.input"

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
static void test_emptyInput(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter any character string:\n",
	    "number of characters: 0\n",
	    "number of words: 0\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_EMPTY);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_blanks_tabs(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter any character string:\n",
	    "number of characters: 44\n",
	    "number of words: 0\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_BLANKS_TABS);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_sentence(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter any character string:\n",
	    "number of characters: 31\n",
	    "number of words: 7\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_SENTENCE);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_bigword(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter any character string:\n",
	    "number of characters: 320\n",
	    "number of words: 1\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_BIGWORD);

	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
	assert_lines(ERRFILE, err_txt, sizeof(err_txt)/sizeof(*err_txt));
}

static void test_sentenceTabs(void) 
{
	// arrange
	const char *out_txt[] = {
	    "Enter any character string:\n",
	    "number of characters: 37\n",
	    "number of words: 7\n"
	};
	const char *err_txt[] = { };

	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_SENTENCE_TABS);

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
	TestMainBasic("Selbststudium1 - Task_Woerter_Zeichen_Zaehlen", setup, teardown
					, test_emptyInput
					, test_blanks_tabs
					, test_sentence
					, test_bigword
					, test_sentenceTabs
				);
}
