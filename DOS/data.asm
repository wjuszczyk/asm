MYSTACK SEGMENT STACK
    DB 64 DUP ('FF')
MYSTACK ENDS

MYDATA SEGMENT
    YEAR    DW  ?,'$'
    CRLF    DB  0DH,0AH,'$'
MYDATA ENDS

MYPROG SEGMENT
    ASSUME CS:MYPROG, DS:MYDATA
    MAIN PROC
    Start:
        ; initialize data segment
        MOV AX, MYDATA
        mov DS, AX

        ; get date function
        ; returns:
        ; CX    year (1980 to 2099)
        ; DH    month (1 to 12)
        ; DL    day (1 to 31)
        ; AL    day of the week (0=Sun, 1=Mon,...6=Sat)  DOS 1.1+
        MOV AH, 2AH
        INT 21H

        MOV YEAR, CX

        ; print day char, already in DL; offset it by 30h
        ADD DL, '0'
        MOV AH, 02H
        int 21h

        ; print month char
        XCHG DL,DH
        ADD DL, '0'
        MOV AH, 02H
        int 21h

        lea DX, CRLF
        mov AH, 09h
        int 21h

        ; print year string
        MOV DX, YEAR
        ADD DX, 30h
        MOV AH, 09H
        int 21h

        ; exit function with 0 error code
        MOV AH, 4CH
        MOV AL, 0
        INT 21H 
    MAIN ENDP
MYPROG ENDS
END Start