#include <stdio.h>
#include <stdlib.h>

extern void* mymalloc(size_t size);
extern void  myfree(void *ptr);

#define array_size 500
#define short_array 100

int main( int argc, char* argv[] ){

	//Create and destroy two arrays twice
	int *array = (int*) malloc( sizeof(int) * array_size );
	int *array2 = (int*) malloc( sizeof(int) * array_size );
	int i;

	printf("Array 1 pointer: %p\n", array);
	printf("Array 2 pointer: %p\n", array2);

	for(i = 0; i < array_size; i++){
		array[i] = i;
	}

	int dist = (int)((void*)array2 - (void*)array);
	printf("Distance between 1 and 2: %d (expected about 400)\n", dist);

	free( array );
	free( array2 );

	//Re allocate those two arrays
	array = (int*) malloc( sizeof(int) * short_array );
	array2 = (int*) malloc( sizeof(int) * short_array );

	printf("Array 1 pointer: %p\n", array);
	printf("Array 2 pointer: %p\n", array2);

	for(i = 0; i < short_array; i++){
		array[i] = i;
	}

	dist = (int)((void*)array2 - (void*)array);
	printf("Distance between 1 and 2: %d (expected about 1000)\n", dist);

	free( array );
	free( array2 );

	array =  malloc( 10000 );
	array2 = malloc( 10000 );

	printf("Array 1 pointer: %p\n", array);
	printf("Array 2 pointer: %p\n", array2);
	
	dist = (int)((void*)array2 - (void*)array);
	printf("Distance between 1 and 2: %d (expected about  12288)\n", dist);

	free( array );
	free( array2 );

	return 0;
}

