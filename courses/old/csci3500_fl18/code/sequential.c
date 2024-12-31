#include <pthread.h>
#include <stdint.h>
#include <stdio.h>

#define iters 1000000000

int main( int argc, char* argv[] ){

	uint64_t sum = 0;
	uint64_t i;
	for( i = 0; i < iters; i++){
		sum += i;
	}

        printf("Sum: %llu\n", sum);


	return 0;
}
