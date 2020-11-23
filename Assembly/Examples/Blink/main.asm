  .INCLUDE "m32u4def.inc"

  .EQU RESET    = 0x0000
  .EQU PM_START = 0x0056

  .DEF TEMP     = R16     ; Temporary value

  .CSEG
  .ORG RESET
  RJMP init

  .ORG PM_START

delay_100ms:
  LDI R18, BYTE3(16 * 1000 * 100 / 5)
  LDI R17, HIGH(16 * 1000 * 100 / 5)
  LDI R16, LOW(16 * 1000 * 100 / 5)

  SUBI R16, 1
  SBCI R17, 0
  SBCI R18, 0
  BRCC PC - 3

  RET

init:
  ; Set stack pointer to point at the end of RAM.
  LDI R16, LOW(RAMEND)
  OUT SPL, R16
  LDI R16, HIGH(RAMEND)
  OUT SPH, R16

  CALL init_pins

  RJMP main

init_pins:
  LDI TEMP, 0xF0
  OUT DDRC, TEMP

  OUT PORTF, TEMP
  LDI TEMP, 0x00
  OUT DDRF, TEMP
  RET

main:
  LDI TEMP, 0x00
  OUT PORTC, TEMP
  CALL delay_100ms

  LDI TEMP, 0xF0
  OUT PORTC, TEMP
  CALL delay_100ms

  RJMP main           ; 2 cycles