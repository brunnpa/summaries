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
; -- CT1 P06 "ALU Befehle" Optionales beobachten der Flags und Befehle
; --
; -- $Id: main.s 532 2014-08-28 16:19:30Z fert $
; ------------------------------------------------------------------
;Directives
        PRESERVE8
        THUMB

; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------
        AREA myCode, CODE, READONLY

        ENTRY

main    PROC
        export main
            
        ;-----------------------------------------------------------
        ; Logische, Shift, Rotate Befehle

        LDR     R0, =0x0000FFFF
        LDR     R1, =0x0000FFFF
        LDR     R2, =1
        
        EORS    R0, R1
        LSLS    R0, R1, #16
        
        ORRS    R0, R0, R1
        LSLS    R0, R0, R2
        
        ASRS    R0, R0, R2
        ASRS    R0, R0, R2
        LSRS    R0, R0, R2
        
        LDR     R1, =0x00000004
        MVNS    R1, R1
        ANDS    R0, R0, R1
        
        LSRS    R0, R0, R2
        RORS    R0, R0, R2
        RORS    R0, R0, R2
        RORS    R0, R0, R2
        
        ;-----------------------------------------------------------
        ; Addition, Subtraktion
        
        LDR     R0, =0x80000000
        LDR     R1, =0x80000000
        LDR     R2, =0
        
        ADDS    R0, R0, R1
        ADCS    R0, R0, R2
        SUBS    R0, R0, R1
        
        SUBS    R0, R0, #2
        LDR     R2, =1
        SBCS    R0, R0, R2
        LSRS    R1, R1, R2
        SBCS    R0, R0, R2

        ;-----------------------------------------------------------
        ; Vergleiche
        
        LDR     R1, =0
        CMP     R1, R2
        CMP     R2, R1
        
        ORRS    R1, R1, R2
        CMP     R1, R2
        CMP     R2, R1
        
        LDR     R1, =0xFFFFFFFF
        CMN     R1, R2

        ;-----------------------------------------------------------
        ; JUMB/BRANCH Befehle
        
        ;-----------------------------------------------------------
        ; EXAMPLE 1

        BCC     do_not_branch_address
        BCS     example_2
        LDR     R0, =0

        ;-----------------------------------------------------------
        ; EXAMPLE 2
        
example_2
        BNE     do_not_branch_address
        BEQ     example_3
        LDR     R0, =0
        
        ;-----------------------------------------------------------
        ; EXAMPLE 3
        
example_3
        LDR     R0, =3
loop
        SUBS    R0, R0, R2
        BNE     loop

        ;-----------------------------------------------------------
        ; EXAMPLE 4        SWITCH CASE WITH JUMP TABLE

example_4
        ALIGN
TABLE   DCD     case0, case1, case2, case3, case4, case5    ; init table

        LDR     R1, =1                                      ; R1 holding where to switch to

switch_statement
        LDR     R0, =TABLE                                  ; R0 base address of jump table
        LSLS    R1, R1, #2                                  ; byte Displacement to word displacement
        LDR     R0, [R0, R1]                                ; jump to corresponding address
        BX      R0
case0
        LDR     R1, =2
        B       end_switch_statement
case1
        LDR     R1, =4
        B       end_switch_statement        
case2
        LDR     R1, =5
        B       end_switch_statement
case3
        B       example_5                                   ; leaving this jump demo
case4
        LDR     R1, =0
        B       end_switch_statement
case5
        LDR     R1, =3
        B       end_switch_statement
        
end_switch_statement        
        B       switch_statement                            ; do some more examples via jump table
        ALIGN

        ;-----------------------------------------------------------
        ; EXAMPLE 5

example_5                                                   ; switch case (how the compiler does it)
        import  switch_case_example
        BL      switch_case_example

        ;-----------------------------------------------------------
        ; ...once more... ? :-)

do_not_branch_address
        B       main
        ALIGN
        ENDP

; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
        END