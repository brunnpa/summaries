#include "utils_ctboard.h"

#define LED 0x60000100
#define SWITCHES 0x60000200
#define P11 0x60000211
#define DS0 0x60000110
#define MASK 0x0F

uint32_t dipSwitchValue; 

int p11Value;


int main(void) {
	/* initializations go here */
	const uint8_t array[16] = { 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71 };
		
	while(1) {
		/* This is the application*/
		dipSwitchValue = read_word(SWITCHES);
		
		write_word(LED, dipSwitchValue);
		
		p11Value = read_byte(P11) & MASK;
		
		write_byte(DS0, ~array[p11Value]);
			
		
		
	}
}