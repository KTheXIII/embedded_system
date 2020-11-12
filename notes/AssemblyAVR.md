# Assembly instructions for AVR

Notes for AVR assembly instructions.

## Table of contents

- [Assembly instructions for AVR](#assembly-instructions-for-avr)
  - [Table of contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Instruction using one register](#instruction-using-one-register)
    - [Instruction using 2 register](#instruction-using-2-register)
    - [Covered Instructions](#covered-instructions)
  - [Loading values](#loading-values)
  - [Arithmetic operations](#arithmetic-operations)
    - [ADD](#add)
      - [Example program: Add 2 values](#example-program-add-2-values)
      - [Example program: Add 3 values](#example-program-add-3-values)
    - [ADD / SUB Immediate](#add--sub-immediate)
    - [INC (Increment)](#inc-increment)
    - [DEC (Decrement)](#dec-decrement)
  - [Jump and Call Instructions](#jump-and-call-instructions)
    - [Summary](#summary)
    - [Jump](#jump)
      - [Types of Jump](#types-of-jump)
      - [Unconditional Jump in AVR](#unconditional-jump-in-avr)
      - [`JMP`](#jmp)
      - [`RJMP` (Relative Jump)](#rjmp-relative-jump)
    - [Call](#call)
  - [Registers bit](#registers-bit)
  - [Note: R0 to R15](#note-r0-to-r15)

## Introduction

### Instruction using one register

- LDI (Load Immediate)
- INC (Increment)
- DEC (Decrement)

### Instruction using 2 register

- ADD
- SUB

### Covered Instructions

- LDI
- ADD/SUB/SUBI
- INC/DEC
- JMP/RJMP
- PUSH/POP
- CALL/RCALL/RET
- MOV

## Loading values

**`LDI` (Load Immediate)**

LDI is used for loading value into `Rd`, where `R` is the keyword for register and `d` is the destination (register number).

Usage:

```
LDI Rd, k ; Rd is the destination register
          ; k is the value
```

Example:

```
LDI R16, 53   ; load value 53 into Register 16
LDI R19, 132  ; load value 1332 into Register 19
LDI R23, 0x27 ; load value 0x27 into Register 23
```

## Arithmetic operations

`ADD`, `SUB`, `AND`, `OR`, etc

### ADD

ADD is used for adding 2 values

Usage:

```
ADD Rd, Rs    ; Rd, destination register
              ; Rs is the source register
```

This will add the value in `Rs` into `Rd`. The `Rd` will contain the result of these 2 addition.

Example:

```
ADD R25, R9   ; Add value in register 25 and register 9
              ; The result is in R25
```

#### Example program: Add 2 values

```
LDI R16, 19    ; R16 = 19 (decimal value)
LDI R20, 95    ; R20 = 95
LDI R16, R20   ; Add R16 and R20, R16 = R16 + R20
```

#### Example program: Add 3 values

Exmaple using 3 registers:

```
LDI R16, 19    ; R16 = 19
LDI R20, 95    ; R20 = 95
LDI R21, 5     ; R21 = 5
ADD R16, R20   ; R16 = R16 + R20
ADD R16, R21   ; R16 = R16 + R21
```

Example using 2 registers:

```
LDI R16, 19
LDI R20, 95
ADD R16, R20
LDI R20, 5
ADD R16, R20
```

### ADD / SUB Immediate

For AVR there is no `ADDI` (ADD Immediate) instruction, `SUBI` (SUB Immediate) exists.

Example:

```
LDI R16, 10   ; Load value 10 into R16
SUBI R16, -5  ; SUB R16 with -5, R16 = 15
SUBI R16, -5  ; SUB R16 with -5, R16 = 20
```

### INC (Increment)

INC instruction will increment the value by one. This is the same as doing `i++` in C++;

```
INC Rd  ; Increment Rd value by 1 
```

### DEC (Decrement)

DEC instruction will decrement value by one, equivalent `i--`.

```
DEC Rd  ; Decrement Rd value by 1
```

## Jump and Call Instructions

### Summary

Jump

- A one way transition

Call

- A two way transition
- Require a stack
- Use for calling subroutine
- Ability to return from subroutine

### Jump

A **Jump** instruction changes the **Program Counter** and cause the **CPU** to execute the instruction at the requested program address. This is a jump without any condition so it is mostly used to create an infinite loop.

`PC`: Program Counter. The CPU is always incrementing the PC.

Usage:

This load `k`(contain instruction address) into `PC`. 

```
LDI PC, k ; k is the destination of the instruction
```

#### Types of Jump

Unconditional Jump

- This type of instruction will jump without checking for condition
- Example: `RJMP` and `JMP` instructions

Conditional Jump

- This type of instruction will only jump if the condition is true
- Example: `BRxx` (Branch) and `Sxxx` (Skip...) instructions

#### Unconditional Jump in AVR

There are 3 unconditional jump instructions in AVR: `RJMP`, `JMP` and `IJMP`

We can label the location where we want to jump using a unique name followed by `:`


#### `JMP`

TODO

#### `RJMP` (Relative Jump)

TODO

### Call

The call instruction needs a stack to work since it is calling a subroutine and need a way to go back when the subroutine is done.

The stack datastructure is a LIFO (**L**ast **I**n, **F**irst **O**ut), this mean that the first data being pushed onto the stack will need to pop all the data on top of it before it can be read.

![Illusttration of Last In, First Out](https://upload.wikimedia.org/wikipedia/commons/b/b4/Lifo_stack.png)

The instructions for stack are PUSH and POP.

The call function are (`CALL`, `RCALL`)

Return `RET`

This is equivalent to calling a function in a higher level language.

Example C++:

```cpp
void hello() {
  // Code here
}

int main(int argc, char const *argv[]) {
  hello();
  return 0;
}
```

When we call `hello` function the current program counter is pushed onto the stack until `hello` is done and the stack will be poped and return to the `main`. We can also call `hello` inside `hello`

Example C++ recursion:

```cpp
void hello() {
  hello();
}
```

This will run until we run out of allocated memory fo the stack.


**PUSH**

```
PUSH Rr
```

`SP`: Stack Pointer

```
[SP] = Rr
SP = SP - 1
```

**POP**

```
POP Rd
```

```
SP = SP + 1
Rd = [SP]
```

## Registers bit

Working registers (R0 - R31, 8 bit)

Program Counter PC (16 bit)

- Increased by 1 during instruction execution
- Can be set using JMP

Statck Pointer SP (16 bit)
- Stack is used by CALL/RCALL to save PC
- Stack can be used using (PUSH, POP)
  - The stack pointer counts downwards when something is added to stack

## Note: R0 to R15 

Only register R16 to R31 (inclusive) can be loaded immediate. To load value into R0 you'll need to load value into some R16 to R31 first and the us `MOV` to move it into R0 or in the range R0 to R15 (inclusive).

Example: Load Immediate value 10 to R16 and then Move it to R0

```
LDI R16, 10
MOV R0, R16
```

