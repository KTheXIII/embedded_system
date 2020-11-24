# Branching instructions

**NOTE**: More info about different flags are in [Registers.md](/Assembly/Registers.md#sreq-status-register).

## Table of Contents

- [Branching instructions](#branching-instructions)
  - [Table of Contents](#table-of-contents)
  - [Conditional Jump Instructions](#conditional-jump-instructions)
    - [BREQ - Branch if Equal](#breq---branch-if-equal)
    - [BRNE - Branch if Not Equal](#brne---branch-if-not-equal)
    - [BRCS - Branch if Carry Set](#brcs---branch-if-carry-set)
    - [BRLO - Branch if Lower (Unsigned)](#brlo---branch-if-lower-unsigned)
    - [BRCC - Branch if Carry Cleared](#brcc---branch-if-carry-cleared)
    - [BRSH - Branch if Same or Higher (Unsigned)](#brsh---branch-if-same-or-higher-unsigned)

## Conditional Jump Instructions

The cycles it takes for these instructions are

| Cycles | Condition |
| ------ | --------- |
| 1      | false     |
| 2      | true      |

The penalty is either 1 if it's false or 2 if it's true.

### BREQ - Branch if Equal

Tests the Zero Flag (Z) and branches relatively to PC if Z is **set**.

Syntax:

```asm
BREQ k
```

where `k` is where the program will jump to.

### BRNE - Branch if Not Equal

Tests the Zero Flag (Z) and branches relatively to PC if Z is **cleared**.

Syntax:

```asm
BRNE k
```

where `k` is where the program will jump to.

### BRCS - Branch if Carry Set

Tests the Carry Flag (C) and branches relatively to PC if C is **set**.

Syntax:

```asm
BRCS k
```

where `k` is where the program will jump to.

### BRLO - Branch if Lower (Unsigned)

Tests the Carry Flag (C) and branches relatively to PC if C is **set**.

Syntax:

```asm
BRLO k
```

where `k` is where the program will jump to.

### BRCC - Branch if Carry Cleared

Tests the Carry Flag (C) and branches relatively to PC if C is **cleared**.

Syntax

```asm
BRCC k
```

where `k` is where the program will jump to.

### BRSH - Branch if Same or Higher (Unsigned)

Tests the Carry Flag (C) and branches relatively to PC if C is **cleared**.

Syntax:

```asm
BRSH k
```

where `k` is where the program will jump to.