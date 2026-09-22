TITLE   PGM6_E2:    DISPLAY ASCII CHARS FROM 80H TO FFH, 10 CHARS PER LINE
.MODEL  SMALL
.STACK  100H
.DATA
    CRLF    DB  0DH, 0AH, '$'
.CODE
MAIN    PROC
    ;initialize DS
    MOV AX, @data
    MOV DS, AX

    ;counter for 10 chars per line
    MOV BX, 0
    ;start display from char 80H to FFH (FFh-80h=80h)
    MOV DL, 80H
    ;initialize counter for loop
    MOV CX, 80H
    
PETLA:
    ;display char function (char in DL)
    MOV AH, 2
    INT 21H
    
    ;move to next char
    INC DL
    ;increase chars per line counter
    INC BX
    
    ;if BX = 10
    CMP BX, 10
    ;not, go on with loop
    JNE GO_ON
    ;then zero BX
    XOR BX, BX
    
    ;save DX to stack
    PUSH DX
    ;print string function (new line)
    MOV AH, 9               ;print CRLF
    LEA DX, CRLF
    INT 21H
    ;restore DX from stack
    POP DX

GO_ON:
    LOOP PETLA

    ;dos exit when CX = 0
    MOV AH, 4CH
    INT 21H    
MAIN ENDP
    END MAIN