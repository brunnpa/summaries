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

BITMASK_KEY_T0              EQU     0x01
BITMASK_LOWER_NIBBLE        EQU     0x0F

DDR_SEG7_BIN   				EQU     0x60000114
	
FOO 				EQU     0xFFFF

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
		
		LDR		R7, =BITMASK_LOWER_NIBBLE	; Bitmask 0x0F
		
		LDR		R0, =ADDR_DIP_SWITCH_7_0	; address of dip_switch_7_0
		LDR		R1, =ADDR_DIP_SWITCH_15_8	; address of dip_switch_15_8
		
		; INPUT_VALUE = R2
		LDRB	R2, [R0];					; read value from dip_switch_7_0 and store it in R2
		
		; INDEX = R3
		LDRB	R3, [R1];					; read value from dip_switch_15_8 and store it in R3
		
		; INDEX = R3
		ANDS	R3, R3, R7;					; AND operation: input_index & 0x0F  -> 0000 xxxx
		
		LDR		R4, =ADDR_LED_7_0;			; address of led_7_0
		LDR		R5, =ADDR_LED_15_8;			; address of led_15_8
		
		STRB	R2, [R4];					; write input_index value to led_7_0
		STRB	R3, [R5];					; write input_value to led_15_8
		
		; overwrite R0 with address of byte_array
		LDR		R0, =byte_array;			; address of byte_array
		
		LSLS 	R6, R3, #8					; move index to upper byte of halfword
		
		ANDS 	R2, R2, R6					; combine index and value
		
		; INDEX = R3
		LSLS 	R3, R3, #1					; multiply input_index * 2 by left shift of 1 single bit
		
		
		STRH	R4, [R0, R3];				; write valoe from dip_switch 0-7 to byte_array with offset of index(value)
		
		LDR		R1, =ADDR_DIP_SWITCH_31_24	; address of dip_switch_31_24
		LDR		R4, =ADDR_LED_31_24			; address of led_31_24
		
		; OUTPUT_INDEX = R3
		LDRB	R3, [R1]					; read value from dip_switch_31_24 and store it in R3
		ANDS	R3, R3, R7					; AND operation: output_index & 0x0F -> 0000 xxxx
		STRB	R3, [R4]					; write output_index to led_31_24
		
		LSLS 	R3, R3, #1					; multiply output_index * 2 by left shift of 1 single bit
		LDRH 	R5, [R0, R3]				; retrieve half word from byte_array: byte_array[R3]
		
		LDR 	R7, =DDR_SEG7_BIN			; overwrite R7 with 7 segment display address	
		STRH 	R5, [R7, #0]				; write half word to 7 segment display
		
		LDR		R4, =ADDR_LED_23_16			; address of led_23_16
		STRB	R5, [R2]					; write value from byte_array to led_23_16
		
		
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
