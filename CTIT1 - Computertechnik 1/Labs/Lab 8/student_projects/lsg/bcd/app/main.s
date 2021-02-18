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
; -- CT1 P06 "ALU und Sprungbefehle" mit MUL
; --
; -- $Id: main.s 3728 2016-10-24 07:59:17Z kesr $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB

; ------------------------------------------------------------------
; -- Address Defines
; ------------------------------------------------------------------

ADDR_LED_15_0           EQU     0x60000100
ADDR_LED_31_16          EQU     0x60000102
ADDR_DIP_SWITCH_7_0     EQU     0x60000200
ADDR_DIP_SWITCH_15_8    EQU     0x60000201
ADDR_7_SEG_BIN_DS3_0    EQU     0x60000114
ADDR_BUTTONS            EQU     0x60000210

ADDR_LCD_RED            EQU     0x60000340
ADDR_LCD_GREEN          EQU     0x60000342
ADDR_LCD_BLUE           EQU     0x60000344
LCD_BACKLIGHT_FULL      EQU     0xffff
LCD_BACKLIGHT_OFF      	EQU     0x0000
	
ADDR_LCD_BIN			EQU		0x60000330
MASK_LOWER_4_BITS		EQU		0x0F
MASK_LAST_BIT			EQU		0x1

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY

        ENTRY

main    PROC
        export main
            
; STUDENTS: To be programmed
	
	; load address of bitmask (0x0F) to R6
	LDR 	R6, =MASK_LOWER_4_BITS
	; load address of dip_switch_7_0 to R7
	LDR 	R7, =ADDR_DIP_SWITCH_7_0
	; store input value from dip_switch_7_0 to R1
	LDRB 	R1, [R7]
	; use bitmask to get lower 4 bits (0000 xxxx)
	ANDS 	R1, R6
	
	; load address to dip_switch_15_8 to R7
	LDR 	R7, =ADDR_DIP_SWITCH_15_8
	; load input of dip_switch_15_8 to R2
	LDRB 	R2, [R7]
	; use bitmask to get lower 4 bits (0000 xxxx)
	ANDS 	R2, R6
	
	; shift value of dip_switch_15_8 to upper 4 bits
	LSLS 	R2, R2, #4
	; combine values from dip_switch_15_8(R2) and dip_switch_7_0(R1)
	; combination will get the bcd
	; store it in R3
	ADDS 	R3, R1, R2
	; store bcd value in R10 -> will be the output on LED_7_0
	MOV 	R10, R3															;--> HIER
	; Shift "ten-bits" in R2 back to the lower 4 bits
	LSRS 	R2, R2, #4
	
	; --- Button T0 --- 	
	
	; load address of buttons in R5
	LDR 	R5, =ADDR_BUTTONS
	; load address of Bitmask for last bit in R6
	; use bitmask to get the value of T0 bit only
	LDR		R6, =MASK_LAST_BIT
	; read state values from buttons and load it to R3
	LDRB	R3, [R5]
	; check if last bit is set? 
	; Z == 0 if pressed
	TST		R3, R6
	; BNE = Branch not Equal
	; if pressed use shift and add operations (if Z == 0)
	; else us muls
	BNE use_shift_add
	
	; -- MULS Instruction --
	
	; load value of tens digit
	LDR		R4, =10
	; Multiply tens digit from dip_switch_15_8 by 10
	MULS	R4, R2, R4
	; Add ones digit to already multiplied value in R4
	ADDS	R4, R4, R1
	; switch to Branch blue_lcd
	B blue_lcd

	; -- Branch use_shift_add --
use_shift_add
	; copy tens digit to R4
	MOV		R4, R2
	; Multiply by 2 --> R2 * 2^1
	LSLS	R4, #1
	; Multiply R2 by 8
	LSLS 	R2, #3
	; Add R4 = R2 * 2 - R2 = R2 * 8 = R2 * 10
	ADDS	R4, R2									; -> Hier
	; add ones digit
	ADDS	R4, R1
	; switch to Branch red_lcd
	B red_lcd
	
	; -- Branch red_lcd --
red_lcd
	; - turn off blue light -
	
	; load brightness value = 0% for LCD
	LDR 	R7, =LCD_BACKLIGHT_OFF
	; load address of "blue register" of LCD
	LDR 	R5, =ADDR_LCD_BLUE
	; turn off blue lcd backlight
	STRH	R7, [R5]
	
	; - turn on red light - 
	
	; load brightness value = 100% for LCD
	LDR		R7, =LCD_BACKLIGHT_FULL
	; load address of "red register" of LCD
	LDR		R5, =ADDR_LCD_RED
	; turn on red LCD backlight
	STRH	R7, [R5]
	; switch to branch show_result
	B show_result
	
	; -- Branch blue_lcd --
blue_lcd
	; - turn off red light -
	
	; load brightness value = 0% for LCD
	LDR		R7, =LCD_BACKLIGHT_OFF
	; load address of "red register" of LCD
	LDR		R5, =ADDR_LCD_RED
	; turn off red lcd backlight
	STRH 	R7, [R5]
	
	; - turn on blue light -
	
	; load brightness value = 100% for LCD
	LDR		R5, =ADDR_LCD_BLUE
	; load address of "blue register" of LCD
	LDR		R7, =LCD_BACKLIGHT_FULL
	; turn on blue lcd backlight
	STRH	R7, [R5]
	; switch to branch show_result
	B show_result

	; -- Branch show_result -- 
show_result

	; - display value on LEDs -
	
	; load address of led_7_0
	LDR 	R7, =ADDR_LED_7_0		
	; load stored BCD value (R10) into R3
	MOV 	R3, R10 					
	; write BCD value to led_7_0
	STRB 	R3, [R7] 				
	; load address of led_15_0
	LDR     R7, =ADDR_LED_15_8		
	; write value to led_15_8	
	STRB	R4, [R7]					

	; - display value on LCD -
	
	; load address if LCD					; ---> Hier
	LDR 	R6, =ADDR_LCD_BIN 			
	; write value to LCD
	STRB 	R4, [R6]					
	
	; - display value on 7 segment display -
	; load adress of 7 segment display
	LDR 	R7, =ADDR_7_SEG_BIN_DS3_0	
	; copy calculated result from R4 to R0
	MOV		R0, R4							; --> Hier
	; Shift value up 8 bits
	LSLS	R0, #8							
	; Combine value with bcd value
	ADDS	R0, R0, R3					
	; write value to 7 segment display
	STRH	R0, [R7]					
	
	; - Init registers for create_bar loop -
	; set value of R0 to zero to avoid displaying previous set values
	LDR 	R0, =0 						

	; -- Branch create_bar_loop -- 
create_bar_loop
	; Shift last digit into carry flag
	LSRS	R4, #1
	; If last digit set, switch to add_one
	; BCS -> Branch if Carry is Set
	BCS		add_one					
	; BEQ -> Branch if Equal
	; If value (in R4) is no 0, end loop
	BEQ		disco
	; switch to Branch create_bar_loop
	B create_bar_loop					
	
	; -- Branch add_one --
add_one
	; Shift bar storage to the left
	LSLS	R0, #1				
	; Add one to the bar
	ADDS	R0, #1				
	; switch to Branch create_bar_loop
	B create_bar_loop

	; -- Branch disco -- 
disco		
	; - Move disco-bar into start position -
	; Copy value R0 to R1
	MOV 	R1, R0 		
	; Shift values half word up
	LSLS 	R1, R1, #16					
	; Combine value to form full word with duplicated halfwords
	ORRS 	R0, R0, R1 					
	
	; Init registers for disco-loop
	; load address of LED_31_16 to R7
	LDR 	R7, =ADDR_LED_31_16
	; Loop 1 times for all 16 bits of the halfword
	LDR 	R5, =16				
	; Bitcount to rotate R0	
	LDR 	R1, =1 						
		
	; -- Branch disco_loop -- 
disco_loop
	; Output bars on leds
	STRH 	R0, [R7] 		
	; Right cyclic rotate by 1 bit
	RORS 	R0, R0, R1
	; Branch with link
	BL pause
	; decrement loop variable, sets Z flag to 1 if R5 is now 0
	SUBS 	R5, #1 			
	; If loop counter in R5 is not 0 (if Z == 0), continue loop
	; BNE -> If Branch is not equal
	BNE disco_loop 						


; END: To be programmed

        B       main
        ENDP
            
;----------------------------------------------------
; Subroutines
;----------------------------------------------------

;----------------------------------------------------
; pause for disco_lights
pause           PROC
        PUSH    {R0, R1}
        LDR     R1, =1
        LDR     R0, =0x000FFFFF
        
loop        
        SUBS    R0, R0, R1
        BCS     loop
    
        POP     {R0, R1}
        BX      LR
        ALIGN
        ENDP

; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        END
