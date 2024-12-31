       #include <sys/types.h>
       #include <sys/stat.h>
       #include <fcntl.h>
       #include <unistd.h>
       #include <stdio.h>

int main( int argc, char* argv[] ){

	if( argc != 2 ){
	
	printf("Usage: open_demo <name of output file>\n");
	return -1;

	}

	char* outFileName = argv[1]; //output file is first arg

	int outFD = open( outFileName, 
			    O_CREAT | O_TRUNC | O_WRONLY, 
			    S_IRUSR | S_IWUSR);

	if( outFD == -1 ){
		perror("Could not open file for output");
		return -1;
	}
	
	int retval = write( outFD, "Writing some data to a test file\n", 33);

	if( retval == -1 ){
		perror("Could not write to file");
		return -1;
	}

	close( outFD );

	return 0;
}

