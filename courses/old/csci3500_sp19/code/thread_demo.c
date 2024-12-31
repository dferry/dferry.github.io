#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

struct thread_args {
	int a;
	char b;
	char str[100];
};



void* thread_entry( void* args ){

	struct thread_args* input = (struct thread_args*) args;

	printf("Thread entry executes a: %d, b: %c\n", input->a, input->b);
	printf("Thread got string: '%s'\n", input->str);

	return NULL;
}


int main( int argc, char* argv[] ){


	/*
	//Just showing what a function pointer is
	void*(*thread_pointer)(void*)  = thread_entry;
	thread_pointer( 0x12345 );
	*/

	struct thread_args my_struct;
	my_struct.a = 42;
	my_struct.b = 'z';
	snprintf( my_struct.str, 100, "This is my input string %d", 1000 );

	pthread_t handle;

	pthread_create( &handle, NULL, thread_entry, &my_struct ); 

	printf("Waiting for thread\n");
	pthread_join( handle, NULL );
	printf("Joined with thread\n");

	return 0;
}



