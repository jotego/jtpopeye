    DI
    ; Init stack
    LD IX,$8F00    ; RAM end
    LD SP,IX
    LD IX,$A000

    CALL CLR_SCREEN
    LD A,0
    LD IX,$C000     ; lower nibbles
    LD IY,$D000     ; upper nibbles
    LD C,8
EXT_LOOP:
    LD B,0
ZERO_TXT:
    LD (IX+0),A     ; LSB
    LD (IY+0),A     ; MSB
    INC A
    INC IX
    INC IY
    DJNZ ZERO_TXT
    DEC C
    JP  NZ,EXT_LOOP

END_LOOP:
    JP END_LOOP

;**************************************
;** Clear text memory with $FF
CLR_SCREEN:
    LD IX,$A000
    LD A,$FF
    LD B,$80
    CALL COPY_ROW   ; $80
    LD B,$80
    CALL COPY_ROW   ; $100
    LD B,$80
    CALL COPY_ROW   ; $180
    LD B,$80
    CALL COPY_ROW   ; $200
    LD B,$80
    CALL COPY_ROW   ; $280
    LD B,$80
    CALL COPY_ROW   ; $300
    LD B,$80
    CALL COPY_ROW   ; $380
    LD B,$80
    CALL COPY_ROW   ; $400
    RET

COPY_ROW:
    LD (IX+0),A
    INC IX
    DJNZ COPY_ROW
    RET

CODEEND:
DS $8000-CODEEND