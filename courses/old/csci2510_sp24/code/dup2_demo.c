//Demo of using dup2 to redirect between processes

//This program creates two children: one reads this file
// and writes it into the pipe, the second one uses
// grep to search for all lines that contain the string "include"

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

int main( int argc, char* argv[] ){

	//Create the pipes, pipefd[0] is the read end, pipefd[1] is the write end
	int pipefd[2];
	pipe( pipefd );

	pid_t child1 = fork();
	//This child is the writing process
	if( child1 == 0 ){ 

		//Any child should close any file descriptor it does not need a copy of
		close( pipefd[0] );

		//We want the reading process to read this program and write the output
		//to the pipe. If we go to the terminal and use the command "cat dup2_demo.c"
		//it will print this file to the standard output. We will use this
		//command to read the file, but instead we want the output to
		//go into the pipe.
		
		//Close standard output and replace it with pipe write-end
		dup2( pipefd[1], STDOUT_FILENO );

		//Execute the command 'cat dup2_demo.c'
		char* file = "cat";
		char* new_argv[3]; //Two arguments plus the null terminator
		new_argv[0] = file;
		new_argv[1] = "dup2_demo.c"; //Name of the file to print
		new_argv[2] = NULL;

		int ret = execvp( file, new_argv );
		if( ret == -1 ){
			perror("Could not execute cat program");
			return 0;
		}
	} //End of writing process

	pid_t child2 = fork();
	//This child is the reading process
	if( child2 == 0 ){ 

		//Any child should close any file descriptor it does not need
		close( pipefd[1] );

		//This child reads the contents of the pipe and only matches
		// lines that contain the indentifier 'include'. This can be
		// done by calling the command 'grep include'

		//Close the standard input and replace it with the pipe read-end
		dup2( pipefd[0], STDIN_FILENO);

		//Execute the command 'grep include'
		char* file = "grep";
		char* new_argv[3]; //Two arguments plus the null terminator
		new_argv[0] = file;
		new_argv[1] = "include"; //Name of the string to match
		new_argv[2] = NULL;

		int ret = execvp( file, new_argv );
		if( ret == -1 ){
			perror("Could not execute grep program");
			return 0;
		}
	}

	//Once the parent has created both children, it does not need either end
	//of the pipe, so close both file descriptors.
	close( pipefd[0] );
	close( pipefd[1] );	

	//Wait for the read-side to finish. The write-read sequencing between the
	//two children guarantees that child2 (the reader) will finish after
	//child1 (the writer)
	waitpid( child2, NULL, 0 );

	return 0;
}

