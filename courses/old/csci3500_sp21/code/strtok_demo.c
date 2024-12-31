#include <stdio.h>
#include <string.h>

int main( int argc, char* argv[] ){

	printf("Please enter an input:\n");

	int bufferSize = 1024;
	char buffer[bufferSize];

	char* retval = fgets( buffer, bufferSize, stdin );
	if( retval == NULL ){
		printf("fgets failed\n");
		return -1;
	}

	printf("Got '%s' from fgets\n", buffer );

	//If input is "Hello, world!\n"
	//After one strtok, we have:
	// "Hello,\0world\n"
	//After a second strtok, we have:
	// "Hello,\0world\n\0"
	//printf("Got from strtok '%s'\n", retval );
	//retval = strtok( NULL, " " );
	//printf("Got from second strtok '%s'\n", retval );

	//Strtok is also a useful way to get rid of newlines
	strtok( buffer, "\n" );

	//Lab 2 may have a command like:
	//grep file ( cat ( ls -l

	char* commands [ 15 ]; //Assume no more than 15 commands

	//The first call to strtok names the string to parse
	retval = strtok( buffer, "(" );
	int i = 0;
	commands[i] = retval;

	while( retval != NULL ){
		//To keep processing previous string, call strtok()
		//with NULL instead of string pointer
		retval = strtok( NULL, "(" );
		i++;
		commands[i] = retval;
	}

	i = 0;
	while( commands[i] != NULL ){
		printf("Got command '%s' in position %d\n", commands[i], i);
		i++;
	}	




	return 0;
}
