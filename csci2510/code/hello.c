#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

int main() {

	printf("Hello, world!\n");

	//This is a comment in C
	
	/*
	 * This is a block comment
	 *
	 * */

	/* This is a single line comment */

	//Variables:
	
	//"Common" Types
	char a = 15; // 1 byte signed variable
	short b = 10000; // "probably" a 2 byte signed variable
	int c = 2000000000; // "probably" a 4 byte signed variable

	//Standard Size Types
	int8_t d = 21; //fixed 1 byte type
	int16_t e = 20000; //fixed 2 byte type
	int32_t f = 1000000000; //fixed 4 byte type

	//Types are explicitly signed or not
	signed int g = -42;
	unsigned int h = 404;
	int i = 3001; // This is signed by default

	//More variable types...
	
	// Booleans? 
	
	//Original C - does not include booleans
	int j = 0; //Integer zero values are false
	int k = 12345; //Integer nonzero values are true

	//Included with stdbool
	bool m = true;
	bool n = false;

	//Character data
	char o = 'O'; //Note the single ticks
	char p = 79; //These two variables are identical right now

	//We can create static strings easily
	printf("This is a static string.\n");
	char* q = "This is another static string.\n";
	printf(q);

	//Formatted output
	//Big function: printf()
	printf("This is variable a: %d\n This is variable b: %d\n", a, b);

	unsigned char r = 42;
	unsigned char s = 200;

	printf("Char R as unsigned: %hhu\n", r);
	printf("Char R as signed: %hhd\n", r);
	printf("Char S as unsigned: %hhu\n", s);
	printf("Char S as signed: %hhd\n", s);


	//Floating point data types
	float x = 10.5;
	double y = 3.14159;

	float less_precise = 1234567890.1234567890;	
	double more_precise = 1234567890.1234567890;	

	//Printing floating point numbers
	//Just print as a decimal point number
	printf("float number: %0.9f\n", less_precise ); 
	printf("float number: %0.9f\n", more_precise ); 

	float less_precise2 = 0.12345678901234567890;	
	double more_precise2 = 0.12345678901234567890;	

	//Printing floating point numbers
	//Just print as a decimal point number
	printf("float number: %0.18f\n", less_precise2 ); 
	printf("float number: %0.18f\n", more_precise2 ); 


	return 0;
}
