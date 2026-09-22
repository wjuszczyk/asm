    page 60, 132
TITLE   SLOOP (EXE)   Simple loop showing chars

STACKSG SEGMENT PARA    STACK   'Stack'
    DW  32  DUP (0)
STACKSG ENDS

;-------------------------------------------------------------------------------
DATASG  SEGMENT PARA    'Data'
    CLOOP   EQU 10
    PROMPT  DB  "Type any character:$"
    CRLF    DB  0D, 0AH, '$'
    CHAR    DB  ?
    TAB     DB  CLOOP   DUP(0),'$'
DATASG  ENDS

;-------------------------------------------------------------------------------
CODESG  SEGMENT PARA    'Code'
        ASSUME  SS:STACKSG,DS:DATASG,CS:CODESG
MAIN    PROC    FAR
    ;Set address of data segment in DS
    MOV AX, DATASG
    MOV DS, AX

    ;display prompt for char
    MOV DX, OFFSET PROMPT
    CALL WRITE

    ;read character function
    CALL READ
    MOV CHAR, AL            ;save character

    ;display CRLF
    CALL WRITELN
    
    MOV CX, CLOOP           ;initialize counter for loop (CX)
    MOV SI, 0               ;counter
;display character function
M1: MOV DL, CHAR
    CALL DISPLCH

    SUB DX, SI              ;reversed chars (a..t -> t..a)
    ADD DX, CX
    DEC DX
    
    MOV TAB[SI], DL         ;Fill table with chars

    INC SI                  ;increase counter
    INC CHAR                ;move to next char in ASCII
    
LOOP M1

    CALL WRITELN
    
    MOV DX, OFFSET TAB      ;Show table
    CALL WRITE
    
    CALL EXIT

WRITELN PROC
    MOV DX, OFFSET CRLF
WRITE:
    MOV AH, 9
    INT 21H
    RET
WRITELN ENDP

READ    PROC
    MOV AH, 1
    INT 21H
    RET
READ    ENDP

DISPLCH PROC
    MOV AH, 2
    INT 21H
    RET
DISPLCH ENDP

EXIT    PROC
    MOV AX, 4C00H
    INT 21H
    RET
EXIT    ENDP

MAIN    ENDP    
CODESG  ENDS
    END MAIN