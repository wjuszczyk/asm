section .data
    data_items dd 3,6,34,222,45,75,54,34,33,33,22,11,66,0
    data_len equ $-data_items    
section .bss

section .text
    global _start

_start:
    ;mov edi, 0
    mov eax, 4
    mov ebx, 1
    mov ecx, [data_items]
    mov edx, data_len
    int 0x80

;    inc edi
 
    mov eax, 1
    mov ebx, 0
    int 0x80
