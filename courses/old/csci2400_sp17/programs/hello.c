#include <stdio.h>

int main( int argc, char* argv[] ){

	int x = 5;
	double y = 10.1;
	char* str = "This is a string!\n";

	printf("Hello, world!\n");
	printf("Value x: %d   Value y: %0.3f\n", x, y );
	printf("The string: %s\n", str);

	return 0;
}
