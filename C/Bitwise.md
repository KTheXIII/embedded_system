# Bitwise Operations

Introduction to bitwise operations and how the binary numbers works.

## Table of Contents

- [Bitwise Operations](#bitwise-operations)
  - [Table of Contents](#table-of-contents)
  - [Representing Numbers](#representing-numbers)
    - [Binary](#binary)
    - [Hexadecimal](#hexadecimal)
  - [Notations](#notations)
  - [Bitwise Operations](#bitwise-operations-1)
    - [AND](#and)
    - [OR](#or)
    - [Exclusive OR](#exclusive-or)
    - [Shift Left](#shift-left)
    - [Shift Right](#shift-right)
    - [NOT (One's Complement)](#not-ones-complement)
    - [Table of Operations](#table-of-operations)

## Representing Numbers

### Binary

Binary number concept

Decimal : Binary

`65 = 01000001`

We split this up like this

```
           Decimal   : Binary
Position:  4 3 2 1 0 : 7 6 5 4 3 2 1 0
Number:          6 5 = 0 1 0 0 0 0 0 1
```

For decimal we now that we can count up 9 til we need to add another number to represent higher number.

The conversion is like this in decimal

```
6×10^1 + 5×10^0 = 65
```

10 is the how many we can count, it the different state from 0 to 9. Notice `1` and `0` are the positions of the number.

We can also convert binary to decimal by doing the same trick. Except in binary there are only 2 state, 0 and 1. What we end up with is

```
0×2^7 + 1×2^6 + 0×2^5 + 0×2^4 + 0×2^3 + 0×2^2 + 0×2^1 + 1×2^0 = 65
```

### Hexadecimal

Hexadecimal is another way of representing numbers. Hexadecimal notation is mostly used by programmers to show numbers. This is because it is shorter to read than reading binary.

If we're representing a 16-bit number in binary the number will be 16 character long. Example if we trying to represent this number 256 in 16-bit binary we'll get this and it might not obvious what number it is.

```
0000000100000000
```

In hexadecimal we can represent a number from 0 to 15 by using the number 0 to 9 and letter A to B.

```
0 1 2 3 4 5 6 7 8 9 A B C D E F
```

Our example number 256 will be this instead

```
00FF
```

We also usually put `0x` or `$` before the number to indicate that it is a hex number we're trying to represent. In C/C++ we notate it with `0x`.

```
0x00FF
```

We can do our conversion like we did with decimal and binary like this

```
Position: 3 2 1 0
          0 0 F F = 255
––––––––––––––––––––––––––––––––––––––––––––––––––––––––
0×16^3 + 0×16^2 + 15×16^1 + 15×16^0 = 15×16 + 15×1 = 255
```

## Notations

```
Decimal:      65
Binary:       0b01000001
Hexadecimal:  0x41, $41, #41
```

In C/C++ we'll se the `0b` and `0x` prefix.

## Bitwise Operations

Bitwise operations is used a lot when we're at register level.

### AND

Bitwise AND are mostly used for masking out bits in our data. Example if we have an 8-bit number and we want to masked out the upper 4 bits and only get the lower 4 bit value we can use AND operator `&`.

```
DATA    :      10101010
MASK    :    & 00001111
             ––––––––––
RESULT  :      00001010
```

### OR

Bitwise OR are use for setting just one bit in our data

```
DATA    :     10000000
SET BIT :   | 00000010
            ––––––––––
RESULT  :     10000010
```

### Exclusive OR

Bitwise XOR are mostly used when we want to toggle a bit in our data. It is used in conjunction with `AND`. The symbol for XOR in C/C++ is `^`.

Syntax:

```
a ^ b
```

Example:

```
DATA    :     10000010
SET BIT :   ^ 00000010
            ––––––––––
RESULT  :     10000000
```

### Shift Left

Logical Shift Left have the property of multiplying the number by 2 when we shift the number by 1 to the left. We use this `<<` symbol to specify that we want to shift the data.

Syntax:

```
a << b
```

`a` is our data and `b` is how many position we want to shift.

Example:

```
00000001 << 1 = 00000010
```

### Shift Right

Logical Shift Right have the property of dividing by 2 when shifting.

Syntax:

```
a >> b
```

`a` is our data and `b` is how many position we want to shift.

Example:

```
00000010 >> 1 = 00000001
```

### NOT (One's Complement)

Bitwise NOT can invert our data like this

```
DATA    :    ~10101010
            ––––––––––
RESULT  :     01010101
```



### Table of Operations

| Symbol | Description        | Syntax   |
| :----- | :----------------- | :------- |
| `&`    | Logical AND        | `a & b`  |
| `\|`   | Logical OR         | `a \| b` |
| `^`    | Exclusive OR (XOR) | `a ^ b`  |
| `<<`   | Shift Left         | `a << b` |
| `>>`   | Shift Right        | `a >> b` |
| `~`    | One's Complement   | `~a`     |