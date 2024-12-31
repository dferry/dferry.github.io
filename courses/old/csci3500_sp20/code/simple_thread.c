#include <pthread.h>
#include <stdint.h>
#include <stdio.h>

#define iters 1000000000

struct func_args{
	uint64_t start;
	uint64_t end;
};

uint64_t thread_sum;

void* thread_entry ( void* args ){

	struct func_args *myArgs;
	myArgs = (struct func_args*)args;

	printf("Start: %llu, End: %llu\n", myArgs->start, myArgs->end);

	uint64_t sum = 0;
	uint64_t i;
	for( i = myArgs->start; i < myArgs->end; i++){
		sum += i;
	}

	thread_sum = sum;

	return NULL;

}


int main( int argc, char* argv[] ){

	struct func_args args;
	args.start = iters/2;
	args.end   = iters;

	pthread_t tid;
	int ret;
	ret = pthread_create( &tid, NULL, thread_entry, (void*)(&args) ); 
        if( ret != 0 ){
		perror("Error creating thread");
		return -1;
	}	

	uint64_t sum = 0;
	uint64_t i;
	for( i = 0; i < iters/2; i++){
		sum += i;
	}

	pthread_join( tid, NULL );

	sum += thread_sum;

	printf("Sum: %llu\n", sum);

	return 0;
}
