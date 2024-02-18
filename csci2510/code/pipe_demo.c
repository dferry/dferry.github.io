#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {

	//Step 1: Make the pipe
	int pipefd[2];
	int ret = pipe( pipefd );
	if( ret == -1 ){
		perror("Could not open pipe");
		return -1;
	}

	pid_t process1 = fork();
	if( process1 == 0 ){//Child 1 process

		printf("The first child started\n");

		//Example using syscalls
		//write( pipefd[1], "Hello from process 1\n", 21 );

		//Example using FILE* streams
		FILE* outstream = fdopen( pipefd[1], "w" );

		fprintf(outstream, "My favorite number is %d\n", 42 );
		fprintf(outstream, "We're using streams\n");
		fprintf(outstream, "Horray\n");

		exit(0);
	}

	pid_t process2 = fork();
	if( process2 == 0 ){ //Child 2 process
	
		printf("The second child started\n");

		//Reading from pipe with syscalls
		//char buffer[256]; 
		//int bytes_read = read( pipefd[0], buffer, 256 );
		//buffer[ bytes_read ] = 0;
		
		//Reading from pipe with fgets
		char buffer[256];

		FILE* instream = fdopen( pipefd[0], "r" );
		fgets( buffer, 256, instream );

		printf("Got from buffer: '%s'\n", buffer );

		return 0;		
	}

	printf("The parent is about to wait\n");
	waitpid( process1, NULL, 0 );
	waitpid( process2, NULL, 0 );

	return 0;
}

