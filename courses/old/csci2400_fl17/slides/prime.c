#include <stdio.h>

char isPrime (int n)
{
    if (n <= 0)
	return -1;		// error, undefined
    else if (n <= 3)
	return 1;		// 1, 2, and 3 are prime

    int i;

    // check if n is evenly divisible by any number between 2 ... n-1
    for (i = 2; i < n; i++)
    {
        if (n % i == 0)
	    return 0;		// false -- not prime
    }

    return 1;			// true -- prime
}

int main()
{
    int num;
    char result;

    printf( "Please enter a number: " );
    scanf( "%d", &num );

    result = isPrime (num);

    if (result == 1)
        printf( "%d is prime\n", num );
    else
        printf( "%d is not prime\n", num );
}

