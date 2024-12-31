#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFERSIZE 1024

int main( int argc, char* argv[] ){

	char* inputFile;
	char* outputFile;

	//char example[] = "This is a string.";

	inputFile = argv[1];
	outputFile = argv[2];

	int inFD = open( inputFile, O_RDONLY );
	if( inFD == -1 ){
		perror("Could not open input file");
		exit(-1);
	}

	char buffer [BUFFERSIZE];
	ssize_t retval = read( inFD, buffer, BUFFERSIZE-1 );
	if( retval == -1 ){
		perror("Could not read from input file");
		exit(-1);
	}
	
	//buffer[0] = the first byte we read from the file
	buffer[retval] = '\0';

	printf("We got from the file: '%s'\n");

        int outFD = open( outputFile, 
			O_WRONLY | O_CREAT | O_TRUNC,
		       	S_IRUSR | S_IWUSR);
        if( outFD == -1 ){
                perror("Could not open output file");
                exit(-1);
        }

	retval = write( outFD, "This is a demo\n", 15 );
	if( retval == -1 ){
		perror("Could not write to output file");
		exit(-1);
	}

	//Demonstrate writing binary data to a file
	unsigned char counter = 43;

	retval = write( outFD, &counter, 1 );
	if( retval == -1 ){
                perror("Could not write binary data");
                exit(-1);
        }

	return 0;
}


