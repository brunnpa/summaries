/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Implementation of module hal_gpio.
 * 
 *  The hardware abstraction layer for the GPIO periphery.
 *
 *  $Id$
 * ------------------------------------------------------------------------- */

/* User includes */
#include "hal_gpio.h"


/* -- Macros
 * ------------------------------------------------------------------------- */

#define NVIC_OFFSET_1_4     ( 6u)
#define NVIC_OFFSET_5_9     (23u)
#define NVIC_OFFSET_10_15   ( 8u)


/* -- Local function declarations
 * ------------------------------------------------------------------------- */

static uint32_t create_pattern_mask(uint16_t pins,
                                    uint8_t pattern,
                                    uint8_t pattern_bit_width);
static uint16_t intercept_overwrite_register(reg_gpio_t *port, uint16_t pins);
static uint8_t get_syscfg_mask(reg_gpio_t *port);


/* -- Public function definitions
 * ------------------------------------------------------------------------- */

/*
 * See header file
 */
void hal_gpio_reset(reg_gpio_t *port)
{
    if(port == GPIOA) {
        /* Reset GPIOA specific values */
        port->MODER = 0xa8000000;
        port->OSPEEDR = 0x00000000;
        port->PUPDR = 0x64000000;
    }
    else if (port == GPIOB) {
        /* Reset GPIOB specific values */
        port->MODER = 0x00000280;
        port->OSPEEDR = 0x000000c0;
        port->PUPDR = 0x00000100;
    } else {
        /* Reset other GPIO */
        port->MODER = 0x00000000;
        port->OSPEEDR = 0x00000000;
        port->PUPDR = 0x00000000;
    }
    
    port->OTYPER = 0x00000000;
    port->AFRL = 0x00000000;
    port->AFRH = 0x00000000;
    port->ODR = 0x00000000;
}

/*
 * See header file
 */
void hal_gpio_init_input(reg_gpio_t *port, hal_gpio_input_t init)
{
    /* prevent overwrite false reg entry */
    init.pins = intercept_overwrite_register(port, init.pins);

    /* process mode */
    port->MODER &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->MODER |= create_pattern_mask(init.pins, HAL_GPIO_MODE_IN, 2u);

    /* process pull up/down resitors */
    port->PUPDR &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->PUPDR |= create_pattern_mask(init.pins, init.pupd, 2u);
}


/*
 * See header file
 */
void hal_gpio_init_analog(reg_gpio_t *port, hal_gpio_input_t init)
{
    /* treat like input */
    hal_gpio_init_input(port, init);
    
    /* change mode */
    port->MODER &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->MODER |= create_pattern_mask(init.pins, HAL_GPIO_MODE_AN, 2u);
}


/*
 * See header file
 */
void hal_gpio_init_output(reg_gpio_t *port, hal_gpio_output_t init)
{
    /* prevent overwrite false reg entry */
    init.pins = intercept_overwrite_register(port, init.pins);

    /* process mode */
    port->MODER &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->MODER |= create_pattern_mask(init.pins, HAL_GPIO_MODE_OUT, 2u);

    /* process pull up/down resitors */
    port->PUPDR &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->PUPDR |= create_pattern_mask(init.pins, init.pupd, 2u);    

    /* process port speed */
    port->OSPEEDR &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->OSPEEDR |= create_pattern_mask(init.pins, init.out_speed, 2u); 

    /* process output typ  */
    port->OTYPER &= ~init.pins;
    if(init.out_type == HAL_GPIO_OUT_TYPE_OD){
        port->OTYPER |= init.pins;
    }
}


/*
 * See header file
 */
void hal_gpio_init_alternate(reg_gpio_t *port, 
                             hal_gpio_af_t af_mode,
                             hal_gpio_output_t init)
{
    /* treat like output */
    hal_gpio_init_output(port, init);
    
    /* change mode */
    port->MODER &= ~create_pattern_mask(init.pins, 0x3, 2u);
    port->MODER |= create_pattern_mask(init.pins, HAL_GPIO_MODE_AF, 2u);
    
    /* process af type */
    port->AFRL &= ~create_pattern_mask(init.pins, 0xf, 4u);
    port->AFRL |= create_pattern_mask(init.pins, af_mode, 4u);
    port->AFRH &= ~create_pattern_mask((init.pins >> 8), 0xf, 4u);
    port->AFRH |= create_pattern_mask((init.pins >> 8), af_mode, 4u);
}


/*
 * See header file
 */
uint16_t hal_gpio_input_read(reg_gpio_t *port)
{
    return (uint16_t) port->IDR;
}


/*
 * See header file
 */
uint16_t hal_gpio_output_read(reg_gpio_t *port)
{
    return (uint16_t) port->ODR;
}


/*
 * See header file
 */
void hal_gpio_output_write(reg_gpio_t *port, uint16_t port_value)
{
    /* prevent overwrite false reg entry */
    port_value = intercept_overwrite_register(port, port_value);
    port->ODR = port_value;
}


/*
 * See header file
 */
void hal_gpio_bit_set(reg_gpio_t *port, uint16_t pins)
{
    /* prevent overwrite false reg entry */
    pins = intercept_overwrite_register(port, pins);

    /* exit if no pins to be configured */
    if (pins != 0) {
        port->BSRR = pins;
    }
}


/*
 * See header file
 */
void hal_gpio_bit_reset(reg_gpio_t *port, uint16_t pins)
{
    /* prevent overwrite false reg entry */
    pins = intercept_overwrite_register(port, pins);

    /* exit if no pins to be configured */
    if (pins != 0) {
        port->BSRR = (pins << 16);
    }
}


/*
 * See header file
 */
void hal_gpio_bit_toggle(reg_gpio_t *port, uint16_t pins)
{
    uint16_t pattern;

    /* prevent overwrite false reg entry */
    pins = intercept_overwrite_register(port, pins);

    /* exit if no pins to be configured */
    if (pins != 0) {
        /* get actual value and invert */
        pattern = hal_gpio_output_read(port);
        pattern = ~pattern;

        /* mask pins */
        pattern &= pins;

        port->ODR = pattern;
    }
}


/*
 * See header file
 */
void hal_gpio_irq_set(reg_gpio_t *port, 
                      uint16_t pins, 
                      hal_gpio_trg_t edge,
                      hal_bool_t status)
{
    uint8_t syscfg_bank, nvic_bank, syscfg_shift, exti_line;
    uint32_t exticr_mask;
    
    for (exti_line = 0u; exti_line < 16u; exti_line++) {
        if (pins & (0x1 << exti_line)) {
            syscfg_bank = exti_line / 4u;
            syscfg_shift = exti_line % 4u;
            nvic_bank = (exti_line < 10u) ? 0u : 1u;
            
            if (status == ENABLE) {                
                /* Trigger (rising/falling/both) */
                if (edge & HAL_GPIO_TRG_POS) {
                    EXTI->RTSR |= (0x1 << exti_line);
                }
                if (edge & HAL_GPIO_TRG_NEG) {
                    EXTI->FTSR |= (0x1 << exti_line);
                }
                /* Set EXTI line to corresponding GPIO port */
                exticr_mask = get_syscfg_mask(port);
                if (syscfg_bank == 0u) {
                    SYSCFG->EXTICR1 &= ~(0xf << syscfg_shift);
                    SYSCFG->EXTICR1 |= (exticr_mask << syscfg_shift);
                } else if (syscfg_bank == 1u) {
                    SYSCFG->EXTICR2 &= ~(0xf << syscfg_shift);
                    SYSCFG->EXTICR2 |= (exticr_mask << syscfg_shift);
                } else if (syscfg_bank == 2u) {
                    SYSCFG->EXTICR3 &= ~(0xf << syscfg_shift);
                    SYSCFG->EXTICR3 |= (exticr_mask << syscfg_shift);
                } else if (syscfg_bank == 3u) {
                    SYSCFG->EXTICR4 &= ~(0xf << syscfg_shift);
                    SYSCFG->EXTICR4 |= (exticr_mask << syscfg_shift);
                }

                /* Unmask interrupt */
                EXTI->IMR |= (0x1 << exti_line);
                if (nvic_bank == 0u) {
                    NVIC->ISER0 |= ((exti_line <  5u) ? (0x1 << (exti_line + NVIC_OFFSET_1_4)) :
                                    (exti_line < 10u) ? NVIC_OFFSET_5_9 : NVIC_OFFSET_10_15);                    
                } else if (nvic_bank == 1u) {
                    NVIC->ISER1 |= ((exti_line <  5u) ? (0x1 << (exti_line + NVIC_OFFSET_1_4)) :
                                              (exti_line < 10u) ? NVIC_OFFSET_5_9 : NVIC_OFFSET_10_15);                  
                } else if (nvic_bank == 2u) {
                    NVIC->ISER2 |= ((exti_line <  5u) ? (0x1 << (exti_line + NVIC_OFFSET_1_4)) :
                                              (exti_line < 10u) ? NVIC_OFFSET_5_9 : NVIC_OFFSET_10_15);                   
                }

            } else {
                /* Mask interrupt */
                EXTI->IMR &= ~(0x1 << exti_line);
                if (nvic_bank == 0u) {
                    NVIC->ICER0 |= ((exti_line <  5u) ? (0x1 << (exti_line + NVIC_OFFSET_1_4)) :
                                              (exti_line < 10u) ? NVIC_OFFSET_5_9 : NVIC_OFFSET_10_15);                    
                } else if (nvic_bank == 1u) {
                    NVIC->ICER1 |= ((exti_line <  5u) ? (0x1 << (exti_line + NVIC_OFFSET_1_4)) :
                                              (exti_line < 10u) ? NVIC_OFFSET_5_9 : NVIC_OFFSET_10_15);                  
                } else if (nvic_bank == 2u) {
                    NVIC->ICER2 |= ((exti_line <  5u) ? (0x1 << (exti_line + NVIC_OFFSET_1_4)) :
                                              (exti_line < 10u) ? NVIC_OFFSET_5_9 : NVIC_OFFSET_10_15);
                }
            }
        }
    }
    
}


/*
 * See header file
 */
hal_bool_t hal_gpio_irq_status(uint16_t pin)
{
    hal_bool_t status = DISABLED;
    
    if ((EXTI->IMR && pin) &&
        (EXTI->PR && pin)) {
        status = ENABLED;
    }
    
    return status;
}


/*
 * See header file
 */
void hal_gpio_irq_clear(uint16_t pin)
{
    EXTI->PR |= pin;
}


/* -- Local function definitions
 * ------------------------------------------------------------------------- */

/**
 *  \brief  Creates a pattern based on specified pins.
 *
 * example: pins = 1,3,4 (0x001a) / pattern = 0x2 (2 bit wide)
 *          ==>  pattern = 0x0000'0288
 *
 *          0b0..0'0001'1010      / 0b10 (2 bit wide)
 *                    ^ ^ ^
 *          ==>  0b0..0'00010'1000'1000
 *                         ^^ ^^   ^^
 *
 * pattern_bit_width must be 2 or 4
 */
static uint32_t create_pattern_mask(uint16_t pins,
                                    uint8_t pattern,
                                    uint8_t pattern_bit_width)
{
    const uint8_t mask_bit_width = 32u;
    const uint16_t pin1_mask = 1u;

    uint8_t pos, end;
    uint32_t mask = 0u;

    if (pattern_bit_width == 2u || pattern_bit_width == 4u) {
        /* create pattern mask */
        end = mask_bit_width / pattern_bit_width;
        for (pos = 0; pos < end; pos++) {
            if (pins & pin1_mask) {
                mask |= pattern << (pos * pattern_bit_width);
            }
            pins >>= 1;
        }
    } else {
        /* exit if pattern_bit_width not as needed */
        mask = 0u;
    }

    return mask;
}


/**
 *  \brief  This function ensures that these sensitive pins are not reconfigured.
 *
 *  On GPIOA and GPIOB only pins 11 down to 0 are available to the user. 
 *  Pins 15 down to 12 are used for system functions of the discovery board, 
 *  e.g. connection of the debugger.
 *  These pins must not be reconfigured. Otherwise the debugger cannot be used any more.
 */
static uint16_t intercept_overwrite_register(reg_gpio_t *port, uint16_t pins){
    if (port == GPIOA || port == GPIOB){
        pins &= 0x0FFF;
    }
    return pins;
}


/**
 *  \brief  Returns mask for configuration of SYSCFG_EXTICR register.
 *  \param  port : Port of which the mask should be generated.
 *  \return Mask for specified port.
 */
static uint8_t get_syscfg_mask(reg_gpio_t *port)
{
    return ((port == GPIOA) ? 0u :
            (port == GPIOB) ? 1u :
            (port == GPIOC) ? 2u :
            (port == GPIOD) ? 3u :
            (port == GPIOE) ? 4u :
            (port == GPIOF) ? 5u :
            (port == GPIOG) ? 6u :
            (port == GPIOH) ? 7u :
            (port == GPIOI) ? 8u :
            (port == GPIOJ) ? 9u : 10u);
}
