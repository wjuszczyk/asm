page 80, 132
INCLUDE MYLIB.MAC

MyStack SEGMENT STACK
    DB  64  DUP('STACK!!!')
MyStack ENDS

MyData SEGMENT
    LRXY        DW  184FH
    VidOrigin   DD  0B8000000H
    Eat1        DB  "Eat at Joe's..."
    Eat1Length  EQU $-Eat1
    Eat2        DB  "Dziesiec milionow much nie moze sie mylic!"
    Eat2Length  EQU $-Eat2
    CRLF        DB  0DH,0AH
MyData ENDS

MyProg SEGMENT
    assume CS:MyProg, DS:MyData
    Main PROC
Start:
        mov     AX, MyData
        mov     DS, AX

        Clear   VidOrigin, 07B0H, 4000
        GotoXY  14H, 09H
        Write   Eat1, Eat1Length
        GotoXY  14H, 0AH
        WriteLn Eat2, Eat2Length

        mov     AH, 4CH
        mov     AL, 0
        int     21H        
    Main ENDP
MyProg ENDS
    END Start