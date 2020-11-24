  .INCLUDE "m32u4def.inc"

  .EQU RESET    = 0x0000
  .EQU PM_START = 0x0056

  .DEF TEMP     = R16     ; Temporary value

  .CSEG
  .ORG RESET
  RJMP init

  .ORG PM_START

; https://dav3.net/1556/
delay_100ms:
  LDI R18, BYTE3(16 * 1000 * 100 / 5) ; 5 is the cycle count for instructions below
  LDI R17, HIGH(16 * 1000 * 100 / 5)
  LDI R16, LOW(16 * 1000 * 100 / 5)

  SUBI R16, 1 ; 1 cycle
  SBCI R17, 0 ; 1 if false (no skip), 2 if true, skip next
  SBCI R18, 0 ; 1 if false (no skip), 2 if true, skip next
  BRCC PC - 3 ; 1 if false, 2 if true

  RET         ; 4 cycles

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