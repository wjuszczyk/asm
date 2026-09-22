MyStack SEGMENT STACK
    DB  64  DUP ('STACK!!!')
MyStack ENDS

MyData SEGMENT
    Eat1    DB  "Eat at Joe's...$"
    Eat2    DB  "dziesiec milionow much nie moze sie mylic!$"
    CRLF    DB  0DH,0AH,'$'
MyData ENDS

MyCode SEGMENT
    assume CS:MyCode,DS:MyData
    Main PROC
        Start:
            mov AX, MyData
            mov DS, AX

            lea DX, Eat1
            call Writeln

            lea DX, Eat2
            call Writeln

            mov AH, 4CH
            mov AL, 0
            int 21h

    Write PROC
        mov AH, 09H
        int 21h
        ret        
    Write ENDP

    Writeln PROC
        call Write
        mov DX, OFFSET CRLF
        call Write
        ret        
    Writeln ENDP
    Main ENDP
MyCode ENDS
END Start