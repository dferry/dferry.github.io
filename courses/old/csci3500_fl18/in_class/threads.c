#include <pthread.h>
#include <stdio.h>

void* thread_1_entry( void* args ){


	printf("Hello, world! From thread 1.\n"); 

	return NULL;
}

struct my_args {

	int x;
	double y;
	char buf [20];
};

void* thread_2_entry( void* args ){

	struct my_args* input_args = (struct my_args*) args;

	printf("Thread 2 got %d for x, %0.3f for y, '%s' for buf\n",
	input_args->x, 
	input_args->y, 
	input_args->buf);

	return NULL;
}


int main( int argc, char* argv[] ){

	pthread_t tid;	
	pthread_t tid2;

	struct my_args args_for_func;

	args_for_func.x = 10;
	args_for_func.y = 25.5;
	snprintf( args_for_func.buf, 20, "Thread 2 Hello"); 


	pthread_create( &tid, NULL, thread_1_entry, NULL );
	pthread_create( &tid2, NULL, thread_2_entry, &args_for_func );

	printf("Timing is indeterminate\n");

	pthread_join( tid, NULL ); 
	pthread_join( tid2, NULL );

	printf("This always prints last of all\n");

	return;
}
