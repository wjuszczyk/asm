global main
extern printf
 
section .data
 
beer    db      "%d bottles of beer on the wall, %d bottles of beer."
        db      0x0a
        db      "Take one down and pass it around, %d bottles of beer."
        db      0x0a
        db      0
main:
        mov ecx, 5     ; deklarowana liczba przebiegów pętli
_loop:
        dec  ecx       ; ECX = ECX-1
        push ecx       ; umieszcza aktualny indeks pętli na stosie

        push ecx       ; argumenty funkcji printf() umieszczamy na stosie
        inc  ecx       ; w odwrotnej kolejności, tj. od prawej do lewej strony
        push ecx
        push ecx
        push beer
        call printf    ; wywołanie funkcji printf(beer,ecx,ecx,ecx-1)
        add  esp,16    ; zdejmujemy jej argumenty ze stosu

        pop  ecx       ; pobieramy ze stosu aktualny indeks pętli
        or   ecx, ecx  ; ustala wartość flagi ZF=0, jeśli ECX=0
        jne  _loop     ; warunkowy skok do początku pętli, gdy flaga ZF=0

        xor  eax,eax   ; EAX = 0
        ret            ; return EAX
