#include <reg_stm32f4xx.h>
#include <stdint.h>

void adc_init(void)
{
    // Clock configuration
    RCC->APB2ENR |= 0x00000400;
    RCC->APB1ENR |= 0x00000020;

    // Analog pin configuration
    GPIOF->MODER |= 0x00003000;

    // ADC configuration
    ADC3->CR1 |= 0x02000000;                                      // Resolution
                                                                  // -> 8 Bit,
                                                                  // scan mode
                                                                  // -> disabled
    ADC3->CR2 |= 0x00000002;                                      // Continous
                                                                  // conversion
                                                                  // mode ->
                                                                  // enabled

    // Enable ADC conversion
    ADC3->CR2 |= 0x00000001;                                  // ADC3 enable

    // Select the channel to be read from
    ADC3->SMPR2 |= 0x00006000;                          // Channel 4 sampling
                                                          // time -> 144 cycles
    ADC3->SQR3 |= 0x00000004;                               // Channel 4 rank
                                                              // -> 1 (?)
}

uint8_t adc_get_value(void)
{
    // Start the conversion
    ADC3->CR2 |= 0x40000000;

    // Wait till conversion is finished
    while (!ADC3->SR & 0x00000002) ;

    // Return the converted data
    return (uint8_t)ADC3->DR & 0x000000ff;
}
