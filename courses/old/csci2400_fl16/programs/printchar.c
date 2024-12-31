#include <stdio.h>

void printbits( char c ){

	printf("%d", (c & 0x80) ? 1 : 0);
	printf("%d", (c & 0x40) ? 1 : 0);
	printf("%d", (c & 0x20) ? 1 : 0);
	printf("%d", (c & 0x10) ? 1 : 0);
	printf("%d", (c & 0x8) ? 1 : 0);
	printf("%d", (c & 0x4) ? 1 : 0);
	printf("%d", (c & 0x2) ? 1 : 0);
	printf("%d", (c & 0x1) ? 1 : 0);
	printf("\n");

}


int main( int argc, char* argv[] ){

	char c = 42;
	printbits(c);

	printbits(0xF);
	c = c & 0xF;
	
	printf("Value after 42 & 0xF: %d\n", c);
	printbits(c);

	return 0;
}
