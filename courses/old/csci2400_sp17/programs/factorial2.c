#include <stdio.h>

unsigned factorialize( unsigned x ){

	unsigned accum = 1;

	int i;

	for( i = 1; i <= x; i++){
		accum *= i;
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
