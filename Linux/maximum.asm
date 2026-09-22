section .data
    data_items dd 3,6,34,222,45,75,54,34,33,33,22,11,66,0

section .bss

section .text
    global _start

_start:
    mov edi, 0
    mov eax, dword [data_items + 4 * edi]
    ;nop
    mov ebx, eax

start_loop:
    cmp eax, 0
    je loop_exit

    inc edi
    mov eax, dword [data_items + 4 * edi]
    ;nop
    cmp eax, ebx
    jle start_loop

    mov ebx, eax
    jmp start_loop

loop_exit:
    mov eax, 1
    int 0x80
