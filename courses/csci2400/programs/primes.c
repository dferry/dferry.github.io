#include <stdio.h>


unsigned isPrime( unsigned target ){

	if( target <= 3 ){
		return 1; //true by definition
	}

	int i;

	for( i = 2; i < target; i++ ){
		if( (target % i) == 0 )
			return 0; //false
	}

	return 1; //true

	
}


int main( int argc, char* argv[] ){

	unsigned num, result;

	printf("Please enter a number: ");
	scanf("%u", &num);

	printf("We got: %u\n", num);

	result = isPrime(num);

	if( result == 1 ){
		printf("The input number is prime.\n");
	} else {
		printf("The input number is not prime.\n");
	}


	return 0;
}
