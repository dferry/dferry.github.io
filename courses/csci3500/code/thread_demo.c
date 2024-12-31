#include <stdio.h>
#include <pthread.h>

        struct thread_args {
                int a;
                double b;
                char buffer[100];
        };

int race = 75;

void* thread_entry( void* args ){

	printf("Hello from a thread\n");

	//printf("My value is %d\n", *(int*)args);

	struct thread_args* argptr = args;

	//*argptr.a

	printf("My value A is %d\n", (*argptr).a );
	printf("My value B is %0.2f\n", argptr->b ); 
	printf("The message we got was: '%s'\n", argptr->buffer );

	printf("The value of race is %d\n", race );

	return NULL;
}


int main( int argc, char* argv[] ){

	//pthread_t* tid; //This is wrong, do not do
	pthread_t tid; 

	struct thread_args arguments;
	arguments.a = 50;
	arguments.b = 3.14;
	snprintf( &arguments.buffer, 100, "A message for my thread %d\n", 101 );

	int x = 25;

	pthread_create( &tid, NULL, thread_entry, &arguments );

	printf("Hello from main\n");
	race = 150;

	void* retval;
	pthread_join( tid, &retval ); 

	return 0;
}
