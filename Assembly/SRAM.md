# SRAM

SRAM are used for storing and loading data. On AVR the SRAM address are in 16-bit while the registers are in 8-bit. This means that to address a value in memory we need to use 2 registers. We call them [Pointer-Registers](/Assembly/Registers.md#x-y-z-register-pairs-pointer-register).

There are 3 predefined pairs of registers we can use, they are X, Y, Z pointer registers. And they use register pairs R26:27, R28:29 and R30:R31.

## Allocating Space

We use `.BYTE` directive to indicate that we want to allocate memory.

```asm
.BYTE <size>
```

`<size>` is the memory size in byte.

To allocate a memory we need to use `.DSEG` directive to specify a *data segment* and `.ORG` directive is for specifying the location. 

Example: Allocating 4 byte and 3 byte of memory

```asm
        .DSEG
        .ORG SRAM_START
data1: .BYTE 4
data2: .BYTE 3
```

`data1` and `data2` are used as label for getting the location address. 

`SRAM_START` is where the memory starts, the memory address is in 16-bit. Example: `0x1000`.

## Loading and Storing (Indirect)

To load and store we need to use pointer registers

### Loading

Instruction `LD` is used for loading data from memory.

```asm
LDI XL, LOW(address)
LDI XH, HIGH(address)
LD  R16, X
```

`address` is memory address, we usually use a label for it, check example in [Allocating Space](#allocating-space). The `LD` instruction is later used to load the value from `X` pointer register into `R16`.

### Storing

The `ST` instruction is used for storing data using pointer register.

```asm
LDI XL, LOW(address)
LDI XH, HIGH(address)
ST X, R16
```