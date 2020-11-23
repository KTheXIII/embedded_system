# AVR Logic Instructions

Logical instructions and example usage.

## Table of contents

- [AVR Logic Instructions](#avr-logic-instructions)
  - [Table of contents](#table-of-contents)
  - [AND](#and)
  - [ANDI (AND Immediate)](#andi-and-immediate)
  - [OR](#or)
  - [ORI (OR Immediate)](#ori-or-immediate)
  - [EOR (Exclusive OR)](#eor-exclusive-or)
  - [COM (Ones' Complement)](#com-ones-complement)
  - [NEG (Two's Complement)](#neg-twos-complement)
  - [SWAP (Swap Nibbles)](#swap-swap-nibbles)
  - [LSL (Logical Shift Left)](#lsl-logical-shift-left)
  - [LSR (Logcial Shift Right)](#lsr-logcial-shift-right)
  - [ASR (Arithmetic Shift Right)](#asr-arithmetic-shift-right)
  - [ROL (Rotate Left through Carry)](#rol-rotate-left-through-carry)
  - [ROR (Rotate Right through Carry)](#ror-rotate-right-through-carry)

## AND

Require 2 registers.

Cycles: 1

Usage:

```asm
AND Rd, Rr
```

`Rd` is the destination and `Rr` is the right value.

## ANDI (AND Immediate)

Require one register.

Cycles: 1

Usage:

```asm
ANDI Rd, k
```

`Rd` is the destination and `k` is the value in hex, binary or decimal.

## OR

Require 2 registers.

Cycles: 1

Usage:

```asm
OR Rd, Rr
```

`Rd` is the destination and `Rr` is the right value.

## ORI (OR Immediate)

Require one register.

Cycles: 1

Usage:

```asm
ORI Rd, k
```

`Rd` is the destination and `k` is the value in hex, binary or decimal.

## EOR (Exclusive OR)

Require 2 registers.

Cycles: 1

Usage:

```asm
EOR Rd, k
```

`Rd` is the destination and `k` is the value in hex, binary or decimal.

## COM (Ones' Complement)

The one's complement of a binary number is defined as the value obtained by inverting all the bits. ([Source: Wikipedia](https://en.wikipedia.org/wiki/Ones%27_complement))

This instruction invert the bits in the register.

Require one register.

Cycles: 1

Usage:

```asm
COM Rd
```

`Rd` is the destination and also the source.

## NEG (Two's Complement)

Two's complement is the most common method of representing signed integers. ([Source: Wikipedia](https://en.wikipedia.org/wiki/Two%27s_complement))

This instruction acts like doing `COM` first and then add 1 bit to the value.

Require one register.

Cycles: 1

Usage:

```asm
NEG Rd
```

`Rd` is the destination and also the source.

## SWAP (Swap Nibbles)

A nibble is a four-bit aggregation, or half an octet. Also known as half-byte. ([Source: Wikipedia](https://en.wikipedia.org/wiki/Nibble))

This instruction switches the place of the nibble. Like this `0xF0 -> 0x0F`.

Require one register.

Cycles: 1

Usage:

```asm
SWAP Rd
```

`Rd` is the destination and also the source.

## LSL (Logical Shift Left)

This instruction shifts the bits to the left. Example: `0b00000001 -> 0b00000010`.

Require one register.

Cycles: 1

Usage:

```asm
LSL Rd
```

`Rd` is the destination and also the source.

## LSR (Logcial Shift Right)

This instruction shifts the bits to the right. Example: `0b00000010 -> 0b00000001`.

Require one register.

Cycles: 1

Usage:

```asm
LSR Rd
```

`Rd` is the destination and also the source.

## ASR (Arithmetic Shift Right)

Shifts all bits in `Rd` one place to the right. Bit 7 is held constant. Bit 0 is loaded into the C (Carry) Flag of the `SREG`. This operation effectively divides a singed value by two without chaning its sign. The Carry Flag can be use to round the result. (Source: AVR Instruction Set Manual)

Require one register.

Cycles: 1

Usage:

```
ASR Rd
```

`Rd` is the destination and also the source.

## ROL (Rotate Left through Carry)

Shifts all bits in `Rd` one place to the left. The C Flag is shifted into bit 0 of `Rd`. Bit 7 is shifted into the C Flag. This operation, combined with `LSL`, effectively multiplies multi-byte signed and unsiged values by two.

Require one register.

Cycles: 1

Usage:

```
ROL Rd
```

`Rd` is the destination and also the source.

## ROR (Rotate Right through Carry)

Shifts all bits in `Rd` one place to the right. The C Flag is shifted into bit 7 of Rd. Bit 0 is shifted into the C Flag. Combined with `ASR`, effectively divides multi-byte signed values by two. Combined with `LSR` it effectively divides multi-byte unsigned vales by two. The Carry Flag can be used to round the result. (Source: AVR Instruction Set Manual)

Require one register.

Cycles: 1

Usage:

```
ROR Rd
```

`Rd` is the destination and also the source.
