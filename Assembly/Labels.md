# Labels

Labels are used for marking and creating subroutines in our code. They are later mapped to where in memory where the beginning of our code lies.

We can create a label in our code like this

```asm
<label>: ; Labeled instruction here
```

Example: Create an infinite loop that does nothing

```asm
loop:
  RJMP loop
```

You might also see it like this

```asm
loop: RJMP loop
```

Here the instruction `RJMP loop` is labeled.