#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <pthread.h>

void* thread_entry( void* args ){

	return NULL;
}



#define TRIALS 10000

int main( int argc, char* argv[] ){

	int i;
	for( i = 0; i < TRIALS; i++ ){

		pthread_t tid; 
		int ret	= pthread_create( &tid, NULL, thread_entry, NULL );

		pthread_join( tid, NULL );
	}



	return 0;
}


