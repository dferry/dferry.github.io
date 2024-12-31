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

	//Step 2: Parent forks two children
	pid_t process1 = fork();
	if( process1 == 0 ){//Child 1 process

		printf("The first child started\n");

		//Step 3a: First child redirects stdout into pipefd[1]
		int ret = dup2( pipefd[1], STDOUT_FILENO );
		if( ret == -1 ){
			perror("Could not redirect stdout to pipefd[1]");
			return -1;
		}

		//It is REALLY important to ALWAYS close every end of any pipe
		// that a process is not going to use
		close( pipefd[0] );

		//Now everything written normally will go into our pipe
		printf("My favorite number is %d\n", 42 );
		printf("We're using streams\n");
		printf("Horray\n");

		exit(0);
	}

	pid_t process2 = fork();
	if( process2 == 0 ){ //Child 2 process
	
		printf("The second child started\n");

		//Step 3b: Second child redirects stdin from pipefd[0]
		int ret = dup2( pipefd[0], STDIN_FILENO );
		if( ret == -1 ){
			perror("Could not redirect stdin from pipefd[0]");
			return -1;
		}

		//It is REALLY important to ALWAYS close every end of any pipe
		// that a process is not going to use
		close( pipefd[1] );

		//Now everything read from stdin comes from our pipe
		char buffer[256];
		while(1) {
			char* ret = fgets( buffer, 256, stdin );
			if( ret == NULL ){
				break;
			}
			printf("Got from buffer: '%s'\n", buffer );
		}

		return 0;		
	}

	//It is REALLY important to ALWAYS close every end of any pipe
	// that a process is not using
	close( pipefd[0] ); //Closes in the parent
	close( pipefd[1] ); //Closes in the parent

	//Step 4: Parent waits for both children
	printf("The parent is about to wait\n");
	waitpid( process1, NULL, 0 );
	waitpid( process2, NULL, 0 );

	return 0;
}

