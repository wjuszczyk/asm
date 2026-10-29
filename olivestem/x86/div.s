section .text
global  _start

_start:
	mov  al, -4
	mov  cl, 2
	idiv cl
	int  80h

