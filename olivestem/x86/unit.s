section .bss
num     resb 3

section .text
global  _start

_start:
	mov bl, 10
	mov [num], bl
	inc bl
	mov [num+1], bl
	inc bl
	mov [num+2], bl

	mov eax, 1
	int 80h
