#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

struct thread_input {
	int x;
	int y;
	double z;
	char str[100];
	int ret_val;
};

void* thread_start( void* args ){

	printf("Hello from the thread\n");

	//Unwrapping the arguments
	struct thread_input* inputs = (struct thread_input*) args;

	printf("Got value x from main: %d\n", (*inputs).x);
	printf("Got value y from main: %d\n", inputs->y);
	printf("Got value z from main: %0.3f\n", inputs->z);
	printf("Got string from main: %s\n", inputs->str);

	//WARNING- this does not work, variable goes out of scope
	//int ret_val = 12345;
	
	//Solution 1: Use our struct to return values
	inputs->ret_val = 12345;

	//SOlution 2: Use malloc to create a variable of extended lifetime
	int* ret_ptr = malloc( sizeof(int) );
	*ret_ptr = 12345;

	return ret_ptr;
}

int main(){

	int a = 5;
	struct thread_input inputs;

	//Wrapping multiple inputs into a struct
	inputs.x = 42;
	inputs.y = 100;
	inputs.z = 3.14159;
	snprintf(inputs.str, 100, "Hello from main\n");

	pthread_t tid;
	pthread_create( &tid, NULL, thread_start, &inputs ); 

	void* thread_return_value;
	pthread_join( tid, &thread_return_value );
	int* return_as_int = thread_return_value;

	printf("Got integer value from join: %d\n", *return_as_int );

	printf("Got integer value from struct: %d\n", inputs.ret_val );

	return 0;
}
