; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- add64.s
; --
; -- CT1 P05 64 Bit Addition
; --
; -- $Id: add64.s 3712 2016-10-20 08:44:57Z kesr $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB

; ------------------------------------------------------------------
; -- Symbolic Literals
; ------------------------------------------------------------------
ADDR_DIP_SWITCH_31_0        EQU     0x60000200
ADDR_BUTTONS                EQU     0x60000210
ADDR_LCD_RED                EQU     0x60000340
ADDR_LCD_GREEN              EQU     0x60000342
ADDR_LCD_BLUE               EQU     0x60000344
ADDR_LCD_BIN                EQU     0x60000330
MASK_KEY_T0                 EQU     0x00000001
BACKLIGHT_FULL              EQU     0xffff

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA MyCode, CODE, READONLY

main    PROC
        EXPORT main
			
		; INTRODUCTION
		; 64 Bit Sum-Variable as Output
		; Every time T0 is pressed add 32Bit from Switch 0 - 31 to Sum-Variable
		; The sum shall be display on the LCD Display

user_prog
        LDR     R7, =ADDR_LCD_BLUE              ; load base address of pwm blue
        LDR     R6, =BACKLIGHT_FULL             ; backlight full blue
        STRH    R6, [R7]                        ; write pwm register

        LDR     R0, =0                          ; lower 32 bits of total sum
        LDR     R1, =0                          ; higher 32 bits of total sum
endless
        BL      waitForKey                      ; wait for key T0 to be pressed

        ; STUDENTS: To be programmed
		
		; load input value from Switch 0 - 31
		; do not use R0, this is for the lower 32 bits (word)
		; do not use R1, this is for the higher 32 bits (word)
		LDR		R2, =ADDR_DIP_SWITCH_31_0
		
		; read inputvalue and store it in R0
		LDR		R3, [R2]
		
		; add input value to the total sum in R0
		ADDS	R0, R0, R3
		
		; read the processor flags
		MRS		R2, APSR
		
		; remove negative and zero flags --> (nzcv'0000'0000'0000'0000'0000'0000'0000) => (cv00'0000'0000'0000'0000'0000'0000'0000)
		LSLS	R2, R2, #2
		
		; remove all bits, that only the carry-flag is set
		; Right shifting with 31 --> (0000'000c)
		LSRS	R2, R2, #31
		
		; if the carry is set, we have to increase the higher 32 bits by 1
		; Addition with R1 (higher 32 Bits) and Carry-Flag (+1 if carry is set, +0 if carry is not set)
		ADDS	R1, R1, R2
		
		; load address of lcd binary interface as mentioned in PDF
		LDR		R5, =ADDR_LCD_BIN
		
		; now we have to combine the lower(R0) and higher(R1) 32bits
		; store the lower 32bits to the lcd binary interface without an offset -> lower
		STR		R0, [R5, #0]
		
		; to combine the higher to the lower bits, we have to write it additionally
		; we can store it to the lcd binary interface with the offset 
		STR		R1, [R5, #4]
		
		



        ; END: To be programmed
        B       endless
        ALIGN


;----------------------------------------------------
; Subroutines
;----------------------------------------------------

; wait for key to be pressed and released
waitForKey
        PUSH    {R0, R1, R2}
        LDR     R1, =ADDR_BUTTONS               ; laod base address of keys
        LDR     R2, =MASK_KEY_T0                ; load key mask T0

waitForPress
        LDRB    R0, [R1]                        ; load key values
        TST     R0, R2                          ; check, if key T0 is pressed
        BEQ     waitForPress

waitForRelease
        LDRB    R0, [R1]                        ; load key values
        TST     R0, R2                          ; check, if key T0 is released
        BNE     waitForRelease

        POP     {R0, R1, R2}
        BX      LR
        ALIGN

; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        ENDP
        END
