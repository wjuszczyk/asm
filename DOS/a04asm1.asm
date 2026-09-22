        page 60, 132
TITLE   A04ASM1 (EXE)   Move and add operations
;-----------------------------------------------------------
STACKSG SEGMENT PARA    STACK   'Stack'
    DW  32  DUP (0)
STACKSG ENDS
;-----------------------------------------------------------
DATASG  SEGMENT PARA    'Data'
    FLDD    DW  175
    FLDE    DW  150
    FLDF    DW  ?
DATASG  ENDS
;-----------------------------------------------------------
CODESG  SEGMENT PARA    'Code'
MAIN    PROC    FAR
    ASSUME  SS:STACKSG,DS:DATASG,CS:CODESG
    
    MOV AX, DATASG
    MOV DS, AX
    
    MOV AX, FLDD
    ADD AX, FLDE
    MOV FLDF, AX
    
    MOV AX, 4C00H
    INT 21H
MAIN    ENDP    
CODESG  ENDS
    END MAIN