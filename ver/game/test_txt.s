    DI
    LD A,0
    LD IX,0xa000
    LD C,8
EXT_LOOP:
    LD B,0
ZERO_TXT:
    LD (IX+0),A
    INC A
    INC IX
    DJNZ ZERO_TXT
    DEC C
    JP  NZ,EXT_LOOP

END_LOOP:
    JP END_LOOP
