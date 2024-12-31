#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>

int main( int argc, char* argv[] ){

	int x = 10;

	pid_t ret = fork();

	if( ret == 0 ){ //Child

		sleep(1);

		x = 20;
		printf("Child has value %d\n", x );
		exit(0);
	}

	waitpid( ret, NULL, 0 );

	printf("Parent has value %d\n", x );


	return 0;
}



