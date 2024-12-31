/* This file demonstrates the use of pipes to communicate between two sibling
 * processes. Remember that pipefd[0] is the read end of the created pipe and
 * pipefd[1] is the write end of the created pipe. */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

#define bufferSize 1024

int main( int argc, char* argv[] ){

//Create a pipe
int pipefd[2];
pipe( pipefd );


int child1;
int child2;

child1 = fork();
if( child1 == 0 ){
	//First child code
	//Writer process
	close( pipefd[0] );//close read end

	FILE* pipeW = fdopen( pipefd[1], "w" );
	fprintf( pipeW, "My first pipe: %d", 42);

	fclose( pipeW );
	close( pipefd[1] );
	exit(0);
}

child2 = fork();
if( child2 == 0 ){
	//Second child code	
	//Reader process
	close( pipefd[1] );//close write end

	FILE* pipeR = fdopen( pipefd[0], "r" );
	char buffer[bufferSize];

	fgets( buffer, bufferSize, pipeR );
	
	printf("Got from pipe: %s\n", buffer );

	fclose( pipeR );
	close( pipefd[1] );
	exit(0);
}

close( pipefd[0] );
close( pipefd[1] );

waitpid( child1, NULL, 0);
waitpid( child2, NULL, 0);

return 0;
}

