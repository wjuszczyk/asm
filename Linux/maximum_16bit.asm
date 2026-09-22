section .data
    data_items dw 3,6,34,222,45,75,54,34,33,33,22,11,66,0

section .bss

section .text
    global _start

_start:
    mov edi, 0
    mov ax, word [data_items + 2 * edi]
    mov bx, ax

start_loop:
    cmp ax, 0
    je loop_exit

    inc edi
    mov ax, word [data_items + 2 * edi]

    cmp ax, bx
    jle start_loop

    mov bx, ax
    jmp start_loop

loop_exit:
    xor eax, eax
    mov ax, 1
    int 0x80
