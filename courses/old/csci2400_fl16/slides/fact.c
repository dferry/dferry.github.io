#include <stdio.h>

int fact (int n)
{
    if (n < 0)
	return 0;
    else if (n <= 1)
	return 1;

    int prod = 1;
    int i = 2;

    while (i <= n)
    {
        prod *= i;		// prod = prod * i
        i++;			// i = i + 1
    }

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

