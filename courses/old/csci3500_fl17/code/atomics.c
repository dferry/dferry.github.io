#include <pthread.h>
#include <stdint.h>
#include <stdio.h>

#define iters 10000000

int sum = 0;

void* adder ( void* args ){

	int i;
	for( i = 0; i < iters; i++){
		__sync_add_and_fetch(&sum,1);
	}

	return NULL;
}


void* subtractor ( void* args ){

	int i;
	for( i = 0; i < iters; i++){
		__sync_add_and_fetch(&sum,-1);
	}

	return NULL;
}



int main( int argc, char* argv[] ){

	pthread_t tid1, tid2;
	int ret;
	ret = pthread_create( &tid1, NULL, adder, NULL ); 
        if( ret != 0 ){
		perror("Error creating thread 1");
		return -1;
	}	
	ret = pthread_create( &tid2, NULL, subtractor, NULL ); 
        if( ret != 0 ){
		perror("Error creating thread 2");
		return -1;
	}	


	pthread_join( tid1, NULL );
	pthread_join( tid2, NULL );

	printf("Final sum: %u\n", sum);

	return 0;
}
