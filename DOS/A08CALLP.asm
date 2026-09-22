    page 60, 132
TITLE A08CALLP (EXE)    Calling procedures
    .MODEL SMALL
    .STACK 64
    .DATA
    .CODE
A10MAIN PROC FAR
    CALL    B10
    MOV     AX, 4C00H
    INT     21H
A10MAIN ENDP

B10     PROC NEAR
    CALL    C10
    RET
B10     ENDP

C10     PROC NEAR
    RET
C10     ENDP
    END A10MAIN