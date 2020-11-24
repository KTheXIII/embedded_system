# AVR using ports in Assembly

## Table of Contents

- [AVR using ports in Assembly](#avr-using-ports-in-assembly)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
      - [Instructions related to Ports](#instructions-related-to-ports)
      - [Boolean instructions](#boolean-instructions)
    - [Ports](#ports)
      - [Structure of IO pins (Example Mega32/Mega16)](#structure-of-io-pins-example-mega32mega16)
      - [Example 1](#example-1)
      - [Example 2](#example-2)
      - [Example: Input](#example-input)
      - [Pull-up resistor](#pull-up-resistor)
  - [SBI and CBI Instructions](#sbi-and-cbi-instructions)
    - [SBI (Set Bit in IO register)](#sbi-set-bit-in-io-register)
    - [CBI (Clear Bit in IO register)](#cbi-clear-bit-in-io-register)
  - [SBIC and SBIS Instructions](#sbic-and-sbis-instructions)
    - [SBIC (Skip if Bit in IO register Cleared)](#sbic-skip-if-bit-in-io-register-cleared)
    - [SBIS (Skip if Bit in IO register Set)](#sbis-skip-if-bit-in-io-register-set)

## Introduction

`DDRx`: use for defining direction of the port (input/output)

`PINx`

`PORTx`

#### Instructions related to Ports

`OUT`/`IN`

`SBI`/`CBI`

`SBIC`/`SBIS`

#### Boolean instructions

`AND`/`ANDI`, `OR`/`ORI`

`LSL`, `LSR`, `ASR`, `ROL`, `ROR`

### Ports

I/O pins are grouped into ports of 8 pins, these can be accessed with a single byte access.

The pins can be input only, output only or bidirectional

#### Structure of IO pins (Example Mega32/Mega16)

The ports are in a group of 8, as port A, B, C

A Port has 3 register

```
DDRx    ; Data Direction Register
```

use for setting if it's an input or an output. This is combined with `PORTx`

```
PORTx   ; PORT register
```

| DDRx  | PORTx |      Mode      |
| :---: | :---: | :------------: |
|   0   |   0   | high impedance |
|   0   |   1   |    Pull-up     |
|   1   |   0   |     Out 0      |
|   1   |   1   |     Out 1      |

```
PINx
```

PIN is use for reading the value in on IN register

Usage:

```asm
IN R16, PINC  ; Read in register C and store it in R16 register
```

#### Example 1

Write a program that writes all the pins of PORTA to one.

Data needed for the PORT

```
DDRA:  | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
```

```
PORTA: | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
```

```asm
LDI  R20, 0xFF   ; R20 = 0b11111111 = 0xFF
OUT  DDRA, R20   ; DDRA = R20
OUT  PORTA, R20  ; PORTA = R20
```

#### Example 2

```asm
      LDI     R16,0xFF    ; R16 = 0xFF = 0b11111111
      OUT     DDRB,R16    ; make Port B an output port
L1:   LDI     R16,0x55    ; R16 = 0x55 = 0b01010101
      OUT     PORTB,R16   ; Put 0x55 on port B pins
      CALL    DELAY       ; Delay subroutine
      LDI     R16,0xAA    ; R16 = 0xAA = 0b10101010
      OUT     PORTB,R16   ; Put 0xAA on port B pins
      CALL    DELAY       ; Delay subroutune
      RJMP    L1
```

#### Example: Input

This code gets the data present at the pins of PORT C and sends it to PORT B.

```asm
      LDI R16, 0x00
      OUT DDRC, R16     ; Set PORT C as an input
      LDI R16, 0xFF
      OUT DDRB, R16     ; Set PORT B as an output

L2:   IN  R16, PINC     ; Read data from IN register on PORT C
      LDI R17, 5
      ADD R16, R17      ; Add value 5 to R16
      OUT PORTB, R16    ; Write it to PORT B
      RJMP L2           ; Jump back to L2 for looping
```

#### Pull-up resistor

You can configure a pin into pull-up state by setting the DDR to 0 and PORT to 1.

```asm
LDI R16, 0x00
OUT DDRC, R16
LDI R16, 0xFF
OUT PORTC, R16
```

You can also read from it as usual.

```asm
IN R16, PINC
```

## SBI and CBI Instructions

### SBI (Set Bit in IO register)

This is used for setting a bit in the register. Useful for setting just one bit and not have to set all of it like `OUT`.

Usage:

```asm
SBI IO_REG, bit     ; IO_REG.bit = 1
```

Example:

```asm
SBI PORTD, 0        ; PORTD.0 = 1, set PORTD register data position 0 to 1
SBI DDRC, 5         ; DDRC.5 = 1
```

### CBI (Clear Bit in IO register)

This is used for clearing a bit in the IO register, it is useful like SBI.

Usage:

```asm
CBI IO_REG, bit     ; IO_REG.bit = 0
```

Example:

```asm
CBI PORTD, 0        ; PORTD.0 = 0
CBI DDRC, 5         ; DDRC.5 = 0
```

## SBIC and SBIS Instructions

### SBIC (Skip if Bit in IO register Cleared)

Usage:

```asm
SBIC IO_REG, bit    ; if (IO_REG.bit == 0) skip next instruction
```

Example:

```asm
SBIC PIND, 0        ; Skip next instruction if PIND.0 == 0
INC  R20
LDI  R19, 0x23
```

### SBIS (Skip if Bit in IO register Set)

Usage:

```asm
SBIS IO_REG, bit    ; if (IO_REG.bit == 1) skip next instruction
```

Example:

```asm
SBIS PIND, 0        ; skip next instruction if PIND.0 == 1
INC  R20
LDI  R19, 0x23
```
