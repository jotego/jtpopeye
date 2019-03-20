    DI
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
