//David Ferry
//February 6, 2017
//Benchmark how long it takes to create a set of threads

#include <unistd.h>
#include <stdio.h>
#include <time.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>

//Experiment parameters
const int num_trials = 10000;
clockid_t myClock = CLOCK_MONOTONIC;
#define ns_in_sec  1000000000
#define ns_in_msec 1000000

struct timespec start, end;

//New threads execute this function
//For timing purposes this function is purposefully empty
void* thread_entry( void* args ){

	return NULL;
}

int main( int argc, char* argv[] ){
	
	int ret;

	ret = clock_gettime(myClock, &start);
	if( ret == -1 ){
		perror("Error getting start time");
		exit(-1);
	}

	int i;
	pthread_t tid;
	for( i = 0; i < num_trials; i++ ){
	
		ret = pthread_create( &tid, NULL, thread_entry, NULL );
		if( ret != 0 ){
			fprintf(stderr,"Error creating thread %d: %s\n", i, strerror(errno));
			exit(-1);
		}
		
		pthread_join(tid, NULL);
	}

	ret = clock_gettime(myClock, &end);
	if( ret == -1 ){
		perror("Error getting start time");
		exit(-1);
	}

	//Compute the total time in nanoseconds
	//CLOCK_MONOTONIC guarantees that end is later than start
	int seconds = end.tv_sec - start.tv_sec;
	int64_t time_in_ns = end.tv_nsec - start.tv_nsec;
	if( time_in_ns < 0 ){
		time_in_ns += ns_in_sec;
		seconds -= 1;
	}
	time_in_ns += seconds * ns_in_sec;

	printf("Time to create %d processes: %0.3f milliseconds\n", 
		num_trials, (double)time_in_ns/(double)ns_in_msec);

	return 0;
}

