//David Ferry
//February 6, 2017
//Benchmark how long it takes to create a set of processes

#include <unistd.h>
#include <stdio.h>
#include <time.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>


//Experiment parameters
const int num_trials = 10000;
clockid_t myClock = CLOCK_MONOTONIC;
#define ns_in_sec  1000000000
#define ns_in_msec 1000000

struct timespec start, end;

int main( int argc, char* argv[] ){
	
	int ret;

	ret = clock_gettime(myClock, &start);
	if( ret == -1 ){
		perror("Error getting start time");
		exit(-1);
	}

	int i;
	pid_t pid;
	for( i = 0; i < num_trials; i++ ){
	
		pid = fork();
		if( pid == -1 ){
			fprintf(stderr,"Error creating process %d: %s\n", i, strerror(errno));
			exit(-1);
		}
		
		if( pid == 0 ){//Return immediately
			return 0;
		} else {
			waitpid(pid, NULL, 0);
		}

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

