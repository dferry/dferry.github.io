#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>

#define BUFFERSIZE 1024

int main( int argc, char* argv[] ){

	pid_t child1, child2;

	int pipefd[2];
	int retval;

	retval = pipe( pipefd ); //pipefd[0] is read end, pipefd[1] is write end
	if( retval == -1 ){
		perror( "Could not create pipe\n");
		return -1;
	}

	child1 = fork();
	if( child1 == 0 ){ // Reading child process

		close( pipefd[1] );

		char buffer[ BUFFERSIZE ];

		FILE* inputStream = fdopen( pipefd[0], "r" );
		fgets( buffer, BUFFERSIZE, inputStream );

		printf("Read process got '%s' from pipe\n", buffer );
		fclose( inputStream );
		close( pipefd[0] );

		return 0;		
	}


	child2 = fork();
	if( child2 == 0 ){ //Writing child process

		close( pipefd[0] );

		FILE* outputStream = fdopen( pipefd[1], "w" );
	       	fprintf( outputStream, "This message is going in the pipe %d\n", 42);
		
		fclose( outputStream );
		close( pipefd[1] );

		return 0;
	}

	close( pipefd[0] );
	close( pipefd[1] );

	waitpid( child1, NULL, 0 );
	waitpid( child2, NULL, 0 );

	return 0;
}

