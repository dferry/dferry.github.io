#include <stdio.h>
#include <string.h>

#define bufferSize 1024

int main( int argc, char* argv[] ){

	//We want to parse a string like:
	// "grep dferry ( sort ( ps aux"

	char buffer [ bufferSize ];

	char* retval = fgets( buffer, bufferSize, stdin );
	if( retval == NULL ){
		perror("Could not read from input");
		return -1;
	}
	
	//At this point, buffer looks like: 
	// "grep dferry ( sort ( ps aux"
	
	char* commands [ 15 ]; 

	//Initial call to strtok()
	commands[0] = strtok( buffer, "(" );
	if( commands[0] == NULL ){
		return 0;
	}
	int i;
	for( i = 1; i <= 14; i++ ){
		commands[i] = strtok( NULL, "(" );
		if( commands[i] == NULL )
			break;
	}

	for( i = 0; i <= 14; i++ ){
		printf("Found token %d: %s\n", i, commands[i] );
		if( commands[i] == NULL )
			break;
	}

	return 0;
}
