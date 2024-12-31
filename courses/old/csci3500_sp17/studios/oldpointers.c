//Your name
//The date
//This program illustrates some uses of pointers on character strings in C

#include <stdio.h>

char jumble[] = "which6o12i4s6p52y45ses23s5tr12ee56amm3456t12bestich3456n123456g";
int  bufferSize = 63;

int main( int argc, char* argv[] ){

	int i;

	printf("%c\n", *jumble);
	printf("%c\n", *jumble + 1);
	printf("%c\n", *(jumble + 1));

	printf("%c\n", jumble[0]);
	printf("%c\n", jumble[0]+1);
	printf("%c\n", jumble[1]);
	

	for( i = 0; i < bufferSize; i++ ){
		printf("%c", jumble[i]);
	}

	printf("\n");

	for( i = 0; i < 5; i++ ){
		printf("%c", jumble[i]);
	}

	printf("\n");

	i = 1;
	while( i*7 - 1 < bufferSize ){
		printf("%c", jumble[i*7 - 1]);
		i++;
	}

	printf("\n");

	for( i = 0; i < 6; i++){
		printf("%c", jumble[5*i + 11]);
	}

	printf("\n");

	printf("%c%c\n", jumble[9], jumble[24]);

	for( i = 44; i < 48; i++ ){
		printf("%c", jumble[i]);
	}

	printf("\n");

	jumble[0] = 'l';
	jumble[1] = 'i';
	jumble[2] = 'n';
	jumble[3] = 'u';
	jumble[4] = 'x';

	for( i = 0; i < bufferSize; i++ ){
		printf("%c", jumble[i]);
	}

	printf("\n");

	for( i = 0; i < 5; i++ ){
		printf("%c", jumble[i]);
	}

	printf("\n");

	i = 1;
	while( i*7 - 1 < bufferSize ){
		printf("%c", jumble[i*7 - 1]);
		i++;
	}

	printf("\n");

	for( i = 0; i < 6; i++){
		printf("%c", jumble[5*i + 11]);
	}

	printf("\n");

	printf("%c%c\n", jumble[9], jumble[24]);

	for( i = 44; i < 48; i++ ){
		printf("%c", jumble[i]);
	}
	printf("\n");

	return 0;
}
