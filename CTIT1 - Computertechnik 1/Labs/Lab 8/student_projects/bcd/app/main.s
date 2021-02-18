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

BITMASK_LOWER_4			EQU		0x0F
BITMASK_LASTBIT			EQU		0x00000001
; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY

        ENTRY

main    PROC
        export main
			
		; INTRODUCTION FOR TASK 3.1
		; Switches 0 - 3 contain the ones
		; Switches 8 - 11 contain the tens
		; Combined value shall be display as BCD on LED 0 - 7
		; BCD value shall be display on the 7segment (0-1) 
		; HEX value shall be display on the 7segment (2-3)
		; Combined value shall be display as binary on LED 8 -15
            
; STUDENTS: To be programmed

; ********************
; ***** TASK 3.1 *****
; ********************

; --- BitMask lower 4 Bits in R7 ---
		; Load addres of Bitmask to R7
		LDR		R7, =BITMASK_LOWER_4
		
; --- BCD Ones in R1 ---

		; load address of switches 0-7 (BCD-Ones)
		LDR		R0, =ADDR_DIP_SWITCH_7_0
		; read value of switches 0-7 (BCD-Ones)
		LDRB	R1, [R0]
		; mask the upper 4 bits
		ANDS	R1, R7	
		
; --- BCD Tens in R2 --- 
		
		; load address of switches 8-15
		LDR		R0, =ADDR_DIP_SWITCH_15_8
		; read value of switches 8-15
		LDRB	R2, [R0]
		; mask the upper 4 bits
		ANDS	R2, R7
		
; --- create combined BCD value in R3 ---
		; that we can combine the BCD value, we can combined them with ADD - but first we have to shift the BCD-tens
		
		; Left shift the tens
		LSLS	R2, R2, #4		
		; combine ones (R1) and tens(R2) and store it to R3
		ADDS	R3, R2, R1		
		; remove the shift by bcd-tens
		LSRS	R2, R2, #4

; --- BitMask last bit in R7 ---
		LDR		R7, =BITMASK_LASTBIT
		
; --- Button T0 ---
		; Load address from Buttons in R4
		LDR		R4, =ADDR_BUTTONS
		; Read value of Buttons in R5
		LDRB	R5, [R4]
		
		; Test if lastbit is set with TST
		; TST does the same as ANDS, but do not replace the result
		TST		R5, R7
		
		; if is not equal change to another branch -> use_shift_add
		; else use muls
		BNE		shifting

; --- Multiplication ---
		; load value (10) for multiplication
		LDR		R4, =10
		; Multiplication by 10 -> tens-value (R2)
		MULS	R4, R2, R4
		; Addition ones-value (R1) to the multiplicated result
		ADDS	R4, R4, R1
		
		; Go to blue_lcd-Branch
		B		blue_light


shifting
		; move value of tens to R4, so we don't lose the information
		MOV		R4, R2
		; it is not possible to a multiplication by 10 with left-shifting in one step
		; first we have multiply by 2 -> R4 * 2^1
		LSLS	R4, #1
		
		; the sum of different multiplication is the same as multiply it in one step
		; we have already multiply by 2, so the multiply by 8 is left
		; multiply by 8 -> R4 * 2^3(=8)
		LSLS	R4, #3
		
		; add the one-value to the multiplied value
		ADDS	R4, R1
		
		; go to red_lcd-branch
		B		red_light
	


blue_light
		; Load address of Backlight_off in R7 -> brightness = 0%
		LDR		R7, =LCD_BACKLIGHT_OFF
		
		; load address of red-color
		LDR		R6, =ADDR_LCD_RED
		
		; turn off the light
		STRH	R7, [R6]
		
		; now the backlight is off, so we can turn it on with the color blue
		; load address of backlight_full in R7 -> brightness = 100%
		LDR		R7, =LCD_BACKLIGHT_FULL
		; load address of blue-color
		LDR		R6, =ADDR_LCD_BLUE
		; set the red value to the backlight -> turn on the red light
		STRH	R7, [R6]
		
		; go to show_result-branch
		B		result
		
	
red_light
		; first we have to be sure, that the blue color is turned off -> everything is set to 0
		; Load address of Backlight_off in R7 -> brightness = 0%
		LDR		R7, =LCD_BACKLIGHT_OFF
		
		; load address of blue-color
		LDR		R6, =ADDR_LCD_BLUE
		
		; turn off the light
		STRH	R7, [R6]
		
		; now the backlight is off, so we can turn it on with the color red
		; load address of backlight_full in R7 -> brightness = 100%
		LDR		R7, =LCD_BACKLIGHT_FULL
		; load address of red-color
		LDR		R6, =ADDR_LCD_RED
		; set the red value to the backlight -> turn on the red light
		STRH	R7, [R6]
		
		; go to show_result-branch
		B		result
		
		

result
; --- display value on LEDs ---
		
		; load address of LED 0-15 in R7
		LDR		R7, =ADDR_LED_15_0
		; BCD value is in R3
		; multiplied value is in R4
		
		; copy value from R4 in R0, that we can combine the value
		MOV		R0, R4
		; left shifiting by 8 that we can combine it later with R3
		LSLS 	R0, #8
		
		; combine the value
		ADDS	R0, R0, R3

		; store value (R0) to LEDs (R7)
		STRB	R0, [R7]

; --- display value on 7 segment ---
		; load address of 7 segment
		LDR		R7, =ADDR_7_SEG_BIN_DS3_0
		
		MOV		R0, R4
		; shift multiplied-value from R4 with 8 bits
		; with the left-shifting of 8 bits, we make sure, that this will be displayed in the upper to 7 segments
		LSLS	R0, #8 
		
		; now we can combined the new value from R4 with the BCD-value (R3)
		; this is the way to show in the upper 2 the multiplied value and in the lower to the BCD value
		ADDS	R0, R0, R3
		
		; now we can store the new value from R4 (Halfword) (MULS|MULS|BCD|BCD) to the 7 segment
		STRH	R0, [R7]
		
; ********************
; ***** TASK 3.2 *****		--> nicht vollends verstanden
; ********************

		; BCD ones at R1
		; BCD tens at R2
		; BCD combined at R3
		; make sure that the new register is empty -> set to 0
		LDR		R0, =0

bar
		; from WIKIPEDIA: if we execute a rotate left through carry instruction, the result would be 10101011 with the carry flag cleared 
		; because the most significant bit (bit 7) was rotated into the carry while the carry was rotated into the least significant bit (bit 0).
		; -> we can right shift the result of R4
		LSRS	R4, #1	; 
		
		; if the carry flag is set, we know that we have to add a bit to the very beginning (right) 
		; BCS -> Branch if carry is set
		BCS		add_one_right		
		
		; if the zero flag is set, we can go into the disco-mode
		; BEQ -> Branch if Equal -> if zero flag is set
		BEQ		crazy_disco_mode
		
		; if neither the carry nor the zero flag is set, 
		; we have to do another round in the bar loop
		B		bar		


add_one_right
		; we have to shift the current result one to the left
		LSLS	R0, #1
		; add one to the bar
		ADDS	R0, #1
		
		B 		bar

crazy_disco_mode
		; copy value from the bar (R0) to a new register (R1)
		MOV		R1, R0
		
		; left shift a halfword -> as mentioned in pdf 
		LSLS	R1, R1, #16
		
		; to get a word (what is needed for the rotation) we can combined R1 and R0
		; we will get a duplicated halfword
		ORRS	R0, R0, R1
		
; --- LED 16 - 31 ----
		; load address of LED 16 - 31
		LDR		R7, =ADDR_LED_31_16
		
		; Loop one times for all 16 bits of halfword 	-> whaaaat?
		LDR		R5, =16
		
		; bitcounter for rotation R0 -> How big is the step by rotation
		LDR		R1, =1

crazy_rotation
		; store the barvalue (R0) on LEDs 16 - 31 (R7)
		STRH	R0, [R7]
		
		; Rotate Right -> ROR
		; This instruction is a preferred synonym for MOV instructions with shifted register operands.
		; S is an optional suffix. If S is specified, the condition flags are updated on the result of the operation.
		RORS	R0, R0, R1
		
		; BL -> Branch with Link
		; The BL instruction causes a branch to label, and copies the address of the next instruction into LR (R14, the link register).
		BL		pause
		
		; decrement the loop variable
		; if R5 is 0 -> zeroflag will be 1
		SUBS	R5, #1
		
		; if the loop counter (R5) is not 0 (-> Z == 0), the loop will be continued
		; BNE -> If branch is not equal
		BNE		crazy_rotation
		
		
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
