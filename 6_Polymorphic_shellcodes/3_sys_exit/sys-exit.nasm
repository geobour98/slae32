global _start

section .text
_start:

	xor eax, eax	; clear eax
	
	inc eax		; increment eax to 1

	xor ebx, ebx	; clear ebx

	int 0x80	; exec exit syscall
