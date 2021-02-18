; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- main.s
; --
; -- CT1 P08 "Strukturierte Codierung" mit Assembler
; --
; -- $Id: struct_code.s 3787 2016-11-17 09:41:48Z kesr $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB

; ------------------------------------------------------------------
; -- Address-Defines
; ------------------------------------------------------------------
; input
ADDR_DIP_SWITCH_7_0       EQU        0x60000200
ADDR_BUTTONS              EQU        0x60000210

; output
ADDR_LED_31_0             EQU        0x60000100
ADDR_7_SEG_BIN_DS3_0      EQU        0x60000114
ADDR_LCD_COLOUR           EQU        0x60000340
ADDR_LCD_ASCII            EQU        0x60000300
ADDR_LCD_ASCII_BIT_POS    EQU        0x60000302
ADDR_LCD_ASCII_2ND_LINE   EQU        0x60000314
	
BITMASK					  EQU		 0x00000001


; ------------------------------------------------------------------
; -- Program-Defines
; ------------------------------------------------------------------
; value for clearing lcd
ASCII_DIGIT_CLEAR        EQU         0x00000000
LCD_LAST_OFFSET          EQU         0x00000028

; offset for showing the digit in the lcd
ASCII_DIGIT_OFFSET        EQU        0x00000030

; lcd background colors to be written
DISPLAY_COLOUR_RED        EQU        0
DISPLAY_COLOUR_GREEN      EQU        2
DISPLAY_COLOUR_BLUE       EQU        4

; ------------------------------------------------------------------
; -- myConstants
; ------------------------------------------------------------------
        AREA myConstants, DATA, READONLY
; display defines for hex / dec
DISPLAY_BIT               DCB        "Bit "
DISPLAY_2_BIT             DCB        "2"
DISPLAY_4_BIT             DCB        "4"
DISPLAY_8_BIT             DCB        "8"
        ALIGN

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY
        ENTRY

        ; imports for calls
        import adc_init
        import adc_get_value

main    PROC
        export main
        ; 8 bit resolution, cont. sampling
        BL         adc_init 
        BL         clear_lcd

main_loop
; STUDENTS: To be programmed
		
		; get adc_value and store it in R0
		BL adc_get_value
		
		; Load address button and mask with (0000'0001)
		LDR 		R1, =ADDR_BUTTONS
		LDR 		R2, [R1]
		LDR 		R3, =BITMASK
		ANDS 		R2, R2, R3
		
		; Test if last bit is set to 1
		TST 		R1, R3
		
		BEQ			T0_pressed
		BNE			T0_not_pressed

T0_pressed

		; load address of LCD_Display
		LDR			R1, =ADDR_LCD_COLOUR
		LDR			R2, [R1]
		
		; load address of green-value
		LDR			R1, =DISPLAY_COLOUR_GREEN
		
		; store color to lcd-display
		STR			R2, [R1]
		
		; load address of 7 segment
		LDR			R3, =ADDR_7_SEG_BIN_DS3_0
		
		; write value on 7 segment
		LDRB		R2, [R3]
		
		


T0_not_pressed

		; load address of switch 0 - 7
		LDR			R1, =ADDR_DIP_SWITCH_7_0
		; read value from switch 0 - 7
		LDRB		R2, [R1]
		
		; subtract switch-value - adc_value
		SUBS		R2, R2, R0
		
		; if(diff >= 0) 
		CMP			R2, #0		
		
		BEQ			blue
		BNE			red
		

blue
		; load address of LCD_Display
		LDR			R1, =ADDR_LCD_COLOUR
		LDR			R2, [R1]
		
		; load address of blue-value
		LDR			R1, =DISPLAY_COLOUR_BLUE
		
		; store color to lcd-display
		STR			R2, [R1]
		
		; load address of 7 segment
		LDR			R3, =ADDR_7_SEG_BIN_DS3_0
		
		; write value on 7 segment
		LDRB		R2, [R3]
		
		B 			main_loop
		

red
		; load address of LCD_Display
		LDR			R1, =ADDR_LCD_COLOUR
		LDR			R2, [R1]
		
		; load address of blue-value
		LDR			R1, =DISPLAY_COLOUR_BLUE
		
		; store color to lcd-display
		STR			R2, [R1]
		
		; load address of 7 segment
		LDR			R3, =ADDR_7_SEG_BIN_DS3_0
		
		; write value on 7 segment
		LDRB		R2, [R3]

calculate_magnitude
		; result value will be in R2
		LDR         R2, =0x0000
		; As mentioned in PDF, use 5 MSB of 8-bit Value (2^5 = 32)
        LSRS        R1, #3
		; check if result is already 0
		CMP			R1, =0
		; if zero is set, go to result
        BEQ         show_result 

loop_calculate_magnitude
		; shift result value one to the left
        LSLS        R2, #1
		; add to result value one
        ADDS        R2, #1
		; subtract from initial value one
        SUBS        R1, #1
		
		; compare if zero is set, else do another calculation-round
		CMP			R1, =0
        BNE         loop_calculate_magnitude
		BEQ			show_result
		
show_result
        LDR         R3, =ADDR_LED_31_0
        STR         R2, [R3]
		B			main_loop

; END: To be programmed
        B          main_loop
        
clear_lcd
        PUSH       {R0, R1, R2}
        LDR        R2, =0x0
clear_lcd_loop
        LDR        R0, =ADDR_LCD_ASCII
        ADDS       R0, R0, R2                       ; add index to lcd offset
        LDR        R1, =ASCII_DIGIT_CLEAR
        STR        R1, [R0]
        ADDS       R2, R2, #4                       ; increas index by 4 (word step)
        CMP        R2, #LCD_LAST_OFFSET             ; until index reached last lcd point
        BMI        clear_lcd_loop
        POP        {R0, R1, R2}
        BX         LR

write_bit_ascii
        PUSH       {R0, R1}
        LDR        R0, =ADDR_LCD_ASCII_BIT_POS 
        LDR        R1, =DISPLAY_BIT
        LDR        R1, [R1]
        STR        R1, [R0]
        POP        {R0, R1}
        BX         LR

        ENDP
        ALIGN


; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        END
