section  .data
filename DD "./testfile.txt"

section .bss

buffer:
	resb 1024

	section .text
	global  _start

_start:
	;    syscall open (5)
	mov  eax, 5
	mov  ebx, filename
	;mov ecx, 0; O_RDONLY
	xor  ecx, ecx
	int  80h

	;   syscall read (3)
	mov ebx, eax; eax has file descriptor
	mov eax, 3
	mov ecx, buffer
	mov edx, 1024
	int 80h

	;syscall close (6)
	mov      eax, 6
	;        file descriptor already in ebx
	int      80h

	;   syscall write (4)
	mov eax, 4
	mov ebx, 1; STDOUT
	mov ecx, buffer
	mov edx, 1024
	int 80h

	;    exit
	mov  eax, 1
	;mov ebx, 0
	xor  ebx, ebx
	int  80h

