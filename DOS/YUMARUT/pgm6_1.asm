TITLE   PGM6_1: IBM CHARACTER DISPLAY
.MODEL  SMALL
.STACK  100H
.CODE
MAIN    PROC
    MOV AH, 2       ;display char function
    MOV CX, 256     ;no. of chars to display
    MOV DL, 0       ;DL has ASCII code of null char
PRINT_LOOP:
    INT 21h         ;display a char
    INC DL          ;increment ASCII code
    ;DEC CX          ;decrement counter
    ;JNZ PRINT_LOOP  ;keep going if CX not 0
    LOOP PRINT_LOOP
;DOS exit
    MOV AH, 4CH
    INT 21h
MAIN ENDP
    END MAIN
    