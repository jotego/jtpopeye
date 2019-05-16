; Clear the screen and write characters 0-9 and A-F on the
; screen. The address bus is encoded so the characters
; will not show on the same row and will show in reverse order

    DI
    ; Init stack
    LD IX,0x8800    ; RAM end
    LD SP,IX
    LD IX,0xa000    ; text memory

    CALL CLR_SCREEN
    
    ; Write some chars
    LD IX,0xa000
    LD A,0
    LD B,16
ZERO_TXT:
    LD (IX+0),A
    INC A
    INC IX
    DJNZ ZERO_TXT

    ; change colour
    LD IX,0xa400
    LD A,3
    LD B,16
COL_TXT:
    LD (IX+0),A
    INC IX
    DJNZ COL_TXT

END_LOOP:
    JP END_LOOP

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