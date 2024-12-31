//David Ferry
//July 25, 2016

//Instructor's solution to Lab 2 - the SLU Shell

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

const unsigned max_args          = 15;
const unsigned input_buffer_size = 256;
const unsigned curr_dir_buf_size = 256;

const char* cd_str       = "cd";
const char* delims       = " ";
const char* pipe_str     = "(";
const char  delim_char   = ' ';
const char  newline_char = '\n';
const char  null_char    = '\0';

void update_disp_dir( int homelength, char* dispdir){

	char currdir[curr_dir_buf_size];
	char* result;

	result = getcwd( currdir, curr_dir_buf_size );
	if( result == NULL ){
		perror("Error getting current directory");
		memset( currdir, 0, curr_dir_buf_size );
	}

	strcpy( dispdir, currdir + homelength);
	
}

//Replaces all newline characters in the input string with
//the delimiter character
void strip_newlines( char* buffer ){

	char* result;

	result = strchr( buffer, newline_char );

	while( result != NULL ){
		*result = delim_char;
		result = strchr( buffer, newline_char );
	}

}

//Executes change directory command
//Returns 0 on success
//Returns 1 on failure
int exec_new_dir( char* dir ){

	int result;

	result = chdir( dir );
	if( result == 0 ){ //Success
		return 1;
	}

	perror("Error changing directory");
	return 0;
}

//Check for change directory command
//Returns 0 if built in command was found and executed
//Returns 1 if otherwise
int check_cd_command( char* buffer ){
	char* first_tok;
	char* new_dir;
	int result;

	first_tok = strtok( buffer, delims );
	if( first_tok != NULL ){
		result = strcmp( first_tok, cd_str );
		if( result == 0 ){ //strings match
			new_dir = strtok( NULL, delims );
			exec_new_dir( new_dir );
			return 0;
		}
	}

	return 1;	
} 

//Replaces all non-terminating null characters with delimiters
//The strtok function mangles the input string, so we unmangle it
//in order to parse it twice
void unmangle_str ( char* buffer, char* terminator){
	char* i;

	for ( i = buffer; i != terminator; i++ ){
		if( *i == null_char ){
			*i = delim_char;
		}
	}

}

// Arg1: Expects a string that starts with the name of an executable
// file and has all arguments after it, space separated
// Arg2: The fd this process should use as stdin
// Arg3: The fd this process should use as stdout
// Returns 0 on success
// Returns 1 on failure
int exec_cmd( char* buffer, int in_fd, int out_fd ){

	int i;
	pid_t res;
	int int_return;
	char* cmd, *result;
	char* argv[max_args+2]; //One for command, one for terminator
	argv[max_args+1] = NULL;

	//Set up a pointer to command
	cmd = strtok( buffer, delims );
	if( cmd == NULL ){
		printf("Invalid null command\n");
		return 1;
	}
	
	argv[0] = cmd; //Set up argv[0]


	//Set up a pointer to each argument
	for( i=1; i < max_args+1; i++){
		result = strtok( NULL, delims );
		if( result == NULL ){
			argv[i] = NULL;
			break; //no more args
		}

		argv[i] = result;
	}


	printf("Executing: %s, inpipe: %d, outpipe: %d\n", buffer, in_fd, out_fd);

	/*
	//Fork and launch the new program	
	res = fork();
	if ( res == -1 ){ //Error
		perror("Error forking new process");
		return 1;
	}

	if ( res == 0 ){ //Child
	
		if( out_fd != -1 ){	
			int_return = dup2(STDOUT_FILENO, out_fd);
			if( int_return == -1 ){
				perror("Could not reassign stdout");
				exit(-1);
			}
		}

		if( in_fd != -1 ){
			int_return = dup2(STDIN_FILENO, in_fd);
			if( int_return == -1 ){
				perror("Could not reassign stdin");
				exit(-1);
			}
		}
		
		int_return = execvp( cmd, argv );
		if( int_return == -1 ){
			perror("Error executing command");
			exit(-1);
		}
	} else { //Parent

	}
	*/
	return 0; //Success

}

//Parses and executes commands from right to left
void parse_and_execute( char* buffer, int input_fd ){

	char* result;
	int pipefd[2];
	int res;

	result = strtok(buffer, pipe_str);
	if( result != NULL ){ //Found a pipe char i.e. new command
		//Create a new pipe for the output of the new command
		//and then execute it
		res = pipe(pipefd);
		if( res == -1 ){
			perror("Error creating pipe");
		}
		
		parse_and_execute(NULL, pipefd[0]);
	} else { //No command
		return;
	} 

	//printf("Executing: %s, inpipe: %d, outpipe: %d\n", result, input_fd, pipefd[1]);

	exec_cmd( result, input_fd, pipefd[1] );

}

int main ( int argc, char* argv[] ){

	int home_dir_length;
	int res;
	char *buffer, *result, *dispdir, *terminator;

	buffer = (char*) malloc( input_buffer_size );
	dispdir = (char*) malloc( curr_dir_buf_size );

	//Initialize the current display directory
	result = getenv("HOME");
	home_dir_length = strlen(result);
	update_disp_dir( home_dir_length, dispdir);

	while( 1 ){
		printf("slush|%s>", dispdir);
		result = fgets( buffer, input_buffer_size, stdin );
		if( result == NULL ){
			break;
		}

		strip_newlines( buffer );
		//Save the original string terminator
		terminator = strrchr( buffer, null_char );

		//Try to execute cd command first
		res = check_cd_command( buffer );
		if( res == 0 ){
			update_disp_dir( home_dir_length, dispdir);
			continue;
		}

		//Reverse changes by string tokenizer at this point
		unmangle_str( buffer, terminator );
	
		//The first command we find should not redirect 
		//stdin so we pass -1
		parse_and_execute( buffer, -1 );

	}

	printf("\n");
	return 0;
}
