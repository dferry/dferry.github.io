#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

int x = 5;

struct args{
	int arg1;
	int arg2;
	char arg3;
	float arg4;
};

void* thread_entry( void* input ){

	printf("Created a new thread, value: %d\n", x);

	struct args* input_ptr = (struct args*)input;

	printf("Argument 1: %d\n", input_ptr->arg1 );
	printf("Argument 2: %d\n", (*input_ptr).arg2 );

	return NULL;
}

void* factory(){

	struct args newArgs;

}

int main( int argc, char* argv[] ){

	pthread_t handle;
	void* returned;

	int y = 20;

	struct args myArgs;
	myArgs.arg1 = 7;
	myArgs.arg2 = 14;
	myArgs.arg3 = 'w';
	myArgs.arg4 = 3.14;

	printf("Before calling pthread_create()\n");

	pthread_create( &handle, NULL, thread_entry, (void*)&myArgs );
	
	printf("After calling pthread_create()\n");

	pthread_join( handle, &returned );


	x = 15;

	return 0;
}
