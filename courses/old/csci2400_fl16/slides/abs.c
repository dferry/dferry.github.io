#include <stdio.h>

int a = -25;

int abs (int x) 
{ 
    if (x < 0)
	return -x;

    return x; 
} 

int main ()
{
    int result = abs (a);

    printf ("result is %d\n", result);
}

