WORKDIR = ./src
CC = avr-gcc
MCU = atmega32u4
CFLAGS = -Wall -g -mmcu=$(MCU) -I$(WORKDIR) -Os

all: main.hex

rebuild: clean all

# For macOS only
USBPORT+=$(shell ls /dev/tty.usbmodem*)

# For Linux only
# USBPORT+=$(shell ls /dev/ttyACM*)

main.hex: main.elf
	avr-objcopy -O ihex -j .text -j .data $^ $@

# Linking
main.elf: main.o delay_asm.o
	$(CC) $(CFLAGS) $^ -o $@

# Compile to object file
%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compile to object file
delay_asm.o: src/delay/delay.h src/delay/delay_asm.S
	$(CC) $(CFLAGS) -c src/delay/delay_asm.S -o $@

# Upload to the board
install: main.hex
	avrdude -v -p $(MCU) -c avr109 -P ${USBPORT} -b 115200 -D -U flash:w:$^:i

clean:
	rm -f *.hex *.o *.elf *.lst