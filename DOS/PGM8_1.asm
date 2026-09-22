TITLE   PGM8_1: REVERSE INPUT
.MODEL  SMALL
.STACK  100H
.CODE
MAIN PROC
    ;display user prompt
    MOV AH, 2
    MOV DL, '?'
    INT 21H
    ;initialize character count
    XOR CX, CX
    ;read a character
    MOV AH, 1
    INT 21H
    ;while character is not a CR do
WHILE_:
    CMP AL, 0DH         ;CR?
    JE  END_WHILE       ;yes, exit loop
    ;save character on the stack and increment counter
    PUSH AX
    INC CX
    ;read a character
    INT 21H
    JMP WHILE_
END_WHILE:
    ;go to a new line
    MOV AH, 2
    MOV DL, 0DH         ;CR
    INT 21H
    MOV DL, 0AH         ;LF
    INT 21H
    JCXZ EXIT           ;exit if no characters to read
;for count (CX) times do
TOP:
    ;pop a character from stack
    POP DX
    ;display it
    INT 21H
    LOOP TOP
;end for    
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN