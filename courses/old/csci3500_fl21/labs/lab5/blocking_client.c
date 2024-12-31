


#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/ip.h>
#include <arpa/inet.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>

#define backlog_size 50

int main( int argc, char* argv[] ){

        if( argc != 3 ){
                printf("Usage: ./blocking_client <ip_address> <port_number>\n");
                exit(0);
        }

        char* ip_address = argv[1];

        char* ptr;
        int portnum = strtol( argv[2], &ptr, 10 );
        if( *ptr != '\0' ){
                printf("Usage: ./blocking_client <ip_address> <port_number>\n");
                exit(0);
        }

        struct sockaddr_in server;

        int serverfd = socket( AF_INET, SOCK_STREAM, 0 );
        if( serverfd == -1 ){
                perror("Could not create socket");
                exit(-1);
        }

        memset( &server, 0, sizeof(struct sockaddr_in) );

        server.sin_family = AF_INET;
        server.sin_port = htons( portnum );
        int ret_val = inet_aton( ip_address, &server.sin_addr );
        if( ret_val == 0 ){
                printf("Error: invalid ip address format\n");
                exit(-1);
        }

        ret_val = connect( serverfd, (const struct sockaddr*) &server, sizeof( struct sockaddr_in) );
        if( ret_val == -1 ){
                perror("Could not connect");
                exit(-1);
        }


        return 0;
}
