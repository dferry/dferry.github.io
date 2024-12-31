
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h> /* superset of previous */



int main() {

	int PORT_NUM = 43679; //Any random number 10000-60000

	// STEP 1 - Create socket endpoint
	int listenFD = socket(AF_INET, SOCK_STREAM, 0);
	if( listenFD == -1 ){
		perror("Could not create socket");
		return -1;
	}	

	// STEP 2 - Bind address to socket
	struct sockaddr_in address;
	memset(&address, 0, sizeof(struct sockaddr_in) );

	address.sin_family = AF_INET;
	address.sin_port   = htons( PORT_NUM );
	address.sin_addr.s_addr = INADDR_ANY;

	int ret = bind( listenFD, (struct sockaddr*)&address, sizeof(struct sockaddr_in) );
	if( ret == -1 ){
		perror("Could not bind address");
		return -1;
	}

	// STEP 3 - Set socket to listening mode
	// After this point, the OS will accept incoming connections and
	// wait for our program to handle them. The number of waiting connections
	// that are allowed is the size of the backlog in the second argument.
	ret = listen( listenFD, 5 );
	if( ret == -1 ){
		perror("Could not set socket to listening mode");
		return -1;
	}

	int visitors = 0;

	// Step 4 - Accept incoming connections on this socket. This is a blocking
	// call that causes this program to wait here until a connection attempt
	// is made.

	while(1){
		int clientFD = accept( listenFD, NULL, 0 );
		if( clientFD == -1 ){
			printf("Could not accept new connection");
			return -1;
		}

		visitors++;
		printf("Visitor %d connected\n", visitors);

		FILE* sock = fdopen( clientFD, "r+" );

		fprintf( sock, "Give us a number\n");

		char buffer[1024];
		fgets( &buffer, 1024, sock );

		printf("Got number from client: '%s'\n", buffer );

		fprintf(sock, "Thank you\n");

		fclose( sock );
		close( clientFD );
	}

	return 0;
}

