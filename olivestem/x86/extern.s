	; To compile:
	; nasm -f elf extern.s -o extern.o
	; gcc -no-pie -m32 extern.o -o extern

	extern printf
	extern exit

	section .data
	msg     DD "Hello World!", 0
	fmt     DB "Output is: %s", 10, 0

	section .text
	global  main

main:
	push msg
	push fmt
	call printf
	push 1
	call exit
