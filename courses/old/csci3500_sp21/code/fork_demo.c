#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main( int argc, char* argv[] ){

	int x = 10;

	int ret = fork();
	if( ret == 0 ){ //In the child
		
		printf("First child has x=%d\n", x);
		x = 25;
		printf("After child has x=%d\n", x);

		char* cmd = "ls";
		char* myArgv[4];
		myArgv[0] = "ls";
		myArgv[1] = "-l";
		myArgv[2] = "-a";
		myArgv[3] = NULL;

		int value = execvp( cmd, myArgv );
		if( value == -1 ){
			perror("Could not exec in child");
		}

		exit(-1);
	}

	//In the parent
	waitpid( ret, NULL, 0 );
	printf("Hello from parent, x=%d\n",x);

	return 0;
}
