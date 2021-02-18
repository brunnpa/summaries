#ifndef MY_32_64_BIT_ASSEMBLERCODE_MACROS
#define MY_32_64_BIT_ASSEMBLERCODE_MACROS

#ifndef __x86_64

  #ifndef __arm__
    // *** 32-Bit X86  *********************************************************

    #define SAVE_SP(VAR)    __asm__  __volatile__ ("  MOVL %esp, "#VAR"");
    #define RESTORE_SP(VAR) __asm__  __volatile__ ("  MOVL "#VAR", %esp");

    #define SAVE_REGS()    __asm__  __volatile__ ( \
                        "   PUSHA \n\t"            \
                        "   PUSHF     ")

    #define RESTORE_REGS()  __asm__  __volatile__ (  \
                        "   POPF  \n\t"              \
                        "   POPA      ")

  #endif

#else

    // *** 64-Bit architectures ************************************************

    #ifdef __linux
        #define SAVE_SP(VAR)    __asm__  __volatile__ ("  MOVQ %rsp, "#VAR"(%rip)");
        #define RESTORE_SP(VAR) __asm__  __volatile__ ("  MOVQ "#VAR"(%rip), %rsp");
    #endif
    #ifdef __APPLE__
        #define SAVE_SP(VAR)    __asm__  __volatile__ ("  MOVQ %rsp, _"#VAR"(%rip)");
        #define RESTORE_SP(VAR) __asm__  __volatile__ ("  MOVQ _"#VAR"(%rip), %rsp");
    #endif

    #define SAVE_REGS() __asm__  __volatile__ (\
                        "   PUSH %rax   \n\t" \
                        "   PUSH %rcx   \n\t" \
                        "   PUSH %rdx   \n\t" \
                        "   PUSH %rbx   \n\t" \
                        "   PUSH %rsp   \n\t" \
                        "   PUSH %rbp   \n\t" \
                        "   PUSH %rsi   \n\t" \
                        "   PUSH %rdi   \n\t" \
                        "   PUSH %r8    \n\t" \
                        "   PUSH %r9    \n\t" \
                        "   PUSH %r10   \n\t" \
                        "   PUSH %r11   \n\t" \
                        "   PUSH %r12   \n\t" \
                        "   PUSH %r13   \n\t" \
                        "   PUSH %r14   \n\t" \
                        "   PUSH %r15   \n\t" \
                        "   PUSHFQ   ")

    #define RESTORE_REGS() __asm__  __volatile__ (\
                        "   POPFQ       \n\t" \
                        "   POP %r15    \n\t" \
                        "   POP %r14    \n\t" \
                        "   POP %r13    \n\t" \
                        "   POP %r12    \n\t" \
                        "   POP %r11    \n\t" \
                        "   POP %r10    \n\t" \
                        "   POP %r9     \n\t" \
                        "   POP %r8     \n\t" \
                        "   POP %rdi    \n\t" \
                        "   POP %rsi    \n\t" \
                        "   POP %rbp    \n\t" \
                        "   POP %rsp    \n\t" \
                        "   POP %rbx    \n\t" \
                        "   POP %rdx    \n\t" \
                        "   POP %rcx    \n\t" \
                        "   POP %rax   ")

    // save state of FPU, etc.,  *mem: address of 512 Byte memory region
    void SAVE_FX(char *mem) {
        __asm__ __volatile__ ("FXSAVE  (%%rdi);\n"::"D"(mem), "m"(*mem));    
    }

    // restore state of FPU, etc.,  *mem: address of 512 Byte memory region
    void RESTORE_FX(char *mem) {
        __asm__ __volatile__ ("FXRSTOR  (%%rdi);\n":: "D"(mem), "m"(*mem));
    }

#endif  // __x86_64

//******************************************************************************

#endif  // MY_32_64_BIT_ASSEMBLERCODE_MACROS

//******************************************************************************
// in the case ARM

#ifdef __arm__

#define SAVE_REGS()    __asm__  __volatile__ ( 					\
                        "   stmfd	sp!, {r0-r12, r14}	\n\t"	\
                        "   mrs		r0, apsr	 		\n\t"	\
						"   stmfd	sp!, {r0}");

#define RESTORE_REGS()  __asm__  __volatile__ (  				\
						"   ldmfd	sp!, {r0} 	 		\n\t"	\
						"   msr		apsr_nzcvq, r0	 	\n\t"	\
                        "   ldmfd	sp!, {r0-r12, r14}");

#define SAVE_SP(VAR)	SAVE_SP_P(&VAR)
#define RESTORE_SP(VAR)	RESTORE_SP_P(&VAR)

void SAVE_SP_P(void *var);
void RESTORE_SP_P(void *var);

__asm__  (  ".text					\n" \
			".global SAVE_SP_P		\n" \
			"SAVE_SP_P:				\n" \
			"	str     sp, [r0]	\n" \
			"	bx      lr			\n" \
);

__asm__  ( ".text					\n" \
			".global RESTORE_SP_P	\n" \
			"RESTORE_SP_P:			\n" \
			"	ldr     sp, [r0]	\n" \
			"	bx      lr			\n" \
);

#endif

//******************************************************************************
