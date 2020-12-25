# C Programming for AVR

This contains notes on how to install `avr-gcc` and compile the code. Head to [Development Environment](#development-environment) for setup.

For setting up an editor with intellisense check out [Editor.md](/C/Editor.md) for more info.

## Table of Contents

- [C Programming for AVR](#c-programming-for-avr)
  - [Table of Contents](#table-of-contents)
  - [Resources](#resources)
  - [Development Environment](#development-environment)
    - [macOS](#macos)
      - [Using homebrew](#using-homebrew)
    - [Linux](#linux)
    - [Windows](#windows)
  - [Compile and Program](#compile-and-program)
    - [macOS](#macos-1)
      - [Compile](#compile)
      - [Program](#program)
    - [Linux](#linux-1)
      - [compile](#compile-1)
      - [Program](#program-1)
    - [Windows (TODO)](#windows-todo)

## Resources

These are the resources for getting the software and guide.

- [homebrew-avr](https://github.com/osx-cross/homebrew-avr)
- [Linux/macOS/Windows](https://blog.podkalicki.com/how-to-compile-and-burn-the-code-to-avr-chip-on-linuxmacosxwindows/)
- [crosspack](https://www.obdev.at/products/crosspack/index.html)
- [AVR Options](https://gcc.gnu.org/onlinedocs/gcc/AVR-Options.html#AVR-Options)
- [avr-gcc](https://github.com/topics/avr-gcc) topic on Github

## Development Environment

This section contain the guide for getting the software needed to compile and program. Check [Compile and Program](#compile-and-program) for compiling and programming the board.

### macOS

On macOS you can download and install the [crosspack](https://www.obdev.at/products/crosspack/index.html). This will install `avr-gcc` and such for you.

#### Using homebrew

If you have [homebrew](https://brew.sh) install you can use it to install `avr-gcc`. For more info check [homebrew-avr](https://github.com/osx-cross/homebrew-avr).

**Add the osx-cross/avr to brew tap**

```
brew tap osx-cross/avr
```

**Install avr-gcc**

```
brew install avr-gcc
```

### Linux 

You will need to install `avr-gcc`, `avrdude` and most likely `avr-libc`
There is most likely an [ArduinoCore-avr](https://github.com/arduino/ArduinoCore-avr) on you distro, if that is the case you can install that

**On Ubuntu**  
And probably most derivatives
```
sudo apt-get install arduino-core
```

**On Arch**
```
sudo pacman -S arduino-avr-core
```

### Windows

On Windows it is better to install [Atmel Studio 7](https://www.microchip.com/mplab/microchip-studio) and [Arduino](https://www.arduino.cc). Atmel Studio have the compiler and is a full fledge IDE for compiling your code and Arduino has `avrdude` that can program the board.

## Compile and Program

### macOS

#### Compile

There are 2 steps in compiling the code. The Step 1 has two version, compiling single and multiple files.

**Step 1**: Compile single file

```
avr-gcc -Wall -g -Os -mmcu=<device> <file>
```

`<device>`: This is the chip you're programming, example `atmega32u4`

`<file>`: This is the input file, example `main.c`

We'll later get an object file to later convert to hex file for programming our board.

**Step 1**: Compile multiple files

To compile multiple file we can use this flag `-c` to tell the compiler to only compile but not link the binary.

```
avr-gcc -Wall -g -Os -mmcu=<device> -c <file>
```

We can run this command for any files we want and then later use it to link it together. Example if we compile `file_1` and `file_2` we can later link them together like this

```
avr-gcc -Wall -g -Os -mmcu=<device> <file_1> <file_2> -o <output_file>
```

`<output_file>` is the output filename. This is also an object file and we usually name it with extension `.elf`.

**Step 2**: Convert object file to hex

```
avr-objcopy -j .text -j .data -O ihex <object_file> <output_name>.hex
```

`<object_file`: This is the generated object file when you ran `avr-gcc`, example object file `main.o`

`<output_name>`: This can be whatever, but it's best to name it the same as the input file with extension `.hex`, example: `main.hex`

#### Program

Before we can program the device we need to know which `<usb_port>` the device is connected to. To do that we can use 

```
ls /dev/tty.*
```

If the device is not showing you need to put it into programming mode. To do this you need to press reset (on some devices you need to press it twice) and then run the command again.

We can now program the device by using `avrdude`

```
avrdude -v -p <device> -c <prog_id> -P <usb_port> -b 115200 -D -U flash:w:<hex_file>:i
```

`<device>`: This is your device you're programming, example: `atmega32u4`

`<prog_id>`: Tell avrdude which programmer to use, example: `avr109`, `arduino`

`<usb_port>`: This is the port the device is connected to.

`<hex_file>`: This is the output hex file when you ran `avr-objcopy`

### Linux

#### compile

Just as on mac there are 2 steps in compiling the code. The Step 1 has two version, compiling single and multiple files.

**Step 1**: Compile single file

```
avr-gcc -Wall -g -Os -mmcu=<device> <file>
```

`<device>`: This is the chip you're programming, example `atmega32u4`

`<file>`: This is the input file, example `main.c`

We'll later get an object file to later convert to hex file for programming our board.

**Step 1**: Compile multiple files

To compile multiple file we can use this flag `-c` to tell the compiler to only compile but not link the binary.

```
avr-gcc -Wall -g -Os -mmcu=<device> -c <file>
```

We can run this command for any files we want and then later use it to link it together. Example if we compile `file_1` and `file_2` we can later link them together like this

```
avr-gcc -Wall -g -Os -mmcu=<device> <file_1> <file_2> -o <output_file>
```

`<output_file>` is the output filename. This is also an object file and we usually name it with extension `.elf`.

**Step 2**: Convert object file to hex

```
avr-objcopy -j .text -j .data -O ihex <object_file> <output_name>.hex
```

`<object_file`: This is the generated object file when you ran `avr-gcc`, example object file `main.o`

`<output_name>`: This can be whatever, but it's best to name it the same as the input file with extension `.hex`, example: `main.hex`

#### Program

Before we can program the device we need to know which `<usb_port>` the device is connected to. To do that we can use 

```
ls /dev/tty*
```
The name will show upp differently depending on what board you're using, but it will most likely show up as `/dev/ttyACM*` or `/dev/ttyUSB*`

If the device is not showing you will most likely have to add your user too the `uucp` group to get permision to see the tty files
You might also need to put it into programming mode. To do this you need to press reset (on some devices you need to press it twice) and then run the command again.

We can now program the device by using `avrdude`

```
avrdude -v -p <device> -c <prog_id> -P <usb_port> -b 115200 -D -U flash:w:<hex_file>:i
```

`<device>`: This is your device you're programming, example: `atmega32u4`

`<prog_id>`: Tell avrdude which programmer to use, example: `avr109`, `arduino`

`<usb_port>`: This is the port the device is connected to.

`<hex_file>`: This is the output hex file when you ran `avr-objcopy`


### Windows (TODO)

TODO