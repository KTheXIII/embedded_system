# AVR Assembly notes for Embedded System

Here contains the guide on how to assemble your assembly code for AVR.

## Table of Contents

- [AVR Assembly notes for Embedded System](#avr-assembly-notes-for-embedded-system)
  - [Table of Contents](#table-of-contents)
  - [Assembler and Programmer](#assembler-and-programmer)
  - [Resources](#resources)
    - [Articles](#articles)
  - [Development Environment](#development-environment)
    - [macOS](#macos)
      - [Install avra using homebrew](#install-avra-using-homebrew)
      - [Install avrdude using homebrew](#install-avrdude-using-homebrew)
      - [avrdude in Arduino](#avrdude-in-arduino)
    - [Linux](#linux)
    - [Windows](#windows)
      - [avrdude in Arduino](#avrdude-in-arduino-1)
  - [Assemble and Program](#assemble-and-program)
    - [macOS](#macos-1)
      - [Assemble](#assemble)
      - [Program](#program)
    - [Linux](#linux-1)
      - [Assemble](#assemble-1)
      - [Program](#program-1)
    - [Windows](#windows-1)
      - [Assemble](#assemble-2)
      - [Program](#program-2)

## Assembler and Programmer

[avra](https://github.com/Ro5bert/avra) can be used as assembler. But you'll need to include definitions for different chips. Check [AVR repo](https://github.com/DarkSector/AVR) for definitions. If you have Atmel Studio already you can just use the generated definitions.

[avrdude](https://www.nongnu.org/avrdude/) can be used for programming the chip. You can also use avrdude that's included in [Arduino](https://www.arduino.cc).

## Resources

- [Instruction set](http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf) pdf

### Articles
 - [Beginners Programming in AVR Assembler](http://www.avr-asm-tutorial.net/avr_en/beginner/index.html)
 - [Atmel AVR instruction set](https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set)

## Development Environment

This section is about setting up a development environment, this cover what program needs to be installed.

### macOS

On macOS you can use [brew](https://brew.sh) to install `avra` and `avrdude`. For `avrdude` you can also download [Arduino](https://www.arduino.cc) and use the one that's included.

I would recommend to install avra from source since it'll contain the latest version.

#### Install avra using homebrew

```
brew install avra
```

#### Install avrdude using homebrew

```
brew install avrdude
```

#### avrdude in Arduino

If you're using avrdude that's included in Arduino, the path is usually at

```
/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin/avrdude
```

You'll also need to include the `avrdude.conf` file, the path is usually at 

```
Arduino.app/Contents/Java/hardware/tools/avr/etc/avrdude.conf
```

This is only true if you've installed Arduino in the `/Applications` directory.

### Linux

For linux you can use your package manager and install `avra` and `avrdude`.

For avra you can also install from source, follow the [Build guide](https://github.com/Ro5bert/avra#build).

### Windows

For Windows I would just recommend you to install [Atmel Studio 7](https://www.microchip.com/mplab/microchip-studio) and download [Arduino](https://www.arduino.cc).

#### avrdude in Arduino

`avrdude` is in this path in Arduino folder

```
Arduino\hardware\tools\avr\bin\avrdude.exe
```

`Arduino` directory is usually in the `Program` directory.

`avrdude.conf` is in this path in Arduino folder

```
Arduino\hardware\tools\avr\etc\avrdude.conf
```

## Assemble and Program

This section cover how to assemble and program the assembly code.

### macOS

#### Assemble

To assemble your code you need to include the definition for the device you're using like this

```asm
.INCLUDE "<device_definition>"
```

`<device_definition>` is the filename for the device. Check the [avra](https://github.com/Ro5bert/avra) repo in `includes` directory to find out what the filename is.

Use this command for avra to find out which devices are supported.

```
avra --devices
```

**Example**: Using chip ATmega32U4.

The latest version of [avra](https://github.com/Ro5bert/avra) should have ATmega32U4 as supported device.

In your own code you need to include the `m32U4def.inc` file like this at the top

```asm
.INCLUDE "m32U4def.inc"
```

This make sure you have access to the definitions such as PORTx, DDRx and PINx.

To assemble this command is used

```
avra <filename>
```

`<filename>` is the name of your code file, example: `main.asm`

**Note**: If you're using code from Atmel Studio that's using these `/**/`, `//` as comments style, the avra assembler won't work.

#### Program

To program the chip you can use `avrdude`. Assuming you've already assembled and generated the `.hex` file.

Find out what port your device is connected to. You can use the following command

```
ls /dev/tty.* 
```

If your device is not showing up then you'll need to pull reset to ground twice. And run the command again and you'll see a device with this naming `/dev/tty.usbmodem*`, copy this name.

**Using installed avrdude**

You can use this command for avrdude to program the chip.

```
avrdude -v -p atmega32u4 -c avr109 -P <device/port> -b 57600 -D -U flash:w:<path/to/hex>:i
```

You'll need to replace `<device/port>` with your device and `<path/to/hex>` for your generated hex file

**Using avrdude included in arduino**

The procedure is the same as the installed one but you'll need to include the `avrdude.conf` file.

Example:

```
<path/to/avrdude> -C <path/to/avrdude.conf>  -v -p atmega32u4 -c avr109 -P <device/port> -b 115200 -D -U flash:w:<path/to/hex>:i
```

`<path/to/avrdude>` is the included binary in the arduino. 

`<path/to/avrdude.conf>` is the config that comes with arduino. 

`<device/port>` is your device. 

`<path/to/hex>` is your generated hex file

### Linux

On Linux the procedure is almost the same as macOS.

#### Assemble

#### Program

To check which port the device is connected to you can use the following command

```
ls /dev/tty*
```

The name will show upp differently depending on what board you're using, but for an Arduino Micro it'll show up with something like this `/dev/ttyACM*`.

### Windows

#### Assemble

On windows you should just use Atmel Studio 7 as the assembler.

#### Program

To program the chip go to `Tools -> External Tools...` in Atmel Studio. This opens up a configuration window for **External Tools**. You need to add a new configuration and name it in the title field. This can be anything, but it's best to name it to the chip/board you're trying to program.

Example: We're programming an Arduino Leonardo, the title will be Arduino Leonardo.

We then need to configure `Command`. This is the path to the `avrdude` executable.

For the `Arguments` field you'll need to include this

```
-C <path/to/avrdude.conf>  -v -p atmega32u4 -c avr109 -P <device/port> -b 57600 -D -U flash:w:"$(ProjectDir)Debug\$(TargetName).hex":i
```

`<path/to/avrdude.conf>` is the config that comes with arduino. 

`<device/port>` is your device. To check on Windows 10, open your `Device Manager` (press windows key and type device manager and it'll show up). The device is listed in the **Ports (COM & LPT)**, expand it to see more. Press reset twice to make it show up. Replace `<device/port>` with the value that's showing up. 

**Note**: Pressing reset makes the board go into programming mode.
