#include <stdio.h>

// primes up to 1000
int primes[] = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47,
		 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107,
		 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167,
		 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
		 233, 239, 263, 281, 311, 313, 317, 331, 337, 347, 349,
		 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419,
		 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479,
		 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563,
		 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619,
		 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691,
		 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769,
		 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853,
		 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929,
		 937, 941, 947, 953, 967, 971, 977, 983, 991, 997 };
		// ...

char isPrime (unsigned long long int n)
{
    if (n <= 0)
        return -1;              // error, undefined
    else if (n <= 3)
        return 1;               // 1, 2, and 3 are prime

    unsigned long long int i;

    // check if n is evenly divisible by any ODD number between 3 ... sqrt(n)
    for (i = 0; primes[i]*primes[i] <= n; i++)
    {
        if (n % primes[i] == 0)
            return 0;           // false -- not prime
    }

    return 1;                   // true -- prime
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


