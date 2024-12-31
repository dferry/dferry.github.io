#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

struct func_args{

	int a;
	float b;
	char c;
	int retval;

};


void* thread_entry( void* args ){

	/* passing a single value
	int* intptr;
	intptr = (int*) args;
	*/

	//Passing multiple values
	struct func_args* arg_ptr;
	arg_ptr = (struct func_args*) args;

	printf("Hello from a thread, with values %d, %f, %c\n", (*arg_ptr).a, arg_ptr->b, arg_ptr->c);

	arg_ptr->retval = arg_ptr->a * 20;

	return NULL;
}



int main( int argc, char* argv[] ){

	int N = 3;

	int ret;
	pthread_t tid[N];

	/* passing a single value to a thread
	int x,y,z;
	x = 10;
	y = 20;
	z = 30;

	pthread_create( &tid[0], NULL, thread_entry, &x );
	pthread_create( &tid[1], NULL, thread_entry, &y );
	pthread_create( &tid[2], NULL, thread_entry, &z );
	*/


	//Pass multiple values to a thread

	struct func_args thread_args[N];
	
	int i;
	for( i = 0; i < N; i++){

		thread_args[i].a = i;
		thread_args[i].b = i*10.0;
		thread_args[i].c = 'a' + i;

		pthread_create( &tid[i], NULL, thread_entry, &thread_args[i] );
	}

	for( i = 0; i < N; i++){
		pthread_join( tid[i], NULL );
		printf("Joined and thread returned %d\n", thread_args[i].retval );
	}
	//sleep(1);


	return 0;
}


