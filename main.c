#include <stm32f4xx.h>
#include <stm32f4xx_hal_gpio.h>

#define LED1_PIN 12
#define LED2_PIN 15
#define LED1_ON() GPIOE->BSRR |= (1 << LED1_PIN)
#define LED1_OFF() GPIOE->BSRR &= ~(1 << LED1_PIN)
#define LED2_ON() GPIOE->BSRR |= (1 << LED2_PIN)
#define LED2_OFF() GPIOE->BSRR &= ~(1 << LED2_PIN)

int main() {
    /* Enbale GPIOA clock */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOEEN;
    /* Configure GPIOE pin 5 as output */
    GPIOE->MODER |= (1 << (LED1_PIN << 1));
    GPIOE->MODER |= (1 << (LED2_PIN << 1));
    /* Configure GPIOE pin 5 in max speed */
    GPIOE->OSPEEDR |= (3 << (LED1_PIN << 1));
    GPIOE->OSPEEDR |= (3 << (LED2_PIN << 1));

    /* Turn on the LED */
    LED1_OFF();
    /*if (result.rem == 1) {*/
    LED2_ON();
    /*}*/
}

/*void _exit(int code) {*/
    /*while (1)*/
        /*;*/
/*}*/

void _init(){}
