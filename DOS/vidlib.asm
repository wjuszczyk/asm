MyData SEGMENT  PUBLIC
        EXTRN   CRLF:Byte, LRXY:WORD
MyData ENDS

MyCode  SEGMENT PUBLIC
    PUBLIC  GotoXY, ClrScr, ClrWin, ScrlWin, VIDEO6
    PUBLIC  Write, Writeln
    
    ASSUME CS:MyCode, DS:MyData
    
;-------------------------------------------------------------------------------
;   GOTOXY - ustawianie kursora na pozycji X, Y
;
;   1 punkt wejsciowy:
;
;   GotoXY:
;       PRZED wywolaniem musi byc ustawione:
;           DL: wartosc X   Obie wrtosci liczone sa od 0
;           DH: wartosc Y
;
;   Dzialanie:  przesuwa kursor ekranowy na pozycje o wspolrzednych X, Y
;               zaladowanych uprzednio do DL i DH
;-------------------------------------------------------------------------------
GotoXY PROC
            mov AH, 02H         ;usluga VIDEO nr 2: pozycjonowanie kursora
            mov BH, 0           ;podstawowa strona wyswietlania o numerze 0
            int 10H             ;wywolanie VIDEO
            ret                 ;powrot do miejsca wywolania
GotoXY ENDP

;-------------------------------------------------------------------------------
;   CLRSCR - czyszczenie lub przesuwanie ekranu lub okna
;
;   4 punkty wejsciowe
;
;   ClrScr:
;       PRZED wywolaniem nie potrzeba podawac zadnych wartosci
;       Dzialanie:  czysci caly ekran (bialy tekst na czarnym tle - ekran ma
;                   atrybut wyswietlania 07H)
;
;   ClrWin:
;       PRZED wywolaniem musza byc okreslone:
;           CH: wspolrzedna Y gornego lewego rogu okna
;           CL: wspolrzedna X gornego lewego rogu okna
;           DH: wspolrzedna Y dolnego prawego rogu okna
;           DL: wspolrzedna Y dolnego prawego rogu okna
;       Dzialanie:  czysci o okreslonych rozmiarach
;
;   ScrlWin:
;       PRZED wywolaniem musza byc okreslone:
;           CH: wspolrzedna Y gornego lewego rogu okna
;           CL: wspolrzedna X gornego lewego rogu okna
;           DH: wspolrzedna Y dolnego prawego rogu okna
;           DL: wspolrzedna Y dolnego prawego rogu okna
;           AL: liczba wierszy, o jaka ma byc przesuniete okno
;               (0 powoduje czyszczenie, nie przesuwanie)
;       Dzialanie:  przesuwa (o liczbe wierszy okreslonych w AL) okno
;                   o wymiarach okreslonych przed wywolaniem. W miejsce
;                   wierszy przesunietych wprowadzane sa nowe, czyste wiersze 
;                   o atrybucie wyswietlania 07H.
;
;   VIDEO6:
;       PRZED wywolaniem musza byc okreslone:
;           CH: wspolrzedna Y gornego lewego rogu okna
;           CL: wspolrzedna X gornego lewego rogu okna
;           DH: wspolrzedna Y dolnego prawego rogu okna
;           DL: wspolrzedna Y dolnego prawego rogu okna
;           AL: liczba wierszy, o jaka ma byc przesuniete okno
;               (0 powoduje czyszczenie, nie przesuwanie)
;           BH: atrybut wyswietlania dla czyszczonych lub nowo wprowadzanych
;               wierszy (07H - atrybut normalny, bialy tekst na czarnym tle)
;       Dzialanie:  udostepnia usluge BIOS VIDEO nr 6. Przed wywolaniem
;                   nalezy podac zawartosc WSZYTSKICH rejestrow, wg powyzszego
;                   zestawienia.
;-------------------------------------------------------------------------------
ClrScr PROC
            mov CX, 0           ;wspolrzedne gornego lewego rogu ekranu
            mov DX, LRXY        ;XY dolnego prawego rogu ladowane do DX
ClrWin:     mov AL, 0           ;0 oznacza czyszczenie prostokata
ScrlWin:    mov BH, 07H         ;normalny atrybut dla pustego wiersza
VIDEO6:     mov AH, 06H         ;usluga VIDEO 6: czyszczenie/przesuwanie
            int 10H             ;wywolanie VIDEO
            ret                 ;powrot do miejsca wywolania
ClrScr ENDP

;-------------------------------------------------------------------------------
;   WRITE - wyswietla na ekranie ciag znakow wykorzystujac usluge DOS nr 9
;
;   1 punkt wejsciowy
;
;   Write:
;       PRZED wywolaniem musi byc okreslone:
;           DS: adres segmentu, w ktorym znajduje sie wyswietlany ciag
;           DX: przesuniecie ciagu do wyswietlania
;              Ciag musi byc zakonczony "$".
;       Dzialanie:  wyswietla ciag znakow rozpoczynajacy sie od adresu DS:DX
;                   az do napotkania znaku "$".
;-------------------------------------------------------------------------------
Write PROC
            mov AH, 09H         ;wybor uslugi DOS nr 09H
            int 21H             ;wywolanie DOS
            ret                 ;powrot do miejsca wywolania procedury    
Write ENDP

;-------------------------------------------------------------------------------
;   WRITELN -   wyswietla informacje na ekranie wykorzystujac usluge DOS nr 9
;               oraz przenosi kursor do nowego wiersza.
;
;   1 punkt wejsciowy
;
;   Writeln:
;       PRZED wywolaniem musza byc okreslone:
;           DS: adres segmentu zawierajacego wyswietlany ciag znakow
;           DX: offset wyswietlanego ciagu
;              Ciag musi byc zakonczony "$".
;
;       Dzialanie:  wyswietla na ekranie ciag znakow zaczynajacy sie od adresu
;                   zawartego w DS:DX zakonczony znakiem "$". Nastepnie przesuwa
;                   kursor do poczatku nowego wiersza. Jesli kursor dojdzie do
;                   najnizszego wiersza ekranu, przesuwa ekran o jeden wiersz
;                   w gore.
;
;       Wywoluje:   Write
;-------------------------------------------------------------------------------
Writeln PROC
            call Write          ;wyswietlenie ciagu znakow
            mov DX, OFFSET CRLF ;zaladowanie przesuniecia CRLF do DX
            call Write          ;wyswietlenie ciagu nowego wiersza 
            ret                 ;powrot do miejsca wywolania procedury
Writeln ENDP

MyCode ENDS
END