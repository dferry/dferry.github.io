#include <pthread.h>
#include <stdio.h>

#define N 100000000

int x = 0;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER; 


void* adder( void* args ){

	int i;
	for( i = 0; i < N; i++ ){
	pthread_mutex_lock( &mutex );
	x++;
	pthread_mutex_unlock( &mutex );
	}
}

void* subtractor( void* args ){

	int i;
	for( i = 0; i < N; i++ ){
	pthread_mutex_lock( &mutex );
	x--;
	pthread_mutex_unlock( &mutex );
	}

}

int main( int argc, char* argv[] ){

	pthread_t tid1, tid2;

	pthread_create( &tid1, NULL, adder, NULL );
	pthread_create( &tid2, NULL, subtractor, NULL );

	pthread_join( tid1, NULL );
	pthread_join( tid2, NULL );

	printf("The final value of x: %d\n", x );
}


