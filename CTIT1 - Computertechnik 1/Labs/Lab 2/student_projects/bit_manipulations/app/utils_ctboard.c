/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ----------------------------------------------------------------------------
 * --
 * -- Project     : CT Board - Cortex M4
 * -- Description : Utilities for ct board.
 * --
 * -- $Id: utils_ctboard.c 2160 2015-06-08 12:28:00Z feur $
 * ------------------------------------------------------------------------- */

#include <stdint.h>
#include "utils_ctboard.h"

/* ----------------------------------------------------------------------------
 * -- Functions
 * ----------------------------------------------------------------------------
 */

/*
 * See header file
 */
uint8_t read_byte(uint32_t address)
{
    uint8_t *pointer;
    pointer = (uint8_t *)address;
    return *pointer;
}

/*
 * See header file
 */
uint16_t read_halfword(uint32_t address)
{
    uint16_t *pointer;
    pointer = (uint16_t *)address;
    return *pointer;
}

/*
 * See header file
 */
uint32_t read_word(uint32_t address)
{
    uint32_t *pointer;
    pointer = (uint32_t *)address;
    return *pointer;
}

/*
 * See header file
 */
uint64_t read_doubleword(uint32_t address)
{
    uint64_t *pointer;
    pointer = (uint64_t *)address;
    return *pointer;
}


/*
 * See header file
 */
void write_byte(uint32_t address, uint8_t data)
{
    uint8_t *pointer;
    pointer = (uint8_t *)address;
    *pointer = data;
}

/*
 * See header file
 */
void write_halfword(uint32_t address, uint16_t data)
{
    uint16_t *pointer;
    pointer = (uint16_t *)address;
    *pointer = data;
}

/*
 * See header file
 */
void write_word(uint32_t address, uint32_t data)
{
    uint32_t *pointer;
    pointer = (uint32_t *)address;
    *pointer = data;
}

/*
 * See header file
 */
void write_doubleword(uint32_t address, uint64_t data)
{
    uint64_t *pointer;
    pointer = (uint64_t *)address;
    *pointer = data;
}
