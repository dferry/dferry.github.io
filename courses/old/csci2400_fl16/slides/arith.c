#include <stdio.h>

int a = 50000;
int b = 150000;
int c = 50;

int arith(int x, 
	  int y, 
	  int z)
{ 
    int t1 = x+y; 
    int t2 = z*48; 
    int t3 = t1 & 0xFFFF; 
    int t4 = t2 * t3; 
    return t4; 
} 

int main ()
{
    int x = arith (a, b, c);
    printf ("result is %d\n", x);
}

