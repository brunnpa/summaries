/* -----------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- main.c
 * --
 * -- main for Computer Engineering "Bit Manipulations"
 * --
 * -- $Id: main.c 744 2014-09-24 07:48:46Z ruan $
 * ------------------------------------------------------------------
 */
//#include <reg_scctboard.h>
#include "utils_ctboard.h"
#include <stdio.h>

#define ADDR_DIP_SWITCH_31_0 0x60000200
#define ADDR_DIP_SWITCH_7_0  0x60000200
#define ADDR_LED_31_24       0x60000103
#define ADDR_LED_23_16       0x60000102
#define ADDR_LED_15_8        0x60000101
#define ADDR_LED_7_0         0x60000100
#define ADDR_BUTTONS         0x60000210

// define your own macros for bitmasks below (#define)
/// STUDENTS: To be programmed

#define BRIGHT_BYTE	0xF0 
#define DARK_BYTE 0x3F
#define MASK_BYTE 0x0F

/// END: To be programmed

int main(void)
{
    uint8_t led_value = 0;
		uint8_t led_value_new = 0;
		uint8_t button_value = 0;
		uint8_t	button_changes = 0;
		uint8_t button_previous_value = 0;
		uint8_t	button_press_count = 0;
		uint8_t	button_push_count = 0;
		uint8_t variable = 0;
	
    // add variables below
    /// STUDENTS: To be programmed




    /// END: To be programmed

    while (1) {
        // ---------- Task 3.1 ----------
        led_value = read_byte(ADDR_DIP_SWITCH_7_0);
			

        /// STUDENTS: To be programmed
			
			// NAND-Verknüpfung des BRIGHT-BYTE, damit S7 und S6 immer den Wert 1 haben
				led_value &= ~BRIGHT_BYTE;
			
			// NOR Verknüpfung 1. Schritt: DARK_BYTE OR verknüpfen mit led_value
				led_value |= ~DARK_BYTE;



        /// END: To be programmed

        write_byte(ADDR_LED_7_0, led_value);

        // ---------- Task 3.2 and 3.3 ----------
        /// STUDENTS: To be programmed
				
				button_value = read_byte(ADDR_BUTTONS);
				
				if((button_value & 0x1) == 0x1){
					button_press_count++;
				}
				
				//calculate changes
				button_changes = ~button_previous_value & button_value;
				
				// is T0 pressed?
				if((button_changes & 0x1) == 0x1){
					button_push_count++;
				}
				
				//some button is pressed
				if(button_changes > 0x0){
						//T3 is pressed - show the value 
					if((button_changes & 0x8) == 0x8) {
							variable = read_byte(ADDR_DIP_SWITCH_7_0);
					}
						//T2 is pressed - inverte the current value
					else if((button_changes & 0x4) == 0x4){
							variable = ~variable;
					}
						//T1 is pressed - do a left-bitshifting
					else if((button_changes & 0x2) == 0x2){
							variable = variable << 1;
					}
						//T0 is pressed - do a right-bitshifting
					else if((button_changes & 0x1) == 0x1){
							variable = variable >> 1;
					}
				}
				
				//write the values to the different LEDs
				write_byte(ADDR_LED_15_8, button_press_count);
				write_byte(ADDR_LED_31_24, button_push_count);
				write_byte(ADDR_LED_23_16, variable);
				
				//save the current button value
				button_previous_value = button_value;

				

        /// END: To be programmed
    }
}