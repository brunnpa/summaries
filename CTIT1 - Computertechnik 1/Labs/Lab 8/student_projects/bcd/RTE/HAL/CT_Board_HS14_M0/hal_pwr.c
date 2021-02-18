/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Implementation of module hal_pwr.
 *
 *  The hardware abstraction layer for the power control unit.
 *
 *  $Id$
 * ------------------------------------------------------------------------- */

/* User includes */
#include "hal_pwr.h"
#include "reg_stm32f4xx.h"


/* -- Macros
 * ------------------------------------------------------------------------- */

#define TIME_OUT            0x1000
#define MASK_PERIPH_PWR     (1u << 28u)


/* -- Public function definitions
 * ------------------------------------------------------------------------- */

/*
 * See header file
 */
void hal_pwr_reset(void)
{
    /* Reset peripheral */
    PWR->CR = 0x0000c000;
    PWR->CSR = 0x00000000;
}


/*
 * See header file
 */
hal_bool_t hal_pwr_set_backup_domain(hal_bool_t status)
{
    uint16_t count = 0;
    uint32_t reg = 0;
    
    if (status == DISABLE) {
        /* Disable backup domain / regulator */
        PWR->CSR &= ~(1u << 9u);        
        return DISABLED;
    }

    /* Enable backup domain / regulator */
    PWR->CSR |= (1u << 9u);

    /* Wait till regulator is ready and if time out is reached exit */
    reg = PWR->CSR & (1u << 3u);
    while ((reg == 0) && (count != TIME_OUT)) {
        reg = PWR->CSR & (1u << 3u);
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
void hal_pwr_set_backup_access(hal_bool_t status)
{
    if (status == DISABLE) {
        PWR->CR &= ~(1u << 8u);
    } else {
        PWR->CR |= (1u << 8u);
    }
}


/*
 * See header file
 */
void hal_pwr_set_wakeup_pin(hal_bool_t status)
{
    if (status == DISABLE) {
        PWR->CSR &= ~(1u << 8u);
    } else {
        PWR->CSR |= (1u << 8u);
    }
}


/*
 * See header file
 */
void hal_pwr_set_flash_powerdown(hal_bool_t status)
{
    if (status == DISABLE) {
        PWR->CR &= ~(1u << 9u);
    } else {
        PWR->CR |= (1u << 9u);
    }
}


/*
 * See header file
 */
hal_bool_t hal_pwr_set_overdrive(hal_bool_t status)
{
    /* Is this realy nedded ?
       Extend clock to 180 MHz if HSI/HSE is used, but pll ? */
    return DISABLED;
}


/*
 * See header file
 */
hal_bool_t hal_pwr_set_underdrive(hal_bool_t status)
{
    /* Is this realy nedded ? */
    return DISABLED;
}
