#include <stdio.h>
#include <string.h>
#include <unistd.h>

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

	//buffer[ strlen( buffer )-1 ] = '\n';
	char* newLine = strchr( buffer, '\n' );
	*newLine = '\0';

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
	
	//At this point we have a list of commands and can
	//print them out
	for( i = 0; i <= 14; i++ ){
		printf("Found token %d: %s\n", i, commands[i] );
		if( commands[i] == NULL )
			break;
	}

	//Exec each command in reverse order
	for( i = i - 1; i >= 0; i-- ){

		char* newArgv[15];

		newArgv[0] = strtok( commands[i], " " );
		int j;
		for( j = 1; j <= 14; j++ ){
			newArgv[j] = strtok( NULL, " " );
			if( newArgv[j] == NULL ){
				break;
			}
		}

		j = 0;
		while( newArgv[j] != NULL ){
			printf("Found %d: '%s'\n", j, newArgv[j] );
			j++;
		}

		pid_t child = fork();
		if( child == 0 ){
			execvp( newArgv[0], newArgv );
		}
	}





	return 0;
}
