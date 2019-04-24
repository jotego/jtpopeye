    DI
    LD B,055h
LOOP:
    LD A,B
    OUT (0F0h),A      ;SEND THE BYTE
WAIT:
    IN A,(0F1h)
    AND 1
    JP NZ,WAIT
; Try to read now
WAIT_RD:
    IN A,(0F0h)
    AND 1
    JP Z,WAIT_RD

    IN A,(0F2h)
    LD B,A
    INC B
    JP LOOP
END_LOOP:
    JP END_LOOP
