/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Interface of module system_ctboard.
 *  Description : Basic system configuration.
 *                * initialize system clock
 *                * initialize FMC (SRAM & GPIO)
 *  
 *  GPIO FMC pin assignment:
 *  
 *  PD0  > FMC_D2    | PE0  > FMC_NBL0   | PF0  > FMC_A0   | PG0  > FMC_A10
 *  PD1  > FMC_D3    | PE1  > FMC_NBL1   | PF1  > FMC_A1   | PG1  > FMC_A11
 *  PD3  > FMC_CLK   | PE2  > FMC_A23    | PF2  > FMC_A2   | PG2  > FMC_A12
 *  PD4  > FMC_NOE   | PE3  > FMC_A19    | PF3  > FMC_A3   | PG3  > FMC_A13
 *  PD5  > FMC_NWE   | PE4  > FMC_A20    | PF4  > FMC_A4   | PG4  > FMC_A14
 *  PD6  > FMC_WAIT  | PE5  > FMC_A21    | PF5  > FMC_A5   | PG5  > FMC_A15
 *  PD7  > FMC_NE1   | PE6  > FMC_A22    | PF12 > FMC_A6   | PG9  > FMC_NE2
 *  PD8  > FMC_D13   | PE7  > FMC_D4     | PF13 > FMC_A7   | PG10 > FMC_NE3
 *  PD9  > FMC_D14   | PE8  > FMC_D5     | PF14 > FMC_A8   | PG12 > FMC_NE4
 *  PD10 > FMC_A15   | PE9  > FMC_D6     | PF15 > FMC_A9   | PG13 > FMC_A24
 *  PD11 > FMC_A16   | PE10 > FMC_D7     |                 |
 *  PD12 > FMC_A17   | PE11 > FMC_D8     |                 |
 *  PD13 > FMC_A18   | PE12 > FMC_D9     |                 |
 *  PD14 > FMC_D0    | PE13 > FMC_D10    |                 |
 *  PD15 > FMC_D1    | PE14 > FMC_D11    |                 |
 *                   | PE15 > FMC_D12    |                 |
 * 
 *  $Id$
 * ------------------------------------------------------------------------- */

/* Standard includes */
#include <stdint.h>


/* User includes */
#include "system_ctboard.h"
#include "reg_stm32f4xx.h"
#include "reg_ctboard.h"


/* -- Macros (LCD)
 * ------------------------------------------------------------------------- */

#define LCD_WAIT            0x1fff


/* -- Macros (FMC)
 * ------------------------------------------------------------------------- */

#define FMC_PORTD_PINMASK   0xfffb
#define FMC_PORTE_PINMASK   0xffff
#define FMC_PORTF_PINMASK   0xf03f
#define FMC_PORTG_PINMASK   0x363f


/* -- Local function declarations
 * ------------------------------------------------------------------------- */

static void init_SystemClock(void);
static void init_FPU(void);
static void init_FMC_SRAM(void);
static void init_LCD(void);


/* -- Public function definitions
 * ------------------------------------------------------------------------- */

/**
 *  \brief  Entry point used in startup.
 */
void __system(void)
{
    system_enter_run();
}


/*
 * See header files
 */
void system_enter_run(void)
{
    /* Initialize RCC / system clock */
    init_SystemClock();
    
    /* Iitialize FPU */
    init_FPU();
    
    /* Initialize SRAM interface */
    init_FMC_SRAM();
    
    /* Initialize LCD on CT-Board */
    init_LCD();
}


/*
 * See header file
 */
void system_enter_sleep(hal_pwr_lp_entry_t entry)
{
    /** \note   Implement this function if needed. */
}


/*
 * See header file
 */
void system_enter_stop(hal_pwr_regulator_t regulator, hal_pwr_lp_entry_t entry)
{
    /** \note   Implement this function if needed. */
}


/*
 * See header file
 */
void system_enter_standby(void)
{
    /** \note   Implement this function if needed. */
}


/* -- Local function definitions
 * ------------------------------------------------------------------------- */

/**
 *  \brief  Configures the System clock source, PLL Multiplier and Divider 
 *          factors, AHB/APBx prescalers and Flash settings.
 */
static void init_SystemClock(void)
{
    hal_rcc_pll_init_t pll_init;
    hal_rcc_clk_init_t clk_init;
    
    /* Enable used periphery */
    PWR_ENABLE();
    
    /* Reset */
    hal_rcc_reset();
    PWR_RESET();
    
    /* Enable HSE oscillator and proceed if ok */
    if (hal_rcc_set_osc(HAL_RCC_OSC_HSE, ENABLE)) {
        /* Select regulator voltage output Scale 1 mode */
        RCC->APB1ENR |= 0x00000000;
        PWR->CR |= 0x0000c000;
        
        /* Configure PLL */
        pll_init.source = HAL_RCC_OSC_HSE;
        pll_init.m_divider = 4u;
        pll_init.n_factor = 168u;
        pll_init.p_divider = 2u;
        pll_init.q_divider = 7u;
        hal_rcc_setup_pll(HAL_RCC_OSC_PLL, pll_init);
        
        /* Enable PLL */
        hal_rcc_set_osc(HAL_RCC_OSC_PLL, ENABLE);
        
        /* Enable overdrive to allow system clock >= 168 MHz */
        hal_pwr_set_overdrive(ENABLE); 
        
        /* Configure Flash prefetch, Instruction cache, Data cache 
         * and wait state */
        FLASH->ACR = 0x00000705;
        
        /* Setup system clock */
        clk_init.osc = HAL_RCC_OSC_PLL;
        clk_init.hpre = HAL_RCC_HPRE_2;     // -> AHB clock : 84 MHz
        clk_init.ppre1 = HAL_RCC_PPRE_2;    // -> APB1 clock : 48 MHz
        clk_init.ppre2 = HAL_RCC_PPRE_2;    // -> APB2 clock : 48 MHz
        hal_rcc_setup_clock(clk_init);
        
    } else {
        /* If HSE fails to start-up, the application will have wrong clock con-
           figuration. User can add here some code to deal with this error */
    }   
}


/**
 *  \brief  Initialize the floating point unit in M4 mode.
 */
static void init_FPU(void)
{
#ifdef PLATFORM_M4
    /* No documentation about this, even the registers... */
    
    /* set CP10 and CP11 Full Access */
    FPU->CPACR |= ((3u << 20u)|(3u << 22u));
#endif
}


/**
 *  \brief  Setup the flexible memory controller. This function configures the SRAM
 *          interface for accessing the periphery on the CT Board.
 */
static void init_FMC_SRAM(void)
{
#ifndef NO_FMC
    
    hal_gpio_output_t gpio_init;
    hal_fmc_sram_init_t sram_init;
    hal_fmc_sram_timing_t sram_timing;
    
    /* Enable used peripherals */
    GPIOD_ENABLE();
    GPIOE_ENABLE();
    GPIOF_ENABLE();
    GPIOG_ENABLE();
    FMC_ENABLE();
    
    /* Configure the involved GPIO pins to AF12 (FMC) */
    gpio_init.pupd = HAL_GPIO_PUPD_NOPULL;
    gpio_init.out_speed = HAL_GPIO_OUT_SPEED_50MHZ;
    gpio_init.out_type = HAL_GPIO_OUT_TYPE_PP;
    
    /* GPIOD configuration (pins: 0,1,3-15) */
    gpio_init.pins = FMC_PORTD_PINMASK;
    hal_gpio_init_alternate(GPIOD, HAL_GPIO_AF_FMC, gpio_init);
    
    /* GPIOE configuration (pins: 0-15) */
    gpio_init.pins = FMC_PORTE_PINMASK;
    hal_gpio_init_alternate(GPIOE, HAL_GPIO_AF_FMC, gpio_init);
    
    /* GPIOF configuration (pins: 0-5,12-15) */
    gpio_init.pins = FMC_PORTF_PINMASK;
    hal_gpio_init_alternate(GPIOF, HAL_GPIO_AF_FMC, gpio_init);
    
    /* GPIOG configuration (pins: 1-5, 9, 10, 12, 13) */
    gpio_init.pins = FMC_PORTG_PINMASK;
    hal_gpio_init_alternate(GPIOG, HAL_GPIO_AF_FMC, gpio_init);
    
    
    /* Initialize the synchronous PSRAM on bank 1 */
    sram_init.address_mux = DISABLE;
    sram_init.type = HAL_FMC_TYPE_PSRAM;
    sram_init.width = HAL_FMC_WIDTH_16B;
    sram_init.read_burst = ENABLE;
    sram_init.write_enable = ENABLE;
    sram_init.write_burst = ENABLE;
    sram_init.continous_clock = ENABLE;
    
    sram_timing.bus_turnaround = 1u;
    sram_timing.clk_divider = 15u;
    sram_timing.data_latency = 2u;
    
    hal_fmc_init_sram(HAL_FMC_SRAM_BANK1, sram_init, sram_timing);   
    
    
    /* Initialize the asynchronous SRAM on bank 2 */
    sram_init.address_mux = DISABLE;
    sram_init.type = HAL_FMC_TYPE_SRAM;
    sram_init.width = HAL_FMC_WIDTH_16B;
    sram_init.read_burst = DISABLE;
    sram_init.write_enable = DISABLE;
    sram_init.write_burst = DISABLE;
    sram_init.continous_clock = DISABLE;
    
    sram_timing.bus_turnaround = 1u;
    sram_timing.address_setup = 11u;
    sram_timing.address_hold = 5u;
    sram_timing.data_setup = 11u;
    sram_timing.mode = HAL_FMC_ACCESS_MODE_A;
    
    hal_fmc_init_sram(HAL_FMC_SRAM_BANK2, sram_init, sram_timing);
    
#endif
}


/**
 *  \brief  Wait for the LCD controller on the CT Board to be initialized.
 *  \TODO   Possibly adjust LCD controller on CPLD to set status bit 
 *          and wait for it in this function.
 */
static void init_LCD(void)
{
#ifndef NO_FMC
    uint32_t wait_for_lcd = LCD_WAIT;    
    for(; wait_for_lcd > 0; wait_for_lcd--);     
#endif
}

