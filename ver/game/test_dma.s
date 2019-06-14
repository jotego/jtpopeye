; Fills DMA memory with consequtive values

    DI
    ; Init stack
    LD IX,0x8C00    ; RAM end before DMA section
    LD SP,IX        ; initialize stack pointer with that value
    ; and now fills from that value on
    
    LD B,4
NEXT_BANK:
    LD C,B
    LD A,0
    LD B,0
NEXT:
    LD (IX+0),A
    INC IX
    INC A
    DJNZ NEXT
    LD B,C
    DJNZ NEXT_BANK

END_LOOP:
    JP END_LOOP

CODEEND:
DS $8000-CODEEND
