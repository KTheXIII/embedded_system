# Makefile

Makefile is a way to automate builds and upload the program the board.

Makefile syntax is as follows

```Makefile
target: dependencies
	command
```

**Note**: Makefile uses `tab` as the indentation so if you use spaces this won't work.

This creates a target we can target with `make` command with dependencies. We can also omit the dependencies and `make` won't check if it needs to do something else before running the command.

The `dependencies` are also used for detecting if a file has changed. Example: if we have our `main.c` as our dependency then `make` will check if it has been changed, it is has then the command will be run and if it is not then the command be will not be run.

Default for any `target` we create, `make` will run all of them. We can say to `make` to only run the command we want to run when we run `make` by creating a `target` with the name `all`. And input our own `dependencies`. `make` will run the one we gives. 

Example `all` target:

```Makefile
all: clean main

main: main.c
	gcc main.c

clean:
	rm -f a.out
```

Check the [C/Examples](/C/Examples) to see what Makefile might look like.

## Sample Makefile

```Makefile
CC = avr-gcc
MCU = atmega32u4
CFLAGS = -Wall -g -mmcu=$(MCU) -I$(WORKDIR) -Os

USBPORT += <usb_port>

all: main.hex

rebuild: clean all

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
	avrdude -v -p $(MCU) -c avr109 -P ${USBPORT} -b 115200 -D -U flash:w:$<:i

clean:
	rm -f *.hex *.o *.elf *.lst
```

`<usb_port>` is the port your device is connected to.