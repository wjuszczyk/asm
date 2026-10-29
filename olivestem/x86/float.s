section .data
x       DD 3.14
y       DD 2.1

section .text
global  _start

_start:
	movss xmm0, [x]
	movss xmm1, [y]
	addss xmm0, xmm1

	;       like CMP
	UCOMISS xmm0, xmm1
	JE      equal
	JA      end

equal:
	mov ecx, 1

end:
	mov eax, 1
	int 80h
