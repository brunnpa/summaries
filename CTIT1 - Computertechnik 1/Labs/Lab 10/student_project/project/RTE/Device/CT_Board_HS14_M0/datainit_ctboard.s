;* ------------------------------------------------------------------
;* --  _____       ______  _____                                    -
;* -- |_   _|     |  ____|/ ____|                                   -
;* --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
;* --   | | | '_ \|  __|  \___ \   Zurich University of             -
;* --  _| |_| | | | |____ ____) |  Applied Sciences                 -
;* -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
;* ------------------------------------------------------------------
;* --
;* -- Project     : CT Board - Cortex M4
;* -- Description : Data Segment initialisation.
;* -- 
;* -- $Id$
;* ------------------------------------------------------------------


; -------------------------------------------------------------------
; -- __Main
; ------------------------------------------------------------------- 

                AREA    |.text|, CODE, READONLY

                IMPORT main

                EXPORT __main

__main          PROC
    
                ; initialize RW and ZI data - this includes heap and stack for the -ro=... -rw=... -entry=... linking cmd args...
                IMPORT |Image$$RO$$Limit| [WEAK]
                IMPORT |Image$$RW$$Base|  [WEAK]
                IMPORT |Image$$ZI$$Base|  [WEAK]
                IMPORT |Image$$ZI$$Limit| [WEAK]
                ; ...or from auto generated scatter file. Needs linker option: --diag_suppress 6314
                IMPORT |Image$$ER_IROM1$$Limit|     [WEAK]
                IMPORT |Image$$RW_IRAM1$$Base|      [WEAK]
                IMPORT |Image$$RW_IRAM1$$ZI$$Base|  [WEAK]
                IMPORT |Image$$RW_IRAM1$$ZI$$Limit| [WEAK]
                ; import stack parameter
                IMPORT Stack_Size  [WEAK]
                IMPORT Stack_Mem   [WEAK]
                
                ; switch between command line generated regions and auto scatter file generated regions
                LDR    R1, =|Image$$RO$$Limit|
                CMP    R1,#0
                BEQ    ScatterFileSymbols
CommandLineSymbols
                LDR    R2, =|Image$$RW$$Base|   ; start of the RW data in RAM
                LDR    R3, =|Image$$ZI$$Base|   ; end of the RW data in RAM
                MOV    R5, R3                   ; start of zero initialized data
                LDR    R6, =|Image$$ZI$$Limit|  ; end of zero initialized data 
                B      CondRWLoop
ScatterFileSymbols
                LDR    R1, =|Image$$ER_IROM1$$Limit|      ; start of flashed initial RW data
                LDR    R2, =|Image$$RW_IRAM1$$Base|       ; start of the RW data in RAM
                LDR    R3, =|Image$$RW_IRAM1$$ZI$$Base|   ; end of the RW data in RAM
                MOV    R5, R3                             ; start of zero initialized data
                LDR    R6, =|Image$$RW_IRAM1$$ZI$$Limit|  ; end of zero initialized data 
                B      CondRWLoop
                
                ; init non-zero data
LoopRWCopy      LDR    R4, [R1]
                STR    R4, [R2]
                ADDS   R1, R1, #4
                ADDS   R2, R2, #4
CondRWLoop      CMP    R2, R3
                BNE    LoopRWCopy
                
                ; init zero-initialized data
                MOV    R2, R5
                MOV    R3, R6
                MOVS   R4, #0
                B      CondZILoop
LoopZICopy      STR    R4, [R2]
                ADDS   R2, R2, #4
CondZILoop      CMP    R2, R3
                BNE    LoopZICopy

                ; fingerprint stack section
                LDR    R0, =Stack_Mem
                LDR    R1, =Stack_Size
                LDR    R2, =0xEFBEADDE  ; stack fingerprint (little endian!)
LoopStack       STR    R2, [R0]
                ADDS   R0, R0, #4
                SUBS   R1, #4
                BNE    LoopStack

                ; go to the user main function                
                LDR    R0, =main
                BX     R0
                ENDP


; -------------------------------------------------------------------
; -- End of file
; -------------------------------------------------------------------  

                ALIGN
                    
                END
