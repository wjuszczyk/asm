section .data
char    DB 'A'

section .text
global  _start

_start:
	mov bl, [char]
	mov eax, 1
	int 80h
