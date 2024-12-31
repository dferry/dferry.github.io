#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>


int main( int argc, char* argv[] ){

	int bufferSize = 1024;
	char buffer[ bufferSize ];

	fgets( buffer, bufferSize, stdin );
	strtok(buffer, "\n");

	printf("Got input '%s' from standard input\n", buffer );	
	
	char* cmd;
	char* myArgv[16]; //15 plus one for the null terminator

	myArgv[0] = strtok( buffer, " " );

	int i = 1;
	while( 1 ){

		myArgv[i] = strtok( NULL, " " );
		
		if( myArgv[i] == NULL ){
			break;
		}
		i++;
	}

	cmd = myArgv[0];

	pid_t ret = fork();

	if( ret == 0 ){ //Child

		execvp( cmd, myArgv );
		
		exit(0);
	}

	waitpid( ret, NULL, 0 );

	printf("The parent is done waiting for child\n");

	return 0;
}



