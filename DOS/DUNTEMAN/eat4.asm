;-------------------------------|
;   POCZATEK SEGMENTU STOSU     |
;-------------------------------|
MyStack SEGMENT STACK             ;slowo STACK powoduje zaladowanie SS przez DOS
    DB  64  DUP ('STACK!!!')      ;rezerwacja 512 bajtow dla stosu
MyStack ENDS
;-------------------------------|
;   KONIEC SEGMENTU STOSU       |
;-------------------------------|

;-------------------------------|
;   POCZATEK SEGMENTU DANYCH    |
;-------------------------------|
MyData SEGMENT  PUBLIC
    
    PUBLIC LRXY, CRLF
    
    LRXY    DW  184FH             ;Y=18H=24D, X=4FH=79D - wspolrzedne XY prawego
                                  ;dolnego rogu ekranu 80x25 znakow liczone od 0
    TextPos DW  ?
    Eat1    DB  "Eat at Joe's...$"
    Eat2    DB  "dziesiec milionow much nie moze sie mylic!$"
    CRLF    DB  0DH, 0AH, '$'
MyData ENDS
;-------------------------------|
;   KONIEC SEGMENTU DANYCH      |
;-------------------------------|

;-------------------------------|
;   POCZATEK SEGMENTU KODU      |
;-------------------------------|
    
    EXTRN   GotoXY:PROC, Write:PROC, Writeln:PROC, ClrScr:PROC
    
MyCode SEGMENT  PUBLIC
    ASSUME CS:MyCode, DS:MyData

Main PROC
Start:                          ;tu zaczyna sie wykonywanie programu
            mov AX, MyData      ;ustawianie adresu wlasnego segmentu danych w DS
            mov DS, AX          ;rejestru DS nie mozna ladowac natychmiastowo

            call ClrScr         ;czyszczenie ekranu
            mov TextPos, 0914H  ;0914H: y=9, x=20

            mov DX, TextPos     ;TextPos zawiera wspolrzedne x, y danej pozycji
            call GotoXY         ;przesuwanie kursora do wskazanej pozycji
            lea DX, Eat1        ;zaladowanie przesuniecia ciagu EAT1 do DX
            call Write          ;wyswietlenie ciagu

            mov DX, TextPos     ;odtworzenie wartosci x, y
            mov DH, 10          ;zmiana wartosci y
            call GotoXY         ;przesuwanie kursora na nowa pozycje
            lea DX, Eat2        ;zaladuj przesuniecie ciagu EAT2 do DX
            call Writeln        ;wyswietlenie ciagu

            mov AH, 4CH         ;wybor uslugi zakonczenia procesu
            mov AL, 0           ;przekazanie zera do ERRORLEVEL
            int 21H             ;przekazanie sterowania do DOS
Main    ENDP
MyCode ENDS
;-------------------------------|
;   KONIEC SEGMENTU KODU        |
;-------------------------------|
END Start