        page 60, 132
TITLE   A04ASM2 (EXE)   Move and add operations
;-----------------------------------------------------------
    .MODEL  SMALL
    .STACK  64
    .DATA
    FLDD    DW  175
    FLDE    DW  150
    FLDF    DW  ?
;-----------------------------------------------------------
    .CODE
MAIN    PROC    FAR
    MOV AX, @data
    MOV DS, AX
    
    MOV AX, FLDD
    ADD AX, FLDE
    MOV FLDF, AX
    
    MOV AX, 4C00H
    INT 21H
MAIN    ENDP    
    END MAIN