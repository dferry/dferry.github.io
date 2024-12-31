#include <stdio.h>
#include <omp.h>


int main( int argc, char* argv[] ){

	int i;

	cilk for( i = 0; i < 100; i++ ){
		printf("Thread executing loop iteration %d\n", i);
	}
	
	return 0;
}
