#include <stdio.h>

char isPrime (unsigned long long int n)
{
    if (n <= 0)
	return -1;		// error, undefined
    else if (n <= 3)
	return 1;		// 1, 2, and 3 are prime

    // eliminate even numbers larger than 2
    if (n % 2 == 0)
        return 0;

    unsigned long long int i;

    // check if n is evenly divisible by any ODD number between 3 ... sqrt(n)
    for (i = 3; i*i <= n; i+=2)
    {
        if (n % i == 0)
	    return 0;		// false -- not prime
    }

    return 1;			// true -- prime
}

int main()
{
    unsigned long long int num;
    char result;

    printf( "Please enter a number: " );
    scanf( "%llu", &num );

    result = isPrime (num);

    if (result == 1)
        printf( "%llu is prime\n", num );
    else
        printf( "%llu is not prime\n", num );
}

