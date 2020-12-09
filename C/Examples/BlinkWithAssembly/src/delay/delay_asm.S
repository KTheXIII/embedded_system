;------------------------------------------------------------------------------
; delay_asm.S
;------------------------------------------------------------------------------
.GLOBAL delay_1_micros
.GLOBAL delay_micros
.GLOBAL delay_ms
.GLOBAL delay_1_s
.GLOBAL delay_s

;------------------------------------------------------------------------------
; Delay 1 µs
;------------------------------------------------------------------------------
delay_1_micros:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  RET

;------------------------------------------------------------------------------
; Delay some µs
; IN: 0 < R24 < 255
;------------------------------------------------------------------------------
delay_micros:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  DEC      R24
  CPI      R24, 0
  BRNE     delay_micros
  RET

;------------------------------------------------------------------------------
; Delay some ms
; IN: 0 < R24 < 255
;------------------------------------------------------------------------------
delay_ms:
  MOV      R18, R24
loop_dms:
  LDI      R24, 250
  RCALL    delay_micros
  LDI      R24, 250
  RCALL    delay_micros
  LDI      R24, 250
  RCALL    delay_micros
  LDI      R24, 250
  RCALL    delay_micros
  DEC      R18
  CPI      R18, 0
  BRNE     loop_dms
  RET

;------------------------------------------------------------------------------
; Delay 1 s
;------------------------------------------------------------------------------
delay_1_s:
  LDI      R24, 250
  RCALL    delay_ms
  LDI      R24, 250
  RCALL    delay_ms
  LDI      R24, 250
  RCALL    delay_ms
  LDI      R24, 250
  RCALL    delay_ms
  RET

;------------------------------------------------------------------------------
; Delay some s
; IN: 0 < R24 < 255 s
;------------------------------------------------------------------------------
delay_s: 
  MOV      R19, R24
loop_s:
  LDI      R24, 250
  RCALL    delay_ms
  LDI      R24, 250
  RCALL    delay_ms
  LDI      R24, 250
  RCALL    delay_ms
  LDI      R24, 250
  RCALL    delay_ms

  DEC      R19
  CPI      R19, 0
  BRNE     loop_s
  RET