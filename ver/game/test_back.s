    DI
    ; Init stack
    LD IX,0x8800    ; RAM end
    LD SP,IX
    LD IX,0xA000

    CALL CLR_SCREEN
    LD A,0
    LD IX,0xC000
    LD IY,0xD000
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
;** Clear text memory with 0xFF
CLR_SCREEN:
    LD IX,0xA000
    LD A,0xFF
    LD B,0x80
    CALL COPY_ROW   ; 0x80
    LD B,0x80
    CALL COPY_ROW   ; 0x100
    LD B,0x80
    CALL COPY_ROW   ; 0x180
    LD B,0x80
    CALL COPY_ROW   ; 0x200
    LD B,0x80
    CALL COPY_ROW   ; 0x280
    LD B,0x80
    CALL COPY_ROW   ; 0x300
    LD B,0x80
    CALL COPY_ROW   ; 0x380
    LD B,0x80
    CALL COPY_ROW   ; 0x400
    RET

COPY_ROW:
    LD (IX+0),A
    INC IX
    DJNZ COPY_ROW
    RET