//Demo of OS pipes between child processes
//
//David and Class, Sept 17, 2021

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>

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

		int ret = dup2( pipefd[1], STDOUT_FILENO );
		if( ret == -1 ){
			perror("could not dup2 write pipe");
			exit(-1);
		}


		char* cmd = "ls";
		char* myArgv[4]; //Three args plus null terminator
		myArgv[0] = cmd;
		myArgv[1] = "-l";
		myArgv[2] = "-h";
		myArgv[3] = NULL;
	
		//We are executing "ls -l -h"
		execvp( cmd, myArgv );

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

