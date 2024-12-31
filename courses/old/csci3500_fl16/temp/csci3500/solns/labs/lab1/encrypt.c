//David Ferry
//July 23, 2016
//Solution to CSCI3500 Lab 1 - encryption and system calls

#include <unistd.h> //For open(), close(), read(), and write()
#include <stdlib.h> //For exit()
#include <stdio.h> //For perror() and printf()
#include <fcntl.h> //For O_RDONLY and O_WRONLY flags
#include <string.h> //For strlen()
#include <rpc/des_crypt.h> //For ecb_encrypt()

const unsigned expected_inputs = 5;
const unsigned size_of_DES_key = 8;
#define KEY_ARG 1
#define INPUT_ARG 2
#define OUTPUT_ARG 3
#define MODE_ARG 4

const unsigned read_buffer_size = 8;
const unsigned strtol_base = 10;

int main ( int argc, char* argv[] ){

	int i;

	//Parameters for the encryption function
	char* key;
	char* data;
	unsigned datalen;
	unsigned mode;

	//Temporary values
	unsigned mode_select;
	char* endptr;

	//Names of input and output files
	char* inputfile;
	char* outputfile;


	//Check number of inputs
	if( argc != expected_inputs ){
		printf("This program encrypts a file using GNU's ecb_crypt() function.\n");
		printf("Warning! This is not strong encryption! Don't use it for secrets!\n");
		printf("Usage: <DES key> <input file> <output file> <mode>\n");
		printf("If mode=0 then encrypt, if mode=1 then decrypt\n");
		exit(-1);
	}

	//Expect three parameters- key, input file, and output file
	key         = argv[KEY_ARG];
	inputfile   = argv[INPUT_ARG];
	outputfile  = argv[OUTPUT_ARG];
	mode_select = strtol(argv[MODE_ARG], &endptr, strtol_base);
	
	//Error check result of strtol
	if( *endptr != '\0' ){
		printf("Error converting mode parameter to integer value!\n");
		exit(-1);
	}


	//Validate that key has length 8
	size_t keylength = strlen(key);
	if( keylength != size_of_DES_key ){
		printf("Error: DES key must be exactly eight characters long!\n");
		exit(-1);
	}
	
	//Validate that mode_select is either zero or one
	if( mode_select > 1 ){ //mode_select is unsigned
		printf("Error: Encryption mode parameter must be zero or one!\n");
		exit(-1);
	}
	
	//Set up encryption parameters 
	des_setparity(key);
	if( mode_select == 0 ){
//		printf("ENCRYPT MODE\n");
		mode = DES_ENCRYPT;
	} else {
//		printf("DECRYPT_MODE\n");
		mode = DES_DECRYPT;
	}

	//Open the input and output files
	int inputfd = open( inputfile, O_RDONLY );
	if( inputfd == -1 ){
		perror("Error opening input file");
		exit(-1);
	}

	int outputfd = open( outputfile, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR );
	if( outputfd == -1 ){
		perror("Error opening output file");
		exit(-1);
	}

	//Loop through the input file, encrypting as we go
	ssize_t bytes_read, bytes_written;
	char* buffer = (char*) malloc(read_buffer_size);
	if( buffer == NULL ){
		printf("Call to malloc failed!\n");
		exit(-1);
	}

	while( 1 ){ //Infinite loop until read returns 0
		bytes_read = read(inputfd, buffer, read_buffer_size);
		if( bytes_read == -1 ){ //Error while reading
			perror("Error while reading from input file");
			exit(-1);
		}
		if( bytes_read == 0 ){ //Reached EOF
			break;
		} 


		//ecb_crypt only works on data that is sized in multiples of 8
		//We can use the existing buffer, but there can't be left over
		//data in there
		if( bytes_read % 8 != 0 ){
			datalen = bytes_read + ( 8 - bytes_read%8 );
			for( i = bytes_read; i < datalen; i++)
				buffer[i] = ' ';
		} else {
			datalen = bytes_read;
		}
//		printf("Bytes read: %d, datalen: %d\n", bytes_read, datalen);

//		printf("Buffer: '%s'\n", buffer);
		ecb_crypt(key, buffer, datalen, mode);	
//		printf("Buffer: '%s'\n", buffer);
		

		bytes_written = write( outputfd, buffer, datalen );
		if( bytes_written == -1 ){
			perror("Error while writing to output file");
			exit(-1);
		}

	}

	close(inputfd);
	close(outputfd);
	free(buffer);

/*
	//This snippet demonstrates the use of the encryption function
	char data[] = "BE SURE TO DRINK YOUR OVALTINE  ";
	unsigned datalen = 32; //multiples of 8
	char key[] = "1234abcd"; //must be exactly 8

	printf("Original text: '%s'\n", data);

	des_setparity(key);
	ecb_crypt(key, data, datalen, DES_ENCRYPT);	
	printf("Ciphertext: '%s'\n", data);

	ecb_crypt(key, data, datalen, DES_DECRYPT);	
	printf("Decrypted text: '%s'\n", data);
*/

	return 0;
}


