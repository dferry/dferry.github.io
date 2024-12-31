       #include <sys/types.h>
       #include <unistd.h>
       #include <stdio.h>
       #include <sys/wait.h>


int main( int argc, char* argv[] ){

	int x = 5;
	int y = 10;

	int pipefd[2];
	int ret = pipe( pipefd );
	

	ret = fork();

	if( ret == 0 ){ // This is the child
		printf("Child got x: %d\n", x);
		write( pipefd[1], "Hello", 6 );

		char* arg1 = "ls";
		char* arg2 = "-l";
		char* arg3 = NULL;
		char* newArgV [3];
		newArgV[0] = arg1;
		newArgV[1] = arg2;
		newArgV[2] = arg3;

		execvp( "ls",  newArgV);
	}

	if( ret != 0 ){ // This is the parent
		waitpid( ret, NULL, 0 );
		printf("Parent got x: %d\n", x);

		char buffer[6];
		read( pipefd[0], buffer, 6 );

		printf("Got '%s' from child\n", buffer);
	}

	return 0;
}
