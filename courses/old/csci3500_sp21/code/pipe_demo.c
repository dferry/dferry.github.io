#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

int main( int argc, char* argv[]){

	//Create a pipe for child 1 to send to child 2
	int pipefd[2];
	int retval = pipe( pipefd );
	if( retval == -1 ){
		perror( "Could not create pipe" );
		return -1;
	}
	//On return, pipefd[0] is read end
	//On return, pipefd[1] is write end
	int writefd = pipefd[1];
	int readfd = pipefd[0];


	//Child 1 will write data to pipe
	int ret = fork();
	if( ret == 0 ){ //We are in child 1

		//We don't need the read end of the pipe in this child
		close( readfd );

		write( writefd, "Hello from child 1\n", 20 );
	
		exit(0);
	}

	//Child 2 will read data from pipe
	int ret2 = fork();
	if( ret2 == 0 ){ //We are in child 2

		//We don't need the write end of the pipe in this child
		close( writefd );

		FILE* readFile = fdopen( readfd, "r" );
		char buffer [ 1024 ];
		fgets( buffer, 1024, readFile );

		printf("Got '%s' from child 1\n", buffer);

		exit(0);
	}

	//We should always close file descriptors before waitpid()
	close( readfd );
	close( writefd );

	waitpid( ret, NULL, 0 ); //Wait on child 1
	waitpid( ret2, NULL, 0 ); //Wait on child 2

	return 0;
}
