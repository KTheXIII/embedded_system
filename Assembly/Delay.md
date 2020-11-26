# Delay in Assembly

Since every instruction take some clock cycle we can exploit this to make our delay. For AVR an instruction usually take one clock cycle. Example with ATmega32U4 with clock frequency of 16 MHz i.e 16 000 000 cycles. 

## Delay using NOP

`NOP` instruction takes 1 cycle and with a clock of 16 MHz that's 62.5 ns. The equation for frequency is

```
1/T = f
```

where f is the frequency.

We can solve for T and get the period, which is how much time is 1 clock cycle.

### Delay some µs

We can use NOP and some counting to delay be our delay. In order to make it reusable we can create a subroutine to be our delay. To delay for 1 µs we need to wait 16 cycles.

Out instruction below 

```asm
delay_micros:
  NOP
  NOP
  NOP
  NOP
  DEC Rx
  CPI Rx, 0x00        ; Compare our current value
  BRNE delay_micros   ; Loop if Rx != 0x00
  RET                 ; This will 
```

where `Rx` is the register we want to use to pass in our value.

Cycle cost for each instruction:

`DEC`: 1 cycle

`CPI`: 1 cycle

`BRNE`: 1 if condition is false, 2 if condition is true

`RET`: 4 cycles

Instructions that will be use to call the subroutine:

`LDI`: 1

`RCALL`: 3 cycles, `CALL`: 4 cycles