;-------------------------------------------------------------------------------
;   PAGE [length][,width].
;       Defaults to 50, 80. With no operand forces a page to eject at specific 
;       line.
;-------------------------------------------------------------------------------
    page 60, 132

;-------------------------------------------------------------------------------
;   TITLE text    comment
;-------------------------------------------------------------------------------
TITLE   SKELETON (EXE)   ASM skeleton

;-------------------------------------------------------------------------------
;   name    SEGMENT align   combine 'class'
;       align: indicates the boundary on which the segment is to begin. For the
;       typical requirement, PARA, the segment aligns on a paragraph boundary,
;       so that the starting address is evenly divisible by 16 (10H).
;       Defaults to PARA.
;
;       combine: indicates whether to combine the segment with other segments 
;       when they are linked after assembly.
;       Types:  STACK, COMMON, PUBLIC, AT
;       Use PUBLIC and COMMON when combinning separately assembled programs when
;       linking them.
;
;       class:  used to group related segments when linking.
;       MS recommended: 'stack', 'data', 'code'
;-------------------------------------------------------------------------------
STACKSG SEGMENT PARA    STACK   'Stack'
    DW  32  DUP (0)
STACKSG ENDS

;-------------------------------------------------------------------------------
DATASG  SEGMENT PARA    'Data'
DATASG  ENDS

;-------------------------------------------------------------------------------
CODESG  SEGMENT PARA    'Code'
MAIN    PROC    FAR
    ASSUME  SS:STACKSG,DS:DATASG,CS:CODESG
    MOV AX, DATASG      ; Set address of data segment in DS
    MOV DS, AX
;
; code here
;
    
    MOV AX, 4C00H       ; Exit with code 0. Same as:
    ;MOV AH, 4CH
    ;MOV AL, returncode
    INT 21H
MAIN    ENDP    
CODESG  ENDS
    END MAIN