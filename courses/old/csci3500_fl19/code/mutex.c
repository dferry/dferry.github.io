#include <pthread.h>
#include <stdint.h>
#include <stdio.h>

#define iters 10000000
#define chunksize 1000

int sum = 0;
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;

void* adder ( void* args ){

	int i = 0,j;
	while ( i < iters ){

		pthread_mutex_lock(&m);	
		for( j = 0; j < chunksize; j++ )
			sum += 1;
		pthread_mutex_unlock(&m);

		i = i + chunksize;			
	}

	return NULL;
}


void* subtractor ( void* args ){

	int i = 0, j;
	while( i < iters){

		pthread_mutex_lock(&m);	
		for( j = 0; j < chunksize; j++ )
			sum -= 1;
		pthread_mutex_unlock(&m);	

		i = i + chunksize;
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
