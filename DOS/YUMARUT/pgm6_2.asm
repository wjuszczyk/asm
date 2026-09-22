TITLE   PGM6_2: FIRST AND LAST CAPITALS
.MODEL  SMALL
.STACK  100H
.DATA
    PROMPT      DB  'Type a line of text',0DH,0AH,'$'
    NOCAP_MSG   DB  0DH, 0AH, 'No capitals $'
    CAP_MSG     DB  0DH, 0AH, 'First capital = '
    FIRST       DB  ']'
                DB  ', Last capital = '
    LAST        DB  '@ $'

.CODE
MAIN    PROC
    ;initialize DS
    MOV AX, @data
    MOV DS, AX
    
    ;display opening message
    MOV AH, 9               ;display string function
    LEA DX, PROMPT          ;get message
    INT 21H                 ;and display
    
    ;read and process a line of text
    MOV AH, 1               ;read char function
    INT 21H                 ;char in AL
WHILE_:
    ;while character is not a carriage return do
    CMP AL, 0DH             ;CR?
    JE  END_WHILE           ;yes, exit
    
    ;if character is capital letter
    CMP AL, 'A'             ;char >= 'A'?
    JNGE    END_IF          ;not a capital letter
    CMP AL, 'Z'             ;char <= 'Z'?
    JNLE    END_IF          ;not a capital letter
    ;then
    ;if character precedes first capital
    CMP AL, FIRST           ;char < first capital?
    JNL CHECK_LAST          ;no, >=
    ;then first capital - character
    MOV FIRST, AL           ;FIRST = char
    ;end if
CHECK_LAST:
    ;if character follows last capital
    CMP AL, LAST            ;char > last capital?
    JNG     END_IF          ;no, <=
    ;then last capital character
    MOV LAST, AL            ;LAST = char
    ;end if
END_IF:
    ;read a character
    INT 21H                 ;char in AL
    JMP WHILE_
END_WHILE:
    ;display results
    MOV AH, 9               ;display string function
    ;if no capitals were typed
    CMP FIRST, ']'          ;FIRST = ']'
    JNE CAPS                ;no, display results
    ;then
    LEA DX, NOCAP_MSG       ;no capitals
    JMP DISPLAY_
CAPS:
    LEA DX, CAP_MSG
DISPLAY_:
    INT 21H
    ;end if
    ;dos exit
    MOV AH, 4CH
    INT 21H
MAIN    ENDP
    END MAIN
