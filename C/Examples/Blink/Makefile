WORKDIR = ./src
CC = avr-gcc
MCU = atmega32u4
CFLAGS = -Wall -g -mmcu=$(MCU) -I$(WORKDIR) -Os
PROG_ID = avr109

# Targets
all: main.hex

rebuild: clean all

# Get OS, only for macOS and Linux
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	USBPORT+=$(shell ls /dev/ttyACM*)
endif
ifeq ($(UNAME_S),Darwin)
	USBPORT+=$(shell ls /dev/tty.usbmodem*)
endif

main.hex: main.elf
	avr-objcopy -O ihex -j .text -j .data $^ $@

# Linking
main.elf: main.o
	$(CC) $(CFLAGS) $^ -o $@

# Compile to object file
main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

# Upload to the board
install: main.hex
	avrdude -v -p $(MCU) -c $(PROG_ID) -P ${USBPORT} -b 115200 -D -U flash:w:$<:i

# Get program size
size: main.elf
	@avr-size --mcu=$(MCU) -C $<

clean:
	rm -f *.hex *.o *.elf *.lst