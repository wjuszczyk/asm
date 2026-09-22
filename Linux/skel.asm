; To compile run:
;   nasm -f elf skel.asm 
;   gcc -m32 -o skel skel.o

global main

; Used for declaring initialized data or constants. This data does not change at runtime.
section .data

; Used for declaring variables.
section .bss

; Actual code
section .text

main:
    mov eax, 1
    mov ebx, 0
    int 0x80
