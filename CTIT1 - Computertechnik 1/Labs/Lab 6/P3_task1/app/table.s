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
        ; Eingabewert 	-> 	R7 = VALUE OF DIP_SWITCH 7_0
        ; Eingabeindex 	-> 	R6 = VALUE OF DIP_SWITCH 11_8
        ; Arrayadresse	->	R5 = ADDR OF data_array
        ; Ausgabeindex 	-> 	R4 = VALUE OF DIP_SWITCH 27_24    (AUSGABEINDEX)
 
        ; Load dip switch_7_0 address to R0
        LDR R0, =ADDR_DIP_SWITCH_7_0
		; Read-Byte value from R0 to R7
        LDRB R7,[R0]
        
		; Read address of LED 7-0 to R0
        LDR R0, =ADDR_LED_7_0
		; Write value of dipswitch (R7) into LED 7-0
        STRB R7,[R0]
        
		; Load dip switch_15_8 address to R0
        LDR R0,=ADDR_DIP_SWITCH_15_8
		; Read-Byte value from R0 to R6
        LDRB R6,[R0]
        
		; Load Address from Bitmask to R1
        LDR R1,=BITMASK_LOWER_NIBBLE
		; AND mask to remove the first 4 bits
        ANDS R6, R6, R1
              
		; Load Address from LED15-8 to R0
        LDR R0,=ADDR_LED_15_8
		; Write the value of the dip switch into the LEDs_15_8
        STRB R6,[R0]
        
		; Load Addres from Data-Array
        LDR R5,=data_array
		; Write value of Eingabewert into defined Eingabeindex
        STRB R7,[R5, R6]
 
		; Load Address from DipSwitch 31-24 to R0
        LDR R0,=ADDR_DIP_SWITCH_31_24
		; Read value from R0 to R4
        LDRB R4,[R0]
        

		; Load Address from Bitmask to R1
        LDR R1,=BITMASK_LOWER_NIBBLE
		; AND mask to remove the first 4 bits
        ANDS R4, R4, R1
        
        ; Load Address of LED31-24 to R0
        LDR R0,=ADDR_LED_31_24
		; Write the value of the dip switch into the LEDs_31_24
        STRB R4,[R0]
        
        ; Read the value of the data_array index and display it on
        ; the ADDR_LED_23_16 leds
		; Load Address from Address LED 23-16
        LDR R0,=ADDR_LED_23_16
		; Read-Byte value from R1 to R5 with Offset R4
        LDRB R1,[R5, R4]
		; Write value 
        STRB R1,[R0]
		
		
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
