#include <stdio.h>



int main( int argc, char* argv[] ){


int i;

#pragma omp parallel for
for( i = 0; i < 100; i++ ){

	printf("Thread %d executing iteration %d\n", omp_get_thread_num(),i);

}


}
