//Demo of using pipes between OS processes

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main( int argc, char* argv[] ){

	//Create the pipes, pipefd[0] is the read end, pipefd[1] is the write end
	int pipefd[2];
	pipe( pipefd );

	pid_t child1 = fork();
	//This child is the reading process
	if( child1 == 0 ){ //This is child1 code

		//Any child should close any file descriptor it does not need a copy of
		close( pipefd[1] );

		//This child opens the read-side of the pipe to read from:
		//Your Lab2 does not need to do this- this is just so we can
		// use fgets() on this side of the pipe.
		FILE* readSide = fdopen( pipefd[0], "r" );

		int bufferSize = 1024;
		char buffer[bufferSize];

		//Read from the pipe until we get end-of-file (fgets returns NULL)
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

		//Any child should close any file descriptor it does not need
		close( pipefd[0] );

		//This child opens the write-side of the pipe to write to:
		//Your Lab2 does not need to do this- this is just so we can
		//use fprintf() on this side of the pipe.
		FILE* readSide = fdopen( pipefd[0], "r" );

		fprintf( writeSide, "Systems Programming!\n" );
		fprintf( writeSide, "SLU Billikens!\n" );
		fprintf( writeSide, "C is a great language!\n" );

		return 0;
	}

	//Once the parent has created both children, it does not need either end
	//of the pipe, so close both file descriptors.
	close( pipefd[0] );
	close( pipefd[1] );	

	//Wait for the read-side to finish. The write-read sequencing between the
	//two children guarantees that child1 (the reader) will finish after
	//child2 (the writer)
	waitpid( child1, NULL, 0 );

	return 0;
}

