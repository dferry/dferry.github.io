#include <stdio.h>

char* toBinary (unsigned int n, int nbytes);

char binStr[33];

int main()
{
    unsigned char x = 53;
    unsigned short y = 118;

    printf ("x  = %d\t\t(0b%s)\n", x, toBinary (x, sizeof(x)));
    printf ("y  = %d\t\t(0b%s)\n", y, toBinary (y, sizeof(y)));
    printf ("\n");

    printf ("~y = %d\t\t(0b%s)\n", ~y, toBinary (~y, sizeof(y)));
    printf ("-y = %d\t\t(0b%s)\n", -y, toBinary (-y, sizeof(y)));

}

char* toBinary (unsigned int n, int nbytes)
{
    int nbits = nbytes * 8;
    unsigned int i = 1 << (nbits-1);
    int j = 0;
    for (j = 0; j < nbits; j++)
    {
        if (n & i)
              binStr[j] = '1';
        else
              binStr[j] = '0';

        i = i / 2;
    }

    binStr[j] = 0;

    return binStr;
}

