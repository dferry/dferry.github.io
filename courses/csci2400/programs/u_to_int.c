
#include <stdlib.h>
#include <stdio.h>

int main( int argc, char* argv[] ){

	unsigned char a = atoi( argv[1] );
	signed char *b;

	b = &a;

	printf("Value of B: %d\n", *b);

	return 0;
}
