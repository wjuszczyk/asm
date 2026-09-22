global main
section .data
section .bss
section .text

main:
    mov eax, 1
    mov ebx, 0
    int 0x80
