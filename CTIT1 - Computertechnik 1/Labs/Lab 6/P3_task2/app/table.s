; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- table.s
; --
; -- CT1 P04 Ein- und Ausgabe von Tabellenwerten
; --
; -- $Id: table.s 800 2014-10-06 13:19:25Z ruan $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB
; ------------------------------------------------------------------
; -- Symbolic Literals
; ------------------------------------------------------------------
ADDR_DIP_SWITCH_7_0         EQU     0x60000200
ADDR_DIP_SWITCH_15_8        EQU     0x60000201
ADDR_DIP_SWITCH_31_24       EQU     0x60000203
ADDR_LED_7_0                EQU     0x60000100
ADDR_LED_15_8               EQU     0x60000101
ADDR_LED_23_16              EQU     0x60000102
ADDR_LED_31_24              EQU     0x60000103
ADDR_BUTTONS                EQU     0x60000210

ADDR_HEX_DISPLAY_0_1        EQU     0x60000114
ADDR_HEX_DISPLAY_2_3        EQU     0x60000115	



BITMASK_KEY_T0              EQU     0x01
BITMASK_LOWER_NIBBLE        EQU     0x0F
BITMASK_INDEX               EQU     0xFF00
BITMASK_VALUE               EQU     0x00FF

; ------------------------------------------------------------------
; -- Variables
; ------------------------------------------------------------------
        AREA MyAsmVar, DATA, READWRITE
byte_array		SPACE	32	;byte array for values




; END: To be programmed
        ALIGN

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY

main    PROC
        EXPORT main

readInput
        BL    waitForKey                    ; wait for key to be pressed and released
		; Eingabewert 	-> 	R7 = VALUE OF DIP_SWITCH 7_0    
        ; Eingabeindex	->	R6 = VALUE OF DIP_SWITCH 11_8   
        ; Adress Array	->	R5 = ADDR OF data_array
        ; Ausgabeindex	->	R4 = VALUE OF DIP_SWITCH 27_24    
 
        ; Read dip switch_7_0 address and value.
        LDR R0,=ADDR_DIP_SWITCH_7_0
        LDRB R7,[R0]
        
        ; Write the value of the dip switch into the LEDs_0_7
        LDR R0,=ADDR_LED_7_0
        STRB R7,[R0]
        
        ; Read dip switch_15_8 address and value.
        LDR R0,=ADDR_DIP_SWITCH_15_8
        LDRB R6,[R0]
        
        ; AND mask to remove the first 4 bits
        LDR R1,=BITMASK_LOWER_NIBBLE
        ANDS R6, R6, R1
        
        ; Write the value of the dip switch into the LEDs_15_8
        LDR R0,=ADDR_LED_15_8
        STRB R6,[R0]
		
		;Shift index to the left to add the value in the same register
		LSLS R1, R6, #8 
		; OR-Operation R1 and R7
		ORRS R1, R1, R7
		
		; Get address of data_array
        LDR R5,=data_array
		; Shift index left by one to get half word index
		LSLS R0, R6, #1
		; Write half word to data_array with offset
        STRH R1,[R5, R0]
		
		; Now it changes from writing to reading every register can be used again
 
        ; Read dip switch_27_24 address and value.
        LDR R0,=ADDR_DIP_SWITCH_31_24
        LDRB R4,[R0]
        
        ; AND mask to remove the first 4 bits
        LDR R1,=BITMASK_LOWER_NIBBLE
        ANDS R4, R4, R1
		
		; Write the value of the dip switch into the LEDs_31_24
        LDR R0,=ADDR_LED_31_24
        STRB R4,[R0]
		
		; Shift index left by one to get half word index
		LSLS R4, R4, #1 
		
		; Load value from array
		LDR R5,=data_array
		LDRH R2,[R5, R4]
		
		; Get index part from returned array value
		LDR R1,=BITMASK_INDEX
		MOVS R3,R2
		ANDS R3,R3,R1
		
		; Shift index back
		LSRS R3, R3, #8
		
        ; Write the value in the hex display
        LDR R0,=ADDR_HEX_DISPLAY_2_3
        STRB R3,[R0]
		
		; Get the value part of the returned array value
		LDR R1,=BITMASK_VALUE
		MOVS R3,R2 ; ANDS is only working with the same register
		ANDS R3,R3,R1
		
		; Write the value to the DS0 & DS1 hex display
        LDR R0,=ADDR_HEX_DISPLAY_0_1
        STRB R3,[R0]
        
		; Write the value also to the ADDR_LED_23_16
		LDR R0,=ADDR_LED_23_16
        STRB R3,[R0]
		
		
; END: To be programmed
        B       readInput
        ALIGN

; ------------------------------------------------------------------
; Subroutines
; ------------------------------------------------------------------

; wait for key to be pressed and released
waitForKey
        PUSH    {R0, R1, R2}
        LDR     R1, =ADDR_BUTTONS           ; laod base address of keys
        LDR     R2, =BITMASK_KEY_T0         ; load key mask T0

waitForPress
        LDRB    R0, [R1]                    ; load key values
        TST     R0, R2                      ; check, if key T0 is pressed
        BEQ     waitForPress

waitForRelease
        LDRB    R0, [R1]                    ; load key values
        TST     R0, R2                      ; check, if key T0 is released
        BNE     waitForRelease
                
        POP     {R0, R1, R2}
        BX      LR
        ALIGN

; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        ENDP
        END
