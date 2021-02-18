/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Implementation of module hal_rcc.
 *
 *  The hardware abstraction layer for the reset and clock control unit.
 *
 *  $Id$
 * ------------------------------------------------------------------------- */

/* User includes */
#include "hal_rcc.h"
#include "reg_stm32f4xx.h"


/* -- Macros
 * ------------------------------------------------------------------------- */

#define TIME_OUT        0x5000


/* -- Public function definitions
 * ------------------------------------------------------------------------- */

/*
 * See header file
 */
void hal_rcc_reset(void)
{
    /* Set RCC->CR to default values */
    RCC->CR |= 0x00000001;   // Set HSION bit first -> keep cpu running
    RCC->CR &= 0xeaf6ffff;   // Reset HSEON, CSSON, PLLON, PLLI2S,
                             //   PLLSAI bits (STM32F42xx/43xx)
    RCC->CR &= 0xfffbffff;   // Reset HSEBYP bit
    
    /* Reset RCC->CFGR to default values */
    RCC->CFGR = 0u;
    
    /* Reset RCC->PLLxCFGR to default values */
    RCC->PLLCFGR = 0x24003010;
    RCC->PLLI2SCFGR = 0x20003000;
    RCC->PLLSAICFGR = 0x24003000;  // only STM32F42xx/43xx)    
    
    /* Disable all interrupts */
    RCC->CIR = 0u;
    
    /* Disable all peripherals */
    RCC->AHB1RSTR = 0u;
    RCC->AHB2RSTR = 0u;  
    RCC->AHB3RSTR = 0u;
    RCC->APB1RSTR = 0u;
    RCC->APB2RSTR = 0u;
    RCC->AHB1ENR = 0x00100000;
    RCC->AHB2ENR = 0u;
    RCC->AHB3ENR = 0u;
    RCC->APB1ENR = 0u;
    RCC->APB2ENR = 0u;
    RCC->AHB1LPENR = 0x7e6791ff;
    RCC->AHB2LPENR = 0x000000f1;
    RCC->AHB3LPENR = 0x00000001;
    RCC->APB1LPENR = 0x36fec9ff;
    RCC->APB2LPENR = 0x00075f33;
    
    /* Reset forgotten registers */
    RCC->BDCR = 0u;
    RCC->CSR = 0x0e000000; 
    RCC->SSCGR = 0u;   
    RCC->DCKCFGR = 0u;   
}


/*
 * See header file
 */
void hal_rcc_set_peripheral(hal_peripheral_t peripheral, hal_bool_t status)
{
    volatile uint32_t *reg;
    uint32_t bit_pos;
    
    /* Select correct enable register */
    switch (peripheral) {
        /* AHB1 */
        case PER_GPIOA:
            bit_pos = 0u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOB:
            bit_pos = 1u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOC:
            bit_pos = 2u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOD:
            bit_pos = 3u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOE:
            bit_pos = 4u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOF:
            bit_pos = 5u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOG:
            bit_pos = 6u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOH:
            bit_pos = 7u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOI:
            bit_pos = 8u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOJ:
            bit_pos = 9u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_GPIOK:
            bit_pos = 10u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_DMA1:
            bit_pos = 21u;
            reg = &RCC->AHB1ENR;
            break;
        case PER_DMA2:
            bit_pos = 22u;
            reg = &RCC->AHB1ENR;
            break;
            
        /* AHB3 */
        case PER_FMC:
            bit_pos = 0u;
            reg = &RCC->AHB3ENR;
            break;
            
        /* APB1 */
        case PER_DAC:
            bit_pos = 29u;
            reg = &RCC->APB1ENR;
            break;
        case PER_PWR:
            bit_pos = 28u;
            reg = &RCC->APB1ENR;
            break;
        case PER_TIM2:
            bit_pos = 0u;
            reg = &RCC->APB1ENR;
            break;
        case PER_TIM3:
            bit_pos = 1u;
            reg = &RCC->APB1ENR;
            break;
        case PER_TIM4:
            bit_pos = 2u;
            reg = &RCC->APB1ENR;
            break;
        case PER_TIM5:
            bit_pos = 3u;
            reg = &RCC->APB1ENR;
            break;
            
        
        /* APB2 */
        case PER_ADC1:
            bit_pos = 8u;
            reg = &RCC->APB2ENR;
            break;
        case PER_ADC2:
            bit_pos = 9u;
            reg = &RCC->APB2ENR;
            break;
        case PER_ADC3:
            bit_pos = 10u;
            reg = &RCC->APB2ENR;
            break;
        
        default:
            return;
    }
    
    if (status == DISABLE) {
        *reg &= ~(1u << bit_pos);
    } else {
        *reg |= (1u << bit_pos);
    }
}


/*
 * See header file
 */
hal_bool_t hal_rcc_set_osc(hal_rcc_osc_t source, hal_bool_t status)
{
    uint32_t reg = 0;
    uint32_t count = 0;
    
    /* Disable source */
    if (status == DISABLE) {
        RCC->CR &= ~(1u << source);
        return DISABLED;
    }
    
    /* If pll, check if source is ok */
    if (source == HAL_RCC_OSC_PLL ||
        source == HAL_RCC_OSC_PLLI2S ||
        source == HAL_RCC_OSC_PLLSAI) 
    {
        reg = RCC->CR;
        /* HSE */
        if (RCC->PLLCFGR & ~(1u << 22u)) {
            reg &= (1u << (HAL_RCC_OSC_HSE + 1u));
        }
        /* HSI */
        else {
            reg &= (1u << (HAL_RCC_OSC_HSI + 1u));
        }
        /* Return if source is not ok */
        if (!reg) {
            return DISABLED;
        }
    }
    
    /* Enable source */    
    RCC->CR |= (1u << source);
    
    /* Wait till source is ready and if time out is reached exit */
    reg = RCC->CR & (1u << (source + 1u));
    while ((reg == 0) && (count != TIME_OUT)) {
        reg = RCC->CR & (1u << (source + 1u));
        count++;
    } 
    
    /* Return */
    if (reg != 0) {
        return ENABLED;
    }
    return DISABLED;
}


/*
 * See header file
 */
void hal_rcc_setup_pll(hal_rcc_osc_t pll, hal_rcc_pll_init_t init)
{
    /* Input check */
    if (init.m_divider < 2u) init.m_divider = 2u;
    
    if (init.n_factor < 2u) init.n_factor = 2u;
    if (init.n_factor > 432u) init.n_factor = 432u;
    
    if (init.p_divider > 8u) init.p_divider = 8u;
    
    if (init.q_divider < 2u) init.q_divider = 2u;
    
    init.r_divider &= 0x07;
    
    /* Set source or return if invalid */
    if (init.source == HAL_RCC_OSC_HSI) {
        RCC->PLLCFGR &= ~(1u << 22u);
    } else if (init.source == HAL_RCC_OSC_HSE) {
        RCC->PLLCFGR |= (1u << 22u);
    } else {
        return;
    }
    
    /* Set pll preescaler */
    RCC->PLLCFGR &= ~(0x3f);
    RCC->PLLCFGR |= init.m_divider;
    
    /* Configure pll */
    switch (pll) {
        case HAL_RCC_OSC_PLL:
            RCC->PLLCFGR &= ~0x0f037fc0;
            RCC->PLLCFGR |= (init.n_factor << 6u);
            RCC->PLLCFGR |= (((init.p_divider - 1) >> 1u) << 16u);
            RCC->PLLCFGR |= (init.q_divider << 24u);
            break;
        
        case HAL_RCC_OSC_PLLI2S:
            RCC->PLLI2SCFGR &= ~0x7f007fc0;
            RCC->PLLI2SCFGR |= (init.n_factor << 6u);
            RCC->PLLI2SCFGR |= (init.q_divider << 24u);
            RCC->PLLI2SCFGR |= (init.r_divider << 28u);
            break;
        
/*        case HAL_RCC_OSC_PLLSAI:
            RCC->PLLSAICFGR &= ~0x7f007fc0;
            RCC->PLLSAICFGR |= (init.n_factor << 6u);
            RCC->PLLSAICFGR |= (init.q_divider << 24u);
            RCC->PLLSAICFGR |= (init.r_divider << 28u);
            break;
*/        
        default:
            break;
    }
}


/*
 * See header file
 */
void hal_rcc_setup_clock(hal_rcc_clk_init_t init)
{
    uint32_t reg = 0;

    /* Configure clock divider */
    RCC->CFGR &= ~0x0000fcf0;
    RCC->CFGR |= (init.hpre << 4u);
    RCC->CFGR |= (init.ppre1 << 10u);
    RCC->CFGR |= (init.ppre2 << 13u);
    
    /* Select system clock source */
    RCC->CFGR &= ~0x00000003;
    switch (init.osc) {
        default:
        case HAL_RCC_OSC_HSI:
            reg = 0u;
            break;
        
        case HAL_RCC_OSC_HSE:
            reg = 1u;
            break;
        
        case HAL_RCC_OSC_PLL:
            reg = 2u;
            break;
    }
    RCC->CFGR |= reg;
    
#ifndef TESTING
    /* Wait till system clock is selected */
    while ((RCC->CFGR & 0x0000000c) != (reg << 2u));
#endif
}
