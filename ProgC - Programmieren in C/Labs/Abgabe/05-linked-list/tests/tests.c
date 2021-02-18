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
#include "list.h"

#ifndef TARGET // must be given by the make file --> see test target
#error missing TARGET define
#endif

/// @brief The name of the STDOUT text file.
#define OUTFILE "stdout.txt"
/// @brief The name of the STDERR text file.
#define ERRFILE "stderr.txt"
/// @brief The stimulus for a standard input
#define INFILE_STANDARD "stm_standard.input"

// setup & cleanup
static int setup(void) {
    remove_file_if_exists(OUTFILE);
    remove_file_if_exists(ERRFILE);
    return 0; // success
}

static int teardown(void) {
    // Do nothing.
    // Especially: do not remove result files - they are removed in int setup(void) *before* running a test.
    return 0; // success
}


// tests

//Person

static void test_compare_person(void) {
    Person p1 = {"Ponbauer", "Martin", 55};
    Person p2 = {"Luescher", "David", 19};

    int result = comparePerson(p1, p2);
    CU_ASSERT_TRUE(result > 0);

    result = comparePerson(p2, p1);
    CU_ASSERT_TRUE(result < 0);
}


static void test_compare_person_same(void) {
    Person p1 = {"Ponbauer", "Martin", 24};
    Person p2 = {"Ponbauer", "Martin", 24};

    int result = comparePerson(p1, p2);
    CU_ASSERT_TRUE(result == 0);
}


static void test_list_empty(void) {
    ListElement *start = malloc(sizeof(ListElement));
    start->next = start;
    bool result = isEmpty(start);
    CU_ASSERT_TRUE(result);
    free(start);
}

static void test_list_empty_negative(void) {
    ListElement *start = malloc(sizeof(ListElement));
    ListElement *second = malloc(sizeof(ListElement));
    second->next = start;
    start->next = second;

    bool result = isEmpty(start);
    CU_ASSERT_FALSE(result);
    free(start);
    free(second);
}

static void test_list_add_in_sorted_order(void) {
    ListElement *start = malloc(sizeof(ListElement));
    start->next = start;

    Person p1 = {"Ponbauer", "Martin", 24};
    (void) addElement(p1, start);

    Person p2 = {"Luescher", "David", 19};
    (void) addElement(p2, start);

    CU_ASSERT_EQUAL(start->next->content.age, p2.age);
    CU_ASSERT_EQUAL(start->next->next->content.age, p1.age);
}

static void test_list_remove_element(void) {
    ListElement *start = malloc(sizeof(ListElement));
    start->next = start;

    Person p1 = {"Ponbauer", "Martin", 24};
    (void) addElement(p1, start);

    Person p2 = {"Luescher", "David", 19};
    (void) addElement(p2, start);

    bool result = removeElement(p1.name, p1.firstname, p1.age, start);

    CU_ASSERT_TRUE(result);
    CU_ASSERT_EQUAL(start->next->next, start);

    result = removeElement(p1.name, p1.firstname, p1.age, start);

    CU_ASSERT_FALSE(result);
}

static void test_list_remove_element_negative(void) {
    ListElement *start = malloc(sizeof(ListElement));
    start->next = start;

    Person p1 = {"Ponbauer", "Martin", 24};

    bool result = removeElement(p1.name, p1.firstname, p1.age, start);

    CU_ASSERT_FALSE(result);
}

static void test_list_clear_linked_list(void) {
    ListElement *start = malloc(sizeof(ListElement));
    start->next = start;

    Person p1 = {"Ponbauer", "Martin", 24};
    (void) addElement(p1, start);

    Person p2 = {"Luescher", "David", 19};
    (void) addElement(p2, start);

    (void) clear(start);
    CU_ASSERT_EQUAL(start->next, start);
}


static void test_main(void) {
    // arrange
    const char *out_txt[] = {
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\nLastname: ",
            "\nFirstname: ",
            "\nAge: ",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\nLastname: ",
            "\nFirstname: ",
            "\nAge: ",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\nLuescher David, 19",
            "\nPonbauer Martin, 24",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\nPlease enter the following information to create a new person:\n",
            "\nLastname: ",
            "\nFirstname: ",
            "\nAge: ",
            "\n--> The person was successfully deleted!\n",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\nPonbauer Martin, 24",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\n--> List was successfully cleared!\n",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):",
            "\n--> The list is empty\n",
            "\nI(nsert), R(emove), S(how), C(lear), E(nd):"
    };
    const char *err_txt[] = {};
    // act
    int exit_code = system(XSTR(TARGET)
    " 1>" OUTFILE " 2>" ERRFILE " <" INFILE_STANDARD);
    // assert
    CU_ASSERT_EQUAL(exit_code, 0);
    assert_lines(OUTFILE, out_txt, sizeof(out_txt) / sizeof(*out_txt));
    assert_lines(ERRFILE, err_txt, sizeof(err_txt) / sizeof(*err_txt));
}

/**
 * @brief Registers and runs the tests.
 */
int main(void) {
    // setup, run, teardown
    TestMainBasic("Selbststudium 5 - Linked List Modular", setup, teardown, test_compare_person,
                  test_compare_person_same, test_list_empty, test_list_empty_negative, test_list_add_in_sorted_order,
                  test_list_remove_element, test_list_remove_element_negative, test_list_clear_linked_list, test_main
    );
}