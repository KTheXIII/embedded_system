#include <avr/io.h>

#include "delay/delay.h"

int main() {
    DDRC |= 0x80;

    while (1) {
        PORTC |= 0x80;  // 0b10000000 = 128
        delay_ms(200U);
        PORTC &= ~0x80;
        delay_ms(200U);
    }

    return 0;
}