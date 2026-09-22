; To compile run:
;   nasm -f elf skel.asm 
;   ld -s -m elf_i386 -o hello hello.o 

%macro exit 1
    mov eax, 1
    mov ebx, %1
    int 80h
%endmacro

%macro write_string 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

; Used for declaring initialized data or constants. This data does not change at runtime.
section .data
    msg db 49,50,51,65,66,67,0xA,0xD
    lenMsg equ 8
    
; Used for declaring variables.
section .bss

; Actual code
section .text
    global _start

_start:
    write_string msg, lenMsg
    exit 0
