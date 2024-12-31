


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

        if( argc != 2 ){
                printf("Usage: ./nonblock_server <port_number>\n");
                exit(0);
        }

        char* ptr;
        int portnum = strtol( argv[1], &ptr, 10 ); 
        if( *ptr != '\0' ){
                printf("Usage: ./nonblock_server <port_number>\n");
                exit(0);
        }

        struct sockaddr_in server, client;

        int serverfd = socket( AF_INET, SOCK_STREAM | SOCK_NONBLOCK, 0 );
        if( serverfd == -1 ){
                perror("Could not create socket");
                exit(-1);
        }

        memset( &server, 0, sizeof(struct sockaddr_in) );

        server.sin_family = AF_INET;
        server.sin_port = htons( portnum );
        server.sin_addr.s_addr = INADDR_ANY;

        int ret_val = bind( serverfd, (const struct sockaddr*)&server, sizeof(struct sockaddr_in) );
        if( ret_val == -1 ){
                perror("Could not bind socket");
                exit(-1);
        }

        ret_val = listen( serverfd, backlog_size );
        if( ret_val == -1 ){
                perror("Call to listen failed");
                exit(-1);
        }

        //Main connection loop
        while(1){
                int clientAddressLength;
                int clientfd = accept4( serverfd, 
                                        (struct sockaddr*) &client, 
                                        &clientAddressLength,
                                        SOCK_NONBLOCK );

                if( clientfd == -1 ){
                        if( (errno == EAGAIN) || (errno == EWOULDBLOCK) ){
                        //Benign error case
                                printf("Checked for new connection, but no one was waiting\n");
                        } else {
                        //Serious error case
                                perror("Call to accept4 failed");
                                exit(-1);
                        }
                }

                if( clientfd >= 0 ){
                        printf("Accepted new client with socket %d\n", clientfd );
                }

                sleep(1);
        }

        return 0;
}


