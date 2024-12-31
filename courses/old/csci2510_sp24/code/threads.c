#include <pthread.h>
#include <stdio.h>


struct args {
	int a;
	int b;
	float c;
	char str[100];
};

int global = 0;


int max( int x, int y ){

	if ( x > y ){
		return x;
	} else {
		return y;
	}
}

void* thread_entry1 ( void* args ){

	int argument = *((int*)args);

	printf("Hello from thread 1\n");
	printf("My value is %d\n", argument);

	for( int i = 0; i < 10000000; i++){
		global ++;
	}

	return NULL;
}

void* thread_entry2 ( void* args ){
	printf("Hello from thread 2\n");

	struct args* thread_args = args;
	int a = thread_args->a;
	int b = thread_args->b;
	printf("The max of %d and %d is %d\n", a, b, max(a,b));
	printf("Thread 2 string is: %s\n", thread_args->str);

	for( int i = 0; i < 10000000; i++){
		global ++;
	}

	return NULL;
}




int main(){

	pthread_t pid, pid2; 
	//void*(*thread_to_run)(void*) = thread_entry1;

	int x = 42;

	struct args my_args; 
	my_args.a = 42;
	my_args.b = 101;
	my_args.c = 98.6;
	snprintf( my_args.str, 100, "Passing arguments is hard.\n" );	

	//Create a new thread
	pthread_create( &pid, NULL, thread_entry1, &x ); 
	pthread_create( &pid2, NULL, thread_entry2, &my_args ); 

	pthread_join( pid, NULL );
	pthread_join( pid2, NULL );

	printf("My global variable is: %d\n", global );
}




