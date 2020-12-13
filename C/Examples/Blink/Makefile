CC=avr-gcc
MCU=atmega32u4
CFLAGS= -Wall -g -Os -mmcu=$(MCU) -I./

all: main.hex

rebuild: clean all

# For macOS
USBPORT+=$(shell ls /dev/tty.usbmodem*)

# Convert to hex
main.hex: main.elf
	avr-objcopy -j .text -j .data -O ihex main.o main.hex

# Link
main.elf: main.o
	$(CC) $(CFLAGS) main.o -o main.elf

# Compile to object file but don't link
main.o: main.c
	$(CC) $(CFLAGS) -c main.c

# Upload to the board
install: main.hex
	avrdude -v -p $(MCU) -c avr109 -P ${USBPORT} -b 115200 -D -U flash:w:./main.hex:i

clean:
	rm -f *.o *.hex *.elf