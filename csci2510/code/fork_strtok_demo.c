
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

#define bufferSize 255

int main( ) {

	char buffer [bufferSize];
	fgets( buffer, bufferSize, stdin );

	printf("Got input '%s'\n", buffer );
	
	int length = strlen( buffer );
	printf("String length is %d\n", length );

	buffer[ length - 1] = 0;
	printf("Our input is now '%s'\n", buffer );
	length = strlen( buffer );
	printf("String length is now %d\n", length );

	//Token parsing
	char* command;
	char* myargv[16];

	command = strtok( buffer, " " );
	printf("Got command '%s'\n", command );
	
	myargv[0] = command;

	int i = 1;
	while(1){
		char* result = strtok( NULL, " ");
		if( result == NULL ){
			break;
		}
		myargv[i] = result;
		i++;
	}

	myargv[i] = NULL;

	i = 0;
	while(myargv[i] != NULL){
		printf("Position %d has value: '%s'\n", i, myargv[i] );
		i++;
	}	


	//Fork and exec program we've parsed
	pid_t fork_return = fork();

	if( fork_return == 0 ){ //The child executes this	
		int exec_return = execvp( command, myargv );	
		if( exec_return < 0 ){
			perror("Could not exec");
		}
		return -1;
	}

	waitpid( fork_return, NULL, 0 );
	printf("Parent stopped waiting\n");

	return 0;
}
