# AVR using ports in Assembly

## Table of contents

- [AVR using ports in Assembly](#avr-using-ports-in-assembly)
  - [Table of contents](#table-of-contents)
  - [Assembly instructions related to PORTs](#assembly-instructions-related-to-ports)
    - [Introduction](#introduction)
      - [Instructions related to Ports](#instructions-related-to-ports)
      - [Boolean instructions](#boolean-instructions)
    - [Ports](#ports)
      - [Structure of IO pins (Example Mega32/Mega16)](#structure-of-io-pins-example-mega32mega16)
      - [Example 1](#example-1)
      - [Example 2](#example-2)
      - [Example: Input](#example-input)

## Assembly instructions related to PORTs

### Introduction

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

I/O pins are grouped into ports of 8 pins, these can be accessed witha single byte access.

The pins can be input only, ouput only or bidirectional

#### Structure of IO pins (Example Mega32/Mega16)

The ports are in a group of 8, as port A, B, C

A Port has 3 register

```
DDRx    ; Data Direction Register
```

use for setting if it's an input or an output. This is combined with `PORTx`

```
PORTx   ; PORT regsiter
```

| PORTX | DDRX  |     Result     |
| :---: | :---: | :------------: |
|   0   |   0   | high impedance |
|   0   |   1   |     Out 0      |
|   1   |   0   |    Pull-up     |
|   1   |   1   |     Out 1      |

```
PINx
```

PIN is use for reading the value in on IN register

Usage:

```
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

```
LDI  R20, 0xFF   ; R20 = 0b11111111 = 0xFF
OUT  DDRA, R20   ; DDRA = R20
OUT  PORTA, R20  ; PORTA = R20
```

#### Example 2

```
    LDI     R16,0xFF    ; R16 = 0xFF = 0b11111111
    OUT     DDRB,R16    ; make Port B an output port
L1: LDI     R16,0x55    ; R16 = 0x55 = 0b01010101
    OUT     PORTB,R16   ; Put 0x55 on port B pins
    CALL    DELAY       ; Delay subroutine
    LDI     R16,0xAA    ; R16 = 0xAA = 0b10101010
    OUT     PORTB,R16   ; Put 0xAA on port B pins
    CALL    DELAY       ; Delay subroutune
    RJMP    L1
```

#### Example: Input

This code gets the data present at tthe pins of PORT C and sends it to PORT B