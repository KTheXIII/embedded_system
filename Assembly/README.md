# Assembly notes for Embedded System

Here contains the guide on how to assemble your assembly code.

## Table of content

- [Assembly notes for Embedded System](#assembly-notes-for-embedded-system)
  - [Table of content](#table-of-content)
  - [Assembler and Programmer](#assembler-and-programmer)
  - [Resources](#resources)
    - [Articles](#articles)
  - [Development Environment](#development-environment)
    - [macOS](#macos)
    - [Windows](#windows)
  - [Assemble and Program](#assemble-and-program)
    - [macOS](#macos-1)
      - [Assemble](#assemble)
      - [Program](#program)
    - [Windows](#windows-1)
      - [Assemble](#assemble-1)
      - [Program](#program-1)

## Assembler and Programmer

[avra](https://github.com/Ro5bert/avra) can be use as assembler. But you'll need to include defintions for different chips. Check [AVR repo](https://github.com/DarkSector/AVR) for defintions. If you have Atmel Studio already you can just use the generated defintions.

[avrdude](https://savannah.nongnu.org/projects/avrdude/) can be use for programming the chip. You can also use avrdude that's included in arduino.

## Resources

- [Instruction set](http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf) pdf

### Articles
 - [Beginners Programming in AVR Assembler](http://www.avr-asm-tutorial.net/avr_en/beginner/index.html)

## Development Environment

### macOS

On macOS you can use [brew](https://brew.sh) to install `avra` and `avrdude`. For `avrdude` you can also download [arduino](https://www.arduino.cc) and use the one that's included.

```
brew install avra
```

```
brew install avrdude
```

`avrdude` in arduino. The path is usually at

```
/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin/avrdude
```

This is only true if you've installed arduino in the `/Applications` directory.

### Windows

For Windows I would just recommend you to install [Atmel Studio 7](https://www.microchip.com/mplab/microchip-studio) and download [Arduino](https://www.arduino.cc).

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

### macOS

#### Assemble

To assemble the code you'll need the definitions for the chips you're using. The [AVR repo](https://github.com/DarkSector/AVR) have the definitions generated with Atmel Studio 7 in the `/asm/include` directory. You'll need to copy the correct definition for your chips.

Example: If we're using Atmega32u4, we'll need to get this `m32U4def.inc` file. The avra assembler doesn't have Atmega32U4 listed in their device list. You can circumvent by changing the `.device` value to `Atmega32`

```
.device Atmega32
```

If you want to know which device are supported just do

```
avra --devices
```

In your own code you need to include the `m32U4def.inc` file like this at the top

```
.INCLUDE "m32U4def.inc"
```

This make sure you have access to the definitions such as PORTx, DDRx and such.

#### Program

To program the chip you can use `avrdude`. Assuming you've already assembled and generated the `.hex` file.

**Step 1** is to find out what port your device is connected to. You can use the following command

```
ls /dev/tty.* 
```

If your device is not showing up then you'll need to pull reset to ground twice. And run the command again you'll see a device with this naming `/dev/tty.usbmodem*`, copy this name.

**Using installed avrdude**

You can use this command for avrdude to program the the chip.

```
avrdude -v -p atmega32u4 -c avr109 -P <device/port> -b 57600 -D -U flash:w:<path/to/hex>:i
```

You'll need to replace `<device/port>` with your device and `<path/to/hex>` for your generated hex file

**Using avrdude included in arduino**

The procedure is the same as the installed one but you'll need to include the `avrdude.conf` file included.

Example:

```
<path/to/avrdude> -C <path/to/avrdude.conf>  -v -p atmega32u4 -c avr109 -P <device/port> -b 57600 -D -U flash:w:<path/to/hex>:i
```

`<path/to/avrdude>` is the included binary in the arduino. 

`<path/to/avrdude.conf>` is the config that comes with arduino. 

`<device/port>` is your device. 

`<path/to/hex>` is your generated hex file

### Windows

#### Assemble

On windows you should just use Atmel Studio 7 as the assembler.

#### Program

To program the chip go to `Tools -> External Tools...` in Atmel Studio. This opens up a configuration window for **External Tools**. You need to add a new configuration and name it in the tile field. This can be anything, but it's best to name it to the chip/board you're trying to program.

Example: We're programming an Arduino Leonardo, the title will be Arduino Leonardo.

We then need to configure `Command`. This is the path to the `avrdude` executable.

For the `Arguments` field you'll need to include this

```
-C <path/to/avrdude.conf>  -v -p atmega32u4 -c avr109 -P <device/port> -b 57600 -D -U flash:w:"$(ProjectDir)Debug\$(ItemFileName).hex":i
```

`<path/to/avrdude.conf>` is the config that comes with arduino. 

`<device/port>` is your device. To check on Windows 10, open your `Device Manager` (press windows key and type device manager and it'll show up). The device is listed in the **Ports (COM & LPT)**, expand it to see more. Press reset twice to make it show up. Replace `<device/port>` with the value that's showing up. 

Note: Pressing reset makes the board go into programming mode.
