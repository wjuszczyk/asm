TITLE   PGM5_1: CHECK FLAGS
;used in DEBUG to check flag settings
.MODEL  SMALL
.STACK  100h
.CODE
MAIN    PROC
    MOV AX, 4000H
    ADD AX, AX
    SUB AX, 0FFFFH
    NEG AX
    INC AX
    MOV AH, 4CH
    INT 21H
MAIN    ENDP
    END MAIN