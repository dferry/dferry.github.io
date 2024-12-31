#include <stdio.h>


unsigned fib( unsigned x ){

	if( x == 1 ){
		return 1;
	} else if( x == 0 ){
		return 0;
	}

	return fib(x - 1) + fib(x - 2);
}



int main( int argc, char* argv[] ){

	unsigned num, result;

	printf("Please enter a number: ");
	scanf("%u", &num);

	printf("We got: %u\n", num);

	result = fib(num);

	printf("Computed fib(%u) to be %u\n", num, result);


	return 0;
}
