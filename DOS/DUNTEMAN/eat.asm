MyStack SEGMENT STACK
    DB 64 DUP ('STACK!!!')
MyStack ENDS

MyData SEGMENT
    Eat1    DB  "Eat at John's...$"
    CRLF    DB  0DH, 0AH, '$'
MyData ENDS

MyProg SEGMENT
    assume CS:MyProg, DS:MyData
Main PROC
Start:
    mov AX, MyData
    mov DS, AX
    lea DX, Eat1
    mov AH, 09H
    int 21H

    lea DX, CRLF
    mov AH, 09H
    int 21H

    mov AH, 4CH
    mov AL, 0
    int 21H
Main ENDP
MyProg ENDS
END Start