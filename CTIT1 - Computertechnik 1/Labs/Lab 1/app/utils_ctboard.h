/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ----------------------------------------------------------------------------
 * --
 * -- Module      : ctboard_utils
 * -- Description : Interface for module.
 * --
 * -- $Id: utils_ctboard.h 1122 2015-01-06 13:57:04Z feur $
 * ------------------------------------------------------------------------- */
#ifndef _UTILS_CTBOARD
#define _UTILS_CTBOARD

#include <stdint.h>

/* ----------------------------------------------------------------------------
 * -- Function prototypes
 * ----------------------------------------------------------------------------
 */

/*
 * Functions to read either a byte, halfword, word or
 * doubleword from an arbitrary address.
 * @param   address: address to read from (32 bit)
 * @retval  data @ address
 */
uint8_t  read_byte(uint32_t address);
uint16_t read_halfword(uint32_t address);
uint32_t read_word(uint32_t address);
uint64_t read_doubleword(uint32_t address);


/*
 * Functions to write either a byte, halfword, word or
 * doubleword to an arbitrary address.
 * @param   address: address to write to (32 bit)
 *          data: data to write @ address
 */
void write_byte(uint32_t address, uint8_t data);
void write_halfword(uint32_t address, uint16_t data);
void write_word(uint32_t address, uint32_t data);
void write_doubleword(uint32_t address, uint64_t data);

/* ----------------------------------------------------------------------------
 * -- Header file end
 * ----------------------------------------------------------------------------
 */
#endif
