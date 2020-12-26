# Instruction Set Summary Table

Here contains table summary for AVR instructions. It's not all of them and clock cycles column only contain for AVR Instruction Set from 1995. For more info check the AVR Instruction Set Manual.

## Instruction Set Nomenclature

**Status Register (SREG) FLAGS**:

`C`: Carry Flag

`Z`: Zero Flag

`N`: Negative Flag

`V`: Two's complement overflow indicator

`S`: N ⊕ V, for signed tests

`H`: Half Carry Flag

`T`: Transfer bit used by `BLD` and `BST` instructions

`I`: Global Interrupt Enable/Disable Flag

Layout:

```
      [ I | T | H | S | V | N | Z | C ]
bit:    7   6   5   4   3   2   1   0
```

**Registers and Operands**

`Rd`: Destination (and source) register in Register File

`Rr`: Source register in the Register File

`R`: Result after instruction is executed

`K`: Constant data

`k`: Constant address

`b`: Bit in the Register File or I/O Register (3-bit)

`s`: Bit in the Status Register (3-bit)

`X,Y,Z`: Indirect Address Register (`X=R27:R26`, `Y=R29:R28`, and `Z=R31:R30`)

`A`: I/O location address

`q`: Displacement for direct addressing (6-bit)

## Table of Contents

- [Instruction Set Summary Table](#instruction-set-summary-table)
  - [Instruction Set Nomenclature](#instruction-set-nomenclature)
  - [Table of Contents](#table-of-contents)
  - [Arithmetic and Logic Instructions](#arithmetic-and-logic-instructions)
  - [Branch Instructions](#branch-instructions)
  - [Data Transfer Instructions](#data-transfer-instructions)
  - [MCU Control Instructions](#mcu-control-instructions)

## Arithmetic and Logic Instructions

| Mnemonic | Operands | Description                              |         |  Op   |                   | Flags       | #Clocks |
| :------- | :------- | :--------------------------------------- | ------: | :---: | :---------------- | :---------- | :-----: |
| ADD      | Rd, Rr   | Add without Carry                        |      Rd |   ←   | Rd + Rr           | Z,C,N,V,S,H |    1    |
| ADC      | Rd, Rr   | Add with Carry                           |      Rd |   ←   | Rd + Rr + C       | Z,C,N,V,S,H |    1    |
| ADIW     | Rd, K    | Add Immediate to Word                    |      Rd |   ←   | R + 1:Rd + K      | Z,C,N,V,S   |    2    |
| SUB      | Rd, Rr   | Subtract without Carry                   |      Rd |   ←   | Rd + Rr           | Z,C,N,V,S,H |    1    |
| SUBI     | Rd, K    | Subtract Immediate                       |      Rd |   ←   | Rd + K            | Z,C,N,V,S,H |    1    |
| SBC      | Rd, Rr   | Subtract with Carry                      |      Rd |   ←   | Rd - Rc - C       | Z,C,N,V,S,H |    1    |
| SBCI     | Rd, K    | Subtract Immediate with Carry            |      Rd |   ←   | Rd - K - C        | Z,C,N,V,S,H |    1    |
| SBIW     | Rd, K    | Subtract Immediate from Word             | Rd+1:Rd |   ←   | Rd + 1:Rd -K      | Z,C,N,V,S   |    2    |
| AND      | Rd, Rr   | Logical AND                              |      Rd |   ←   | Rd + Rr           | Z,N,V,S     |    1    |
| ANDI     | Rd, K    | Logical AND with Immediate               |      Rd |   ←   | Rd · K            | Z,N,V,S     |    1    |
| OR       | Rd, Rr   | Logical OR                               |      Rd |   ←   | Rd ∨ Rr           | Z,N,V,S     |    1    |
| ORI      | Rd, K    | Logical OR with Immediate                |      Rd |   ←   | Rd ∨ K            | Z,N,V,S     |    1    |
| EOR      | Rd, Rr   | Exclusive OR                             |      Rd |   ←   | Rd ⊕ Rr           | Z,N,V,S     |    1    |
| COM      | Rd       | One's Complement                         |      Rd |   ←   | $FF - Rd          | Z,N,V,S     |    1    |
| NEG      | Rd, K    | Two's Complement                         |      Rd |   ←   | $00 - Rd          | Z,N,V,S     |    1    |
| SBR      | Rd, K    | Set Bit(s) in Register                   |      Rd |   ←   | Rd ∨ K            | Z,N,V,S     |    1    |
| CBR      | Rd, K    | Clear Bit(s) in Register                 |      Rd |   ←   | Rd ·($FFh - K)    | Z,N,V,S     |    1    |
| INC      | Rd       | Increment                                |      Rd |   ←   | Rd + 1            | Z,N,V,S     |    1    |
| DEC      | Rd       | Decrement                                |      Rd |   ←   | Rd - 1            | Z,N,V,S     |    1    |
| TST      | Rd       | Test for Zero or Minus                   |      Rd |   ←   | Rd · Rd           | Z,N,V,S     |    1    |
| CLR      | Rd       | Clear Register                           |      Rd |   ←   | Rd ⊕ Rd           | Z,N,V,S     |    1    |
| SER      | Rd       | Set Register                             |      Rd |   ←   | $FF               | None        |    1    |
| MUL      | Rd, Rr   | Multiply Unsigned                        |   R1:R0 |   ←   | Rd × Rr (UU)      | Z,C         |    2    |
| MULS     | Rd, Rr   | Multiply Signed                          |   R1:R0 |   ←   | Rd × Rr (SS)      | Z,C         |    2    |
| MULSU    | Rd, Rr   | Multiply Signed with Unsigned            |   R1:R0 |   ←   | Rd × Rr (SU)      | Z,C         |    2    |
| FMUL     | Rd, Rr   | Fractional Multiply Unsigned             |   R1:R0 |   ←   | Rd × Rr << 1 (UU) | Z,C         |    2    |
| FMULS    | Rd, Rr   | Fractional Multiply Signed               |   R1:R1 |   ←   | Rd × Rr << 1 (SS) | Z,C         |    2    |
| FMULSU   | Rd, Rr   | Fractional Multiply Signed with Unsigned |   R1:R2 |   ←   | Rd × Rr << 1 (SU) | Z,C         |    2    |

## Branch Instructions

| Mnemonic | Operands | Description                         |                       |  Op   |             | Flags       | #Clocks |
| :------- | :------- | :---------------------------------- | --------------------: | :---: | :---------- | ----------- | :-----: |
| RJMP     | k        | Relative Jump                       |                    PC |   ←   | PC + k + 1  | None        |    2    |
| IJMP     |          | Indirect Jump to (Z)                |              PC(15:0) |   ←   | Z           | None        |    2    |
|          |          |                                     |             PC(21:16) |   ←   | 0           |             |         |
| EIJMP    |          | Extended Indirect Jump to (Z)       |              PC(15:0) |   ←   | Z           | None        |    2    |
|          |          |                                     |             PC(21:16) |   ←   | EIND        |             |         |
| JMP      | k        | Jump                                |                    PC |   ←   | k           | None        |    3    |
| RCALL    | k        | Relative Call Subroutine            |                    PC |   ←   | PC + k + 1  | None        |   3/4   |
| ICALL    |          | Indirect Call to (Z)                |              PC(15:0) |   ←   | Z           | None        |   3/4   |
|          |          |                                     |             PC(21:16) |   ←   | 0           |             |         |
| EICALL   |          | Extended Indirect Call to (Z)       |              PC(15:0) |   ←   | Z           | None        |    4    |
|          |          |                                     |             PC(21:16) |   ←   | EIND        |             |         |
| CALL     | k        | Call Subroutine                     |                    PC |   ←   | k           | None        |   4/5   |
| RET      |          | Subroutine Return                   |                    PC |   ←   | STACK       | None        |   4/5   |
| RETI     |          | Interrupt Return                    |                    PC |   ←   | STACK       | I           |   4/5   |
| CPSE     | Rd, Rr   | Compare, skip if Equal              |       if (Rd = Rr) PC |   ←   | PC + 2 or 3 | None        |  1/2/3  |
| CP       | Rd, Rr   | Compare                             |               Rd - Rr |       |             | Z,C,N,V,S,H |    1    |
| CPC      | Rd, Rr   | Compare with Carry                  |           Rd - Rd - C |       |             | Z,C,N,V,S,H |    1    |
| CPI      | Rd, K    | Compare with Immediate              |                Rd - k |       |             | Z,C,N,V,S,H |    1    |
| SBRC     | Rr, b    | Skip if Bit in Register Cleared     |     if (Rr(b) = 0) PC |   ←   | PC + 2 or 3 | None        |  1/2/3  |
| SBRS     | Rr, b    | Skip if Bit in Register Set         |     if (Rr(b) = 1) PC |   ←   | PC + 2 or 3 | None        |  1/2/3  |
| SBIC     | A, b     | Skip if Bit in I/O Register Cleared | if (I/O(A, b) = 0) PC |   ←   | PC + 2 or 3 | None        |  1/2/3  |
| SBIS     | A, b     | Skip if Bit in I/O Register Set     | if (I/O(A, b) = 1) PC |   ←   | PC + 2 or 3 | None        |  1/2/3  |
| BRBS     | s, k     | Branch if Status Flag Set           |   if (SREG(s) = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRBC     | s, k     | Branch if Status Flag Cleared       |   if (SREG(S) = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BREQ     | k        | Branch if Equal                     |         if (Z = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRNE     | k        | Branch if Not Equal                 |         if (Z = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRCS     | k        | Branch if Carry Set                 |         if (C = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRCC     | k        | Branch if Carry Cleared             |         if (C = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRSH     | k        | Branch if Same or Higer             |         if (C = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRLO     | k        | Branch if Lower                     |         if (C = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRMI     | k        | Branch if Minus                     |         if (N = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRPL     | k        | Branch if Plus                      |         if (N = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRGE     | k        | Branch if Greater or Equal, Signed  |     if (N ⊕ V = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRLT     | k        | Branch if Less Than, Signed         |     if (N ⊕ V = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRHS     | k        | Branch if Half Carry Flag Set       |         if (H = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRHC     | k        | Branch if Half Carry Flag Cleared   |         if (H = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRTS     | k        | Branch if T Flag Set                |         if (T = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRTC     | k        | Branch if T Flag Cleared            |         if (T = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRVS     | k        | Branch if Overflow Flag is Set      |         if (V = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRVC     | k        | Branch if Overflow Flag is Cleared  |         if (V = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRIE     | k        | Branch if Interrupt Enabled         |         if (I = 1) PC |   ←   | PC + k + 1  | None        |   1/2   |
| BRID     | k        | Branch if Interrupt Disabled        |         if (I = 0) PC |   ←   | PC + k + 1  | None        |   1/2   |

## Data Transfer Instructions

| Mnemonic | Operands | Description                                     |             |  Op   |                     | Flags     | #Clocks |
| :------- | :------- | :---------------------------------------------- | ----------: | :---: | :------------------ | --------- | :-----: |
| MOV      | Rd, Rr   | Copy Register                                   |          Rd |   ←   | Rr                  | None      |    1    |
| MOVW     | Rd, Rr   | Copy Pair Register                              |   Rd + 1:Rd |   ←   | Rr + 1:Rr           | None      |    1    |
| LDI      | Rd, K    | Load Immediate                                  |          Rd |   ←   | K                   | None      |    1    |
| LDS      | Rd, k    | Load Direct from data space                     |          Rd |   ←   | (k)                 | None      |    2    |
| LD       | Rd, X    | Load Indirect                                   |          Rd |   ←   | (X)                 | None      |    2    |
| LD       | Rd, X+   | Load Indirect and Post-Increment                |          Rd |   ←   | (X)                 | None      |    2    |
|          |          |                                                 |           X |   ←   | X + 1               |           |         |
| LD       | Rd, -X   | Load Indirect and Pre-Decrement                 |           X |   ←   | X - 1               | None      |    2    |
|          |          |                                                 |          Rd |   ←   | (X)                 |           |         |
| LD       | Rd, Y    | Load Indirect                                   |          Rd |   ←   | (Y)                 | None      |    2    |
| LD       | Rd, Y+   | Load Indirect and Post-Increment                |          Rd |   ←   | (Y)                 | None      |    2    |
|          |          |                                                 |           Y |   ←   | Y + 1               |           |         |
| LD       | Rd, -Y   | Load Indirect and Pre-Decrement                 |           Y |   ←   | Y - 1               | None      |    2    |
|          |          |                                                 |          Rd |   ←   | (Y)                 |           |         |
| LDD      | Rd, Y+q  | Load Indirect with Displacement                 |          Rd |   ←   | (Y + q)             | None      |    2    |
| LD       | Rd, Z    | Load Indirect                                   |          Rd |   ←   | (Z)                 | None      |    2    |
| LD       | Rd, Z+   | Load Indirect and Post-Increment                |          Rd |   ←   | (Z)                 | None      |    2    |
|          |          |                                                 |           Z |   ←   | Z + 1               |           |         |
| LD       | Rd, -Z   | Load Indirect and Pre-Decrement                 |           Z |   ←   | Z + 1               | None      |    2    |
|          |          |                                                 |          Rd |   ←   | (Z)                 |           |         |
| LDD      | Rd, Z+q  | Load Indirect with Displacement                 |          Rd |   ←   | (Z + q)             | None      |    2    |
| STS      | k, Rr    | Store Direct to Data Space                      |         (k) |   ←   | Rd                  | None      |    2    |
| ST       | X, Rr    | Store Indirect                                  |         (X) |   ←   | Rr                  | None      |    1    |
| ST       | X+, Rr   | Store Indirect and Post-Increment               |         (X) |   ←   | Rr                  | None      |    1    |
|          |          |                                                 |           X |   ←   | X + 1               |           |         |
| ST       | -X, Rr   | Store Indirect and Pre-Decrement                |           X |   ←   | X - 1               | None      |    2    |
|          |          |                                                 |         (X) |   ←   | Rr                  |           |         |
| ST       | Y, Rr    | Store Indirect                                  |         (Y) |   ←   | Rr                  | None      |    2    |
| ST       | Y+, Rr   | Store Indirect and Post-Increment               |         (Y) |   ←   | Rr                  | None      |    2    |
|          |          |                                                 |           Y |   ←   | Y + 1               |           |         |
| ST       | -Y, Rr   | Store Indirect and Pre-Decrement                |           Y |   ←   | Y - 1               | None      |    2    |
|          |          |                                                 |         (Y) |   ←   | Rr                  |           |         |
| STD      | Y+q, Rr  | Store Indirect with Displacement                |     (Y + q) |   ←   | Rr                  | None      |    2    |
| ST       | Z, Rr    | Store Indirect                                  |         (Z) |   ←   | Rr                  | None      |    2    |
| ST       | Z+, Rr   | Store Indirect and Post-Increment               |         (Z) |   ←   | Rr                  | None      |    2    |
|          |          |                                                 |           Z |   ←   | Z + 1               |           |         |
| ST       | -Z, Rr   | Store Indirect and Pre-Decrement                |           Z |   ←   | Z - 1               | None      |    2    |
|          |          |                                                 |         (Z) |   ←   | Rr                  |           |         |
| STD      | Z+q, Rr  | Store Indirect with Displacement                |     (Z + q) |   ←   | Rr                  | None      |    2    |
| LPM      |          | Load Program Memory                             |          R0 |   ←   | (Z)                 | None      |    3    |
| LPM      | Rd, Z    | Load Program Memory                             |          Rd |   ←   | (Z)                 | None      |    3    |
| LPM      | Rd, Z+   | Load Program Memory and Post-Increment          |          Rd |   ←   | (Z)                 | None      |    3    |
|          |          |                                                 |           Z |   ←   | Z + 1               |           |         |
| ELPM     |          | Extended Load Program Memory                    |          R0 |   ←   | (RAMPZ:Z)           | None      |    3    |
| ELPM     | Rd, Z    | Extended Load Program Memory                    |          Rd |   ←   | (RAMPZ:Z)           | None      |    3    |
| ELPM     | Rd, Z+   | Extended Load Program Memory and Post-Increment |          Rd |   ←   | (RAMPZ:Z)           | None      |    3    |
|          |          |                                                 |   (RAMPZ:Z) |   ←   | (RAMPZ:Z) + 1       |           |         |
| SPM      |          | Store Program Memory                            |   (RAMPZ:Z) |   ←   | R1:R0               | None      |    4    |
| SPM      | Z+       | Store Program Memory and Post- Increment by 2   |   (RAMPZ:Z) |   ←   | R1:R0               | None      |    4    |
|          |          |                                                 |           Z |   ←   | Z + 2               |           |         |
| IN       | Rd, A    | In From I/O Location                            |          Rd |   ←   | I/O(A)              | None      |    1    |
| OUT      | A, Rr    | Out To I/O Location                             |      I/O(A) |   ←   | Rr                  | None      |    1    |
| PUSH     | Rr       | Push Register on Stack                          |       STACK |   ←   | Rr                  | None      |    2    |
| POP      | Rd       | Pop Register from Stack                         |          Rd |   ←   | STACK               | None      |    2    |
| LSL      | Rd       | Logical Shift Left                              |   Rd(n + 1) |   ←   | Rd(n)               | Z,C,N,V,H |    1    |
|          |          |                                                 |       Rd(0) |   ←   | 0                   |           |         |
|          |          |                                                 |           C |   ←   | Rd(7)               |           |         |
| LSR      | Rd       | Logical Shift Right                             |       Rd(n) |   ←   | Rd(n + 1)           | Z,C,N,V   |    1    |
|          |          |                                                 |       Rd(7) |   ←   | 0                   |           |         |
|          |          |                                                 |           C |   ←   | Rd(0)               |           |         |
| ROL      | Rd       | Rotate Left Through Carry                       |       Rd(0) |   ←   | C                   | Z,C,N,V,H |    1    |
|          |          |                                                 |   Rd(n + 1) |   ←   | Rd(n)               |           |         |
|          |          |                                                 |           C |   ←   | R(7)                |           |         |
| ROR      | Rd       | Rotate Right Through Carry                      |       Rd(7) |   ←   | C                   | Z,C,N,V   |    1    |
|          |          |                                                 |       Rd(n) |   ←   | Rd(n + 1)           |           |         |
|          |          |                                                 |           C |   ←   | Rd(0)               |           |         |
| ASR      | Rd       | Arithmetic Shift Right                          |       Rd(n) |   ←   | Rd(n + 1), n = 0..6 | Z,C,N,V   |    1    |
| SWAP     | Rd       | Swap Nibbles                                    | Rd(3 . . 0) |   ↔︎   | Rd(7 . . 4)         | None      |    1    |
| SBI      | A, b     | Set Bit in I/O Register                         |   I/O(A, b) |   ←   | 1                   | None      |    2    |
| CBI      | A, b     | Clear Bit in I/O Register                       |   I/O(A, b) |   ←   | 0                   | None      |    2    |
| BST      | Rr, b    | Bit Store from Register to T                    |           T |   ←   | Rr(b)               | T         |    1    |
| BLD      | Rd, b    | Bit load from T to Register                     |       Rd(b) |   ←   | T                   | None      |    1    |
| BSET     | s        | Flag Set                                        |     SREG(s) |   ←   | 1                   | SREG(s)   |    1    |
| BCLR     | s        | Flag Clear                                      |     SREG(s) |   ←   | 0                   | SREG(s)   |    1    |
| SEC      |          | Set Carry                                       |           C |   ←   | 1                   | C         |    1    |
| CLC      |          | Clear Carry                                     |           C |   ←   | 0                   | C         |    1    |
| SEN      |          | Set Negative Flag                               |           N |   ←   | 1                   | N         |    1    |
| CLN      |          | Clear Negative Flag                             |           N |   ←   | 0                   | N         |    1    |
| SEZ      |          | Set Zero Flag                                   |           Z |   ←   | 1                   | Z         |    1    |
| CLZ      |          | Clear Zero Flag                                 |           Z |   ←   | 0                   | Z         |    1    |
| SEI      |          | Global Interrupt Enable                         |           I |   ←   | 1                   | I         |    1    |
| CLI      |          | Global Interrupt Disable                        |           I |   ←   | 0                   | I         |    1    |
| SES      |          | Set Signed Test Flag                            |           S |   ←   | 1                   | S         |    1    |
| CLS      |          | Clear Signed Test Flag                          |           S |   ←   | 0                   | S         |    1    |
| SEV      |          | Set Two's Complement Overflow                   |           V |   ←   | 1                   | V         |    1    |
| CLV      |          | Clear Two's Complement Overflow                 |           V |   ←   | 0                   | V         |    1    |
| SET      |          | Set T in SREG                                   |           T |   ←   | 1                   | T         |    1    |
| CLT      |          | Clear T in SREG                                 |           T |   ←   | 0                   | T         |    1    |
| SEH      |          | Set Half Carry                                  |           H |   ←   | 1                   | H         |    1    |
| CLH      |          | Clear Half Carry Flag in SREG                   |           H |   ←   | 0                   | H         |    1    |

## MCU Control Instructions

| Mnemonic | Operands | Description    |      |  Op   |      | Flags | #Clocks |
| :------- | :------- | :------------- | ---: | :---: | :--- | ----- | :-----: |
| BREAK    |          | Break          |      |       |      | None  |    1    |
| NOP      |          | No Operation   |      |       |      | None  |    1    |
| SLEEP    |          | Sleep          |      |       |      | None  |    1    |
| WDR      |          | Watchdog Reset |      |       |      | None  |    1    |