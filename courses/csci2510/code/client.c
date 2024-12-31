
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h> /* superset of previous */
#include <arpa/inet.h>


int main() {

	int PORT_NUM = 43679; //Any random number 10000-60000
	char* CONNECT_ADDRESS = "127.0.0.1";


	// STEP 1 - Create socket endpoint
	int sockFD = socket(AF_INET, SOCK_STREAM, 0);
	if( sockFD == -1 ){
		perror("Could not create socket");
		return -1;
	}	

	// STEP 2 - Connect to sever
	struct sockaddr_in address;
	memset(&address, 0, sizeof(struct sockaddr_in) );

	address.sin_family = AF_INET;
	address.sin_port   = htons( PORT_NUM );
	//address.sin_addr.s_addr = INADDR_ANY;
	inet_aton( CONNECT_ADDRESS, &address.sin_addr );

	int ret = connect( sockFD, (struct sockaddr*)&address, sizeof(struct sockaddr_in) );
	if( ret == -1 ){
		perror("Could not connect");
		return -1;
	}

	printf("Successfully connected.\n");

	FILE* sock = fdopen( sockFD, "r+" );

	char buffer [1024];
	fgets( &buffer, 1024, sock );

	printf("Got from server: '%s'\n", buffer );

	fprintf( sock, "42\n" );

	fgets( &buffer, 1024, sock );

	printf("Got from server: '%s'\n", buffer );

	return 0;

}

