TITLE   PGM6_E1:    READ TWO CAPITAL LETTERS AND DISPLAY THEM IN ALPHABETICAL ORDER
.MODEL  SMALL
.STACK  100H
.DATA
    PROMPT  DB  '? $'
    LETTER  DB  ?
    CRLF    DB  0DH, 0AH, '$'
    NOCAP   DB  0DH, 0AH, 'Not a capital letter!$'
.CODE
MAIN    PROC
    ;initialize DS
    MOV AX, @data
    MOV DS, AX
    
   ;display opening message
    MOV AH, 9               ;display string function
    LEA DX, PROMPT          ;get message
    INT 21H                 ;and display

    ;initialize counter
    MOV CX, 2
    ;set DL to highest char
    MOV DL, 'Z'
    
READ_CHAR:
    MOV AH, 1               ;read char function
    INT 21H                 ;char in AL
    
    CMP AL, 'A'             ;check if capital above 'A'
    JNGE NOT_CAPITAL
    
    CMP AL, 'Z'             ;check if capital below 'Z'
    JNLE NOT_CAPITAL

    ; if so, proceed
    MOV LETTER, AL          ;save input char
    
    ; if DL (1st pass: 'Z') <= LETTER
    CMP DL, LETTER
    JGE ELSE_
    ; then
    JMP DISPLAY_
    LOOP READ_CHAR
ELSE_:
    XCHG DL, LETTER
    LOOP READ_CHAR
    JMP DISPLAY_
DISPLAY_:
    PUSH DX                 ;save DX before CRLF

    MOV AH, 9               ;print CRLF
    LEA DX, CRLF
    INT 21H

    POP DX                  ;restore DX
    MOV AH, 2
    INT 21H                 ;print char from DL (lowest)
    MOV DL, LETTER          ;print second char (highest)
    INT 21H
    JMP EXIT
    
NOT_CAPITAL:
    MOV AH, 9
    LEA DX, NOCAP
    INT 21H
    JMP EXIT
EXIT:
    ;dos exit
    MOV AH, 4CH
    INT 21H    
MAIN ENDP
    END MAIN