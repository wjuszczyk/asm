TITLE   PGM8_2: MULTIPLICATION BY ADD AND SHIFT
.MODEL  SMALL
.STACK  100H
.CODE
MAIN PROC
;execute in DEBUG, place A in AX and B in BX
;DX will contain the product
    CALL MULTIPLY
    MOV AH, 4CH
    INT 21H
MAIN ENDP
MULTIPLY    PROC
;multiply two numbers A and B by shifting and addition
;input:     AX = A, BX = B. Numbers in range 0 - FFh
;output:    DX = product
    PUSH AX
    PUSH BX
    XOR DX, DX
REPEAT:
;if B is odd
    TEST BX, 1
    JZ  END_IF      ;no, even
;then
    ADD DX, AX      ;prod = prod + A
END_IF:
    SHL AX, 1       ;shift left A
    SHR BX, 1       ;shift right B
;until
    JNZ REPEAT
    POP BX
    POP AX
    RET
MULTIPLY ENDP    
    END MAIN