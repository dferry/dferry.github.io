#include <stdio.h>


unsigned isPrime( unsigned long long  target ){

	if( target <= 3 ){
		return 1; //true by definition
	}

	if( (target % 2) == 0 ){
		return 0; //false
	}

	int i;

	for( i = 3; i < target; i += 2 ){
		if( (target % i) == 0 )
			return 0; //false
	}

	return 1; //true

	
}


int main( int argc, char* argv[] ){

	unsigned long long num;
	unsigned result;

	printf("Please enter a number: ");
	scanf("%llu", &num);

	printf("We got: %llu\n", num);

	result = isPrime(num);

	if( result == 1 ){
		printf("The input number is prime.\n");
	} else {
		printf("The input number is not prime.\n");
	}


	return 0;
}
