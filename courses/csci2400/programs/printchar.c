#include <stdio.h>
#include <stdlib.h>

void printbits( unsigned char c ){

	//Print the 8th bit
	if( (c & 0x80) )
		putchar('1');
	else
		putchar('0');

	//Print the 7th bit
	if( (c & 0x40) )
		putchar('1');
	else
		putchar('0');

	//Print the 6th bit
	if( (c & 0x20) )
		putchar('1');
	else
		putchar('0');

	//Print the 5th bit
	if( (c & 0x10) )
		putchar('1');
	else
		putchar('0');

	//Print the 4th bit
	if( (c & 0x8) )
		putchar('1');
	else
		putchar('0');

	//Print the 3rd bit
	if( (c & 0x4) )
		putchar('1');
	else
		putchar('0');

	//Print the 2nd bit
	if( (c & 0x2) )
		putchar('1');
	else
		putchar('0');

	//Print the 1st bit
	if( (c & 0x1) )
		putchar('1');
	else
		putchar('0');


	putchar('\n');
}


int main( int argc, char* argv[] ){

	unsigned char c = atoi(argv[1]);

	printbits(c);

	return 0;
}
