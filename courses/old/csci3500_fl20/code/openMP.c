#include <stdio.h>
#include <omp.h>


int main( int argc, char* argv[] ){

	int i;

	#pragma omp parallel for
	for( i = 0; i < 100; i++ ){
		printf("Thread %d executing loop iteration %d\n", omp_get_thread_num(), i);
	}
	
	return 0;
}
