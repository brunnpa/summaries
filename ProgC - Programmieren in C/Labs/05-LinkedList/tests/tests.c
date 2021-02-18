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

/// @brief The name of the STDOUT text file.
#define OUTFILE "stdout.txt"

// setup & cleanup
static int setup(void)
{
	remove_file_if_exists(OUTFILE);
	return 0; // success
}

static int teardown(void)
{
	// Do nothing.
	// Especially: do not remove result files - they are removed in int setup(void) *before* running a test.
	return 0; // success
}


// tests
static void test_print_board(void)
{
	// arrange
	const char *out_txt[] = {
		" A1 B1 C1 D1 E1 F1 G1 H1\n",
		" A2 B2 C2 D2 E2 F2 G2 H2\n",
		" A3 B3 C3 D3 E3 F3 G3 H3\n",
		" A4 B4 C4 D4 E4 F4 G4 H4\n",
		" A5 B5 C5 D5 E5 F5 G5 H5\n",
		" A6 B6 C6 D6 E6 F6 G6 H6\n",
		" A7 B7 C7 D7 E7 F7 G7 H7\n",
		" A8 B8 C8 D8 E8 F8 G8 H8\n",
	};
	// act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE);
	// assert
	CU_ASSERT_EQUAL(exit_code, 0);
	assert_lines(OUTFILE, out_txt, sizeof(out_txt)/sizeof(*out_txt));
}

/**
 * @brief Registers and runs the tests.
 */
int main(void)
{
	// setup, run, teardown
	TestMainBasic("Chess Board", setup, teardown
				  , test_print_board
				  );
}
