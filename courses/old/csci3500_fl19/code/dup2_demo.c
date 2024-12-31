/* This program demonstrates the use of pipes and the dup2 system call to
 * implement pipelining between processes. The dup2 calls are used to replace
 * the standard input and output streams with the pipe that is created.
 *
 * How does this work? Recall that by default the standard input stream has
 * integer value 0 and the standard output stream has integer value 1. When
 * a program is written and compiled the read and write operations are
 * normally performed on file descriptors 0 and 1. We can replace the standard
 * stream that 0 and 1 refer to with our pipe, or any other input or output
 * stream. Then we can execute a program, such as sort, that we did not write,
 * and as long as that program writes to 0 and reads from 1 it will
 * automatically use our new streams instead of whatever its default behavior
 * is.
 *
 * Note that child1 prints out the values 5, 9, 7, 1, and 3, but the output
 * on the command line should be the sorted values 1, 3, 5, 7, and 9.
 *
 * */

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

	dup2( pipefd[1], STDOUT_FILENO );

	printf("5\n9\n7\n1\n3\n");

	close( pipefd[1] );
	exit(0);
}

child2 = fork();
if( child2 == 0 ){
	//Second child code	
	//Reader process
	close( pipefd[1] );//close write end

	dup2( pipefd[0], STDIN_FILENO );
	/*
	char buffer[bufferSize];
	fgets( buffer, bufferSize, stdin );
	
	printf("Got from pipe: %s\n", buffer );
	*/

	//Create the argv structure to execute the program "sort"
	char* cmd = "sort";
	char* args[2];
	args[0] = cmd;
	args[1] = NULL;

	execvp(cmd, args); 

	close( pipefd[1] );
	exit(0);
}

close( pipefd[0] );
close( pipefd[1] );

waitpid( child1, NULL, 0);
waitpid( child2, NULL, 0);

return 0;
}

