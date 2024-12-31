#include <stdio.h>
#include <omp.h>

#define maxSize 65536
#define matSize 5000


int main( int argc, char* argv[] ){

	unsigned linearSize = matSize*matSize;

	unsigned matrixA [linearSize];
	unsigned matrixB [linearSize];
	unsigned result [linearSize];
	
	
	unsigned i;
	#pragma omp parallel for
	for( i = 0; i < linearSize; i++){
		matrixA[i] = rand()%10;
		matrixB[i] = rand()%10;
	}

	unsigned row;
	unsigned col;
	#pragma omp parallel for
	for( row = 0; row < matSize; row++ ){
		for( col = 0; col < matSize; col++ ){
			result[ row*matSize + col ] = 0;
			for( i = 0; i < matSize; i++ ){
				result[ row*matSize + col ] += matrixA[row*matSize + col]*matrixB[row*matSize + col];
			}
		}
	}

	
	return 0;
}
