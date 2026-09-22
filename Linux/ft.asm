section .data
    file_name db 'myfile.txt', 0
    msg db 'Welcome to Tutorials Point!', 0xa, 0xd 
    len equ $-msg

section .bss
    fd_out resb 1
    fd_in resb 1
    info resb 26

section .text
    global _start
_start:
    ; create file
    mov eax, 8
    mov ebx, file_name
    mov ecx, 256+128    ; -rw-------
    int 80h

    mov [fd_out], eax

    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, msg
    mov edx, len
    int 80h

    ; close the file
    mov eax, 6
    mov ebx, [fd_out]
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
