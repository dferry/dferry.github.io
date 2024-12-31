#include <stdio.h>

int fact (int n)
{
    if (n < 0)
	return 0;
    else if (n <= 1)
	return 1;

    int i;
    int prod = 1;

    for (i = 2; i <= n; i++)
        prod *= i;		// prod = prod * i

    return prod;
}

int main()
{
    int num, result;

    printf( "Please enter a number: " );
    scanf( "%d", &num );

    result = fact (num);

    printf( "The factorial of %d is %d\n", num, result );
}

