section .text
global  _start

	; stack:
	; |____________________|
	; |_______ ebp ________| <- esp
	; |__ return address __|
	; |________ 5 _________|
	; |________ 4 _________|

addTwo:
	push ebp
	mov  ebp, esp
	mov  eax, [ebp+8]
	mov  ebx, [ebp+12]
	add  eax, ebx
	pop  ebp
	ret

_start:
	push 4
	push 5
	call addTwo

	mov ebx, eax
	mov eax, 1
	int 80h

