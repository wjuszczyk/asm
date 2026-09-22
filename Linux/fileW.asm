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
    file_name db 'myfile.txt', 0

    msg db 'Welcome to Tutorials Point!',0xa,0xd
    len equ $-msg

    msg_done db 'Written to file...', 0xa,0xd
    len_done equ $-msg_done

; Used for declaring variables.
section .bss
    fd_out resb 1
    fd_in resb 1
    info resb 30

; Actual code
section .text
    global _start

_start:
    ; create file
    mov eax, 8
    mov ebx, file_name
    mov ecx, 256+128            ; -rw-------
    int 80h

    ; save file's descriptor
    mov [fd_out], eax

    ; write into the file
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, msg
    mov edx, len
    int 80h

    ; close the file
    mov eax, 6
    mov ebx, [fd_out]
    int 80h

    ; write the message indicating end of file write
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_done
    mov edx, len_done
    int 80h

    ; open the file for reading
    mov eax, 5
    mov ebx, file_name
    mov ecx, 0
    mov edx, 256
    int 80h

    mov [fd_in], eax

    ; read from file
    mov eax, 3
    mov ebx, [fd_in]
    mov ecx, info
    mov edx, 30
    int 80h

    ; close the file
    mov eax, 6
    mov ebx, [fd_in]
    int 80h

    write_string info, 30
    exit 0
