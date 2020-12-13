#include <avr/io.h>

#define F_CPU 16000000UL
#include <util/delay.h>

int main(int argc, char const *argv[]) {
  DDRB |= 0x80;

  while (1) {
    PORTB |= 0x80; // 0b10000000 = 128
    _delay_ms(250);
    PORTB &= ~0x00;
    _delay_ms(250);
  }

  return 0;
}
