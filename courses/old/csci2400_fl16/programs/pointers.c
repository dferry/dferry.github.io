#include <stdio.h>

void dbl( int x ){

	x = x * 2;

	printf("Local address of x in dbl(): %p\n", &x);
	printf("The value of doubled x: %d\n", x);
}


void dbl_by_ref( int *x ){

	*x = *x * 2;

	printf("Local address of x in dbl_by_ref(): %p\n", x);
	printf("The value of doubled by ref x: %d\n", *x);
}


int main( int argc, char* argv[] ){


int x = 1000;

printf("Print by value: %d\n", x);
printf("Print the reference: %p\n", &x);

int *ptr = &x;

printf("Print the pointer: %p\n", ptr);
printf("Print the value by reference: %d\n", *ptr);

printf("Calling dbl()\n");
dbl(x);
printf("Value of x after dbl(): %d\n", x);

printf("\nCalling dbl_by_ref()\n");
dbl_by_ref(&x);
printf("Value of x after dbl_by_ref(): %d\n", x);

}
