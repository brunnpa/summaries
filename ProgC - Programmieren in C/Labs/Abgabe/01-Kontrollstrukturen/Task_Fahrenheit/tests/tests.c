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
/// @brief The name of the STDERR text file.
#define ERRFILE "stderr.txt"

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
static void test_main_calculator(void) 
{
    //arange
    const char *out_txt[] = {
        "F'heit    Celsius\n",
        "-----------------\n",
        "  -100     -73.33\n",
        "   -80     -62.22\n",
        "   -60     -51.11\n",
        "   -40     -40.00\n",
        "   -20     -28.89\n",
        "     0     -17.78\n",
        "    20      -6.67\n",
        "    40       4.44\n",
        "    60      15.56\n",
        "    80      26.67\n",
        "   100      37.78\n",
        "   120      48.89\n",
        "   140      60.00\n",
        "   160      71.11\n",
        "   180      82.22\n",
        "   200      93.33\n"
    };
    const char *err_txt[] = { };
    
    // act
	int exit_code = system(XSTR(TARGET) " 1>" OUTFILE " 2>" ERRFILE);
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
	TestMainBasic("Selbststudium1 - Konvertierung", setup, teardown
				  , test_main_calculator
				  );
}
