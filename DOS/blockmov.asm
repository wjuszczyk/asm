TITLE   BLOCK-MOVE  PROGRAM

    PAGE    , 132

COMMENT *This program moves a block of specified number of bytes from one place
        to another place*

;Define constants used in this program

    N=              16      ;Bytes to be moved
    BLK1ADDR=       100H    ;Source block offset address
    BLK2ADDR=       120H    ;Destination block offset address
    DATASEGADDR=    2000H   ;Data segment start address

STACK_SEG   SEGMENT STACK   'STACK'
    DB  64 DUP (?)
STACK_SEG   ENDS

CODE_SEG    SEGMENT 'CODE'
BLOCK   PROC    FAR
    ASSUME  CS:CODE_SEG, SS:STACK_SEG

    PUSH DS
    MOV AX, 0
    PUSH AX

    MOV AX, DATASEGADDR
    MOV DS, AX

    MOV SI, BLK1ADDR
    MOV DI, BLK2ADDR

    MOV CX, N

NXTPT:  MOV AH, [SI]
        MOV [DI], AH
        INC SI
        INC DI
        DEC CX
        JNZ NXTPT
        RET
BLOCK   ENDP
CODE_SEG    ENDS
    END BLOCK        