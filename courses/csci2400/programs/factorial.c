#include <stdio.h>

unsigned factorialize( unsigned x ){

	unsigned accum = x;
	x--;

	while( x > 0 ){

		accum *= x;
		x--;
	}

	return accum;

}


int main( int argc, char* argv[] ){

	unsigned num, result;

	printf("Please enter a number: ");
	scanf("%u", &num);

	printf("We got: %u\n", num);

	result = factorialize( num );

	printf("Computed %u! to be %u\n", num, result);


	return 0;
}
