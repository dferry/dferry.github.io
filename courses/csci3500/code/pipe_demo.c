//Demo of OS pipes between child processes
//
//David and Class, Sept 17, 2021

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main( int argc, char* argv[] ){

	int pipefd[2];
	pipe( pipefd );

	FILE* readSide = fdopen( pipefd[0], "r" );
	FILE* writeSide = fdopen( pipefd[1], "w" );

	pid_t child1 = fork();
	//This child is the reading process
	if( child1 == 0 ){ //This is child1 code

		fclose( writeSide );
		close( pipefd[1] );

		int bufferSize = 1024;
		char buffer[bufferSize];

		char* retVal = fgets( buffer, bufferSize, readSide );
		while( retVal != NULL ){
			printf("Got from pipe: '%s'\n", buffer);
			retVal = fgets( buffer, bufferSize, readSide );
		}
		return 0;
	}

	pid_t child2 = fork();
	//This child is the writing process
	if( child2 == 0 ){ //This is child2 code

		fclose( readSide );
		close( pipefd[0] );

		fprintf( writeSide, "Operating Systems Fall 21\n" );
		fprintf( writeSide, "SLU Billikens\n" );
		fprintf( writeSide, "C is a great language!\n" );

		return 0;
	}

	fclose( readSide );
	close( pipefd[0] );
	fclose( writeSide );
	close( pipefd[1] );	

	waitpid( child1, NULL, 0 );
	waitpid( child2, NULL, 0 );

	return 0;
}

