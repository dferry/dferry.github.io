#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/ip.h>
#include <string.h>

/* Four steps to creating a server/listening socket
 *
 * 1) Create socket with socket() system call
 * 2) bind() the socket to local address (port number)
 * 3) Call listen() to put the socket in listening mode
 * 4) Call accept() to wait for a connection attempt
 * */

/* Input arguments:
 * argv[1] = port number
 * */

int main( int argc, char* argv[] ) {

	if( argc != 2 ){
		printf("Usage: ./server <port number>\n");
		return 0;
	}

	char* portString = argv[1];
	int portNum = atoi( portString );
	
	//First step - create socket
	int sockfd = socket( AF_INET, SOCK_STREAM, 0 );
	if( sockfd == -1 ){
		perror("Could not create listening socket");
		return -1;
	}

	//Second step - bind to port
	struct sockaddr_in in_addr;
	//Clear address to zeros
	memset( &in_addr, 0, sizeof( struct sockaddr_in ) );
	//Fill in address info
	in_addr.sin_family = AF_INET;
	in_addr.sin_port = htons( portNum );
	in_addr.sin_addr.s_addr = INADDR_ANY;
	int ret = bind( sockfd, (struct sockaddr*)&in_addr, sizeof( struct sockaddr_in ) );
	if( sockfd == -1 ){
		perror( "Could not bind address" );
		return -1;
	}

	//Third step - listen
	ret = listen( sockfd, 5 );
	if( ret == -1 ){
		perror( "Could not listen to socket");
		return -1;
	}

	//Fourth step - accept incoming connection 
	int cfd = accept( sockfd, NULL, NULL );
	if( cfd == -1 ){
		perror("Accept failed");
		return -1;
	 }

	printf("Accepted client connection\n");

	int bufferSize = 1024;
	char buffer[ bufferSize ];
	int bytesRead = read( cfd, buffer, bufferSize );

	printf("Got '%s' from client\n", buffer ); 
	
	FILE* clientSock = fdopen( cfd, "w+" );
	
	fgets( buffer, bufferSize, clientSock );

	printf("Got second '%s' from client\n", buffer );

	fprintf( clientSock, "Thank you for your message '%s'\n", buffer );

	return 0;

}









