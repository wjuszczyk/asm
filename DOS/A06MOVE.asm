    page 60, 132
TITLE   A06MOVE (EXE)   Extended move operations
;-----------------------------------------------------------
    .MODEL SMALL
    .STACK 64
;-----------------------------------------------------------
    .DATA
    HEADG1  DB  'InterTech'
    HEADG2  DB  'LaserCorp','$'
    CRLF    DB  0DH, 0AH, '$'
;-----------------------------------------------------------
    .CODE
A10MAIN PROC    FAR
        MOV AX, @data       ; Initialize segment registers
        MOV DS, AX
        MOV ES, AX

        MOV AH, 09H         ; Request first display
        LEA DX, HEADG2      ; of HEADG2
        INT 21H
        
        MOV AH, 09H         ; Request display
        LEA DX, CRLF        ; of CRLF
        INT 21H
        
        MOV CX, 09          ; Initialize to move 9 chars
        LEA SI, HEADG1      ; Initialize address of HEADG1
        LEA DI, HEADG2      ; and HEADG2
A20:
        MOV AL, [SI]        ; Get character from HEADG1,
        MOV [DI], AL        ; move it to HEADG2
        INC SI              ; Incr next char in HEADG1
        INC DI              ; Incr next pos in HEADG2
        DEC CX              ; Decrement count for loop
        JNZ A20             ; Jump if not zero
        
        MOV AH, 09H         ; Request display
        LEA DX, HEADG2      ; of HEADG2
        INT 21H
        
        MOV AX, 4C00H       ; End processing
        INT 21H
A10MAIN ENDP
        END A10MAIN
        