#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main( int argc, char* argv[] ){

	int pipefd[2];
	int retval = pipe( pipefd );
	if( retval == -1 ){
		perror("Could not create pipe");
		exit(-1);
	}

	pid_t child1, child2;

	//Create the first child
	child1 = fork();
	if( child1 == -1 ){
		perror("Could not create child1");
		exit(-1);
	}
	if( child1 == 0 ){ //Child process
		char buffer[1000];
		close( pipefd[1] );
		read( pipefd[0], buffer, 34 );
		buffer[34] = '\0';

		printf("Got the string '%s' from pipe\n", buffer );
	
		exit(0);
	}

	//Create the second child
        child2 = fork();
        if( child2 == -1 ){
                perror("Could not create child2");
                exit(-1);
        }
        if( child2 == 0 ){ //Child process
	//This is the writer process
	close( pipefd[0] );
	write( pipefd[1], "This is a message from the writer\n", 34);

		exit(0);
        }

	close( pipefd[0] );
	close( pipefd[1] );

	//Wait for both children to terminate before continuing
	waitpid( child1, NULL, 0 );
       	waitpid( child2, NULL, 0 );	




	return 0;
}
