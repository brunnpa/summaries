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

; ------------------------------------------------------------------
; -- Variables
; ------------------------------------------------------------------
        AREA MyAsmVar, DATA, READWRITE
byte_array		SPACE	16	;byte array for values




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
		LDR		R7, =BITMASK_LOWER_NIBBLE;
		LDR		R0, =ADDR_DIP_SWITCH_7_0
		LDR		R1, =ADDR_DIP_SWITCH_15_8
		LDRB	R2, [R0];		;value from dip_switch 0-7
		LDRB	R3, [R1];		;value from dip_switch 8-15
		ANDS	R3, R3, R7;		;value from dip_switch 8-15 & 0x0F (lower 4 bits)
		
		LDR		R4, =ADDR_LED_7_0;	;load address from led 7-0 to reg4
		LDR		R5, =ADDR_LED_15_8;	;load address from led 15-8 to reg5
		STRB	R2, [R4];		;write value from dip_switch 0-7 to address from led 7-0
		STRB	R3, [R5];		;write value from dip_switch 8-15 to address from led 15-8
		
		LDR		R0, =byte_array;	;reassign reg0 with address of byte_array
		STRB	R2, [R0, R3];		;write valoe from dip_switch 0-7 to byte_array with offset of index(value)
		
		LDR		R1, =ADDR_DIP_SWITCH_31_24
		LDR		R2, =ADDR_LED_31_24
		LDRB	R3, [R1]
		ANDS	R3, R3, R7
		STRB	R3, [R2]
		
		LDR		R4, =ADDR_LED_23_16
		LDR		R5, [R0, R3]
		STRB	R5, [R4]
		
		
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
