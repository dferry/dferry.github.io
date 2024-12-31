#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/ip.h>
#include <string.h>

/* Two steps to creating a client / connecting socket
 * 1) Create a socket with the socket() system call
 * 2) Call connect()
 */

int main( int argc, char* argv[] ){

        if( argc != 3 ){
                printf("Usage: ./server <ip address> <port number>\n");
                return 0;
        }

	char* ipAddrString = argv[1];

        char* portString = argv[2];
        int portNum = atoi( portString );

        //First step - create socket
        int sockfd = socket( AF_INET, SOCK_STREAM, 0 );
        if( sockfd == -1 ){
                perror("Could not create listening socket");
                return -1;
        }

	//Second step, connect to an address
        struct sockaddr_in in_addr;
        //Clear address to zeros
        memset( &in_addr, 0, sizeof( struct sockaddr_in ) );
        //Fill in address info
        in_addr.sin_family = AF_INET;
        in_addr.sin_port = htons( portNum );
        inet_aton( ipAddrString, &in_addr.sin_addr );

	int ret = connect( sockfd, (struct sockaddr*)&in_addr, sizeof( struct sockaddr_in) );
	if( ret == -1 ){
		perror("Connect failed");
		return -1;
	}

	printf("Connected to server successfully\n");	

	write( sockfd, "This is from the client.", 25 );

	FILE* sockStream = fdopen( sockfd, "w+" );

	fprintf( sockStream, "My favorite number is %d\n", 42 );

	int bufferSize = 1024;
	char buffer [bufferSize];
	
	fgets( buffer, bufferSize, sockStream );

	printf("Got this back from the server: '%s'\n", buffer );

	return 0;
}









