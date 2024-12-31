
#include <stdlib.h>
#include <stdio.h>

int main( int argc, char* argv[] ){

	signed char a = atoi( argv[1] );
	unsigned char *b;

	b = &a;

	printf("Value of B: %u\n", *b);

	return 0;
}
