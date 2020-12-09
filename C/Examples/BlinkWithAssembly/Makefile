CC=avr-gcc
CFLAGS= -Wall -g -mmcu=atmega32u4 -I./src

all: main.hex

rebuild: clean all

# For macOS only
USBPORT+=$(shell ls /dev/tty.usbmodem*)

main.hex: main.elf
	avr-objcopy -O ihex -j .text -j .data main.elf main.hex

# Linking
main.elf: main.o delay_asm.o
	$(CC) $(CFLAGS) main.o delay_asm.o -o main.elf

# Compile to object file
main.o: ./src/main.c
	$(CC) $(CFLAGS) -Os -c ./src/main.c

delay_asm.o: ./src/delay/delay.h ./src/delay/delay_asm.S
	$(CC) $(CFLAGS) -c ./src/delay/delay_asm.S

# Upload to the board
install: main.hex
	avrdude -v -p atmega32u4 -c avr109 -P ${USBPORT} -b 115200 -D -U flash:w:./main.hex:i

clean:
	rm -f *.hex *.o *.elf