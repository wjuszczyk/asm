    page 60, 132
TITLE   SKELETON (EXE)   ASM simplified skeleton
    .MODEL  SMALL
    .STACK  64
    .DATA
VAR1    DB  ?

    .CODE
MAIN    PROC    FAR
    MOV AX, @data
    MOV DS, AX

    MOV AX, 4C00H
    INT 21H
MAIN    ENDP    
    END MAIN