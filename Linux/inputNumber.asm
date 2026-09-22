%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro exit 1
    mov eax, 1
    mov ebx, %1
    int 80h
%endmacro

section .data
    userMsg db  "Please enter a number: "
    lenUserMsg  equ $-userMsg
    dispMSG db  "You have entered: "
    lenDispMsg  equ $-dispMSG

section .bss
    num resb    5

section .text
    global _start

_start:
    write userMsg, lenUserMsg

    mov eax, 3
    mov ebx, 2
    mov ecx, num
    mov edx, 5
    int 80h

    write dispMSG, lenDispMsg

    write num, 5

    exit 0
