#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>



#define TRIALS 10000

int main( int argc, char* argv[] ){

	int i;
	for( i = 0; i < TRIALS; i++ ){

		int ret = fork();
		if( ret == 0 ){
			return 0;
		}

	waitpid( ret, NULL, 0 );
	}


	return 0;
}


