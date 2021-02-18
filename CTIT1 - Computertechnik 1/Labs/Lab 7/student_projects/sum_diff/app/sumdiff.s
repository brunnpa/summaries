; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- sumdiff.s
; --
; -- CT1 P05 Summe und Differenz
; --
; -- $Id: sumdiff.s 705 2014-09-16 11:44:22Z muln $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB

; ------------------------------------------------------------------
; -- Symbolic Literals
; ------------------------------------------------------------------
ADDR_DIP_SWITCH_7_0     EQU     0x60000200
ADDR_DIP_SWITCH_15_8    EQU     0x60000201
ADDR_LED_7_0            EQU     0x60000100
ADDR_LED_15_8           EQU     0x60000101
ADDR_LED_23_16          EQU     0x60000102
ADDR_LED_31_24          EQU     0x60000103

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA MyCode, CODE, READONLY

main    PROC
        EXPORT main

; INTRODUCTION
; Add / Sub two 8 Bit values
; left shift by 24Bit to observe carry and overflow flag
; right part will be filled with zeros

user_prog
        ; STUDENTS: To be programmed
		
		; --- LOAD OPERAND AND DO SHIFTING ---
		
		; ***read value from operand A -> Switch 8-15***
		; load address from DipSwitch 8 - 15
		LDR		R0, =ADDR_DIP_SWITCH_15_8
		; read value from operand A from DipSwitch 8 - 15
		LDRB	R1, [R0]
		; shift operand A 24 bits to the left as mentioned in Task1
		LSLS	R1, R1, #24
		
		; ***read value from operand B -> Switch 0-7***
		; load address from DipSwitch 0 - 7
		LDR		R0, =ADDR_DIP_SWITCH_7_0
		; read value from operand B from DipSwitch 0 - 7
		LDRB	R2, [R0]
		; shift operand B 24 bits to the left as mentioned in Task1
		LSLS	R2, R2, #24
		
		; --- ADDITION ---
		
		; do addition and save it to R3
		ADDS	R3, R1, R2	
		
		; ***display flags from addition on LED 12 - 15*** --> Wieso? noch nicht ganz verstanden...
		MRS 	R5, APSR
		LSRS 	R5,R5,#24
		LDR 	R0,=ADDR_LED_15_8
		STRB 	R5,[R0]
		
		; ***display MSB of SUM on LED 0-7***
		LSRS	R3, R3, #24
		LDR 	R0,=ADDR_LED_7_0
		STRB 	R3,[R0]
		
		
		; --- SUBTRACTION --- 
		
		; do difference and save it to R4
		SUBS	R4, R1, R2
		
		; display flags from difference on LED 28 - 31 --> Wieso? noch nicht ganz verstanden
		MRS 	R5, APSR
		LSRS 	R5,R5,#24
		LDR 	R0,=ADDR_LED_31_24
		STRB 	R5,[R0]
		
		; ***display MSB of DIFF on LED 16 - 23***
		LSRS	R4, R4, #24
		LDR 	R0,=ADDR_LED_23_16
		STRB 	R4,[R0]
		

        ; END: To be programmed
        B       user_prog
        ALIGN
; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        ENDP
        END
