#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

int main( int argc, char* argv[] ){

	int X = 10;
	pid_t retval;

	retval = fork();
	if( retval == -1 ){
		perror("Could not fork");
		exit(-1);
	}	

	if( retval == 0 ){
		//The child code
		X = 25;
		printf("Value X in child is %d\n", X);

		char* cmd = "ls";
		char* myArgv[3];
	        myArgv[0] = "ls";
		myArgv[1] = "-l";
		myArgv[2] = NULL;

		int value = execvp( cmd, myArgv );
		if( value == -1 ){
			perror("Could not execvp() new program");
			exit(-1);
		}

		printf("This statement should never print\n");

		exit(-1); //Generally don't want the child to escape
	}

	//Wait for the child process to finish
	waitpid( retval, NULL, 0 );

	//The parent code executes here
	printf("Value X in parent is %d\n", X);

	return 0;
}
