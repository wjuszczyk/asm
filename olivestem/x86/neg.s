section .text
global  _start

_start:
	mov dl, 0b00001111
	not dl
	int 80h
