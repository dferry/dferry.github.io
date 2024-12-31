       #include <sys/types.h>
       #include <unistd.h>
       #include <stdio.h>
       #include <stdlib.h>
       #include <sys/wait.h>

int main( int argc, char* argv[] ){

	int x = 10;
	pid_t ret; 


	ret = fork();
	if( ret == -1 ){
		perror("Fork failed");
		return -1;
	}

	if( ret == 0 ){ //in the child

		char* cmd = "ls";
		char* arg1 = "-l";
		char* arg2 = "-a";

		char* new_argv[4];

		new_argv[0] = cmd;
		new_argv[1] = arg1;
		new_argv[2] = arg2;
		new_argv[3] = NULL;

		int ret_val;
		ret_val = execvp( cmd, new_argv );
		if( ret_val == -1 ){
			perror("Could not exec");
		}
		exit(-1);
	}

	//Anything after is the parent
	
	waitpid( ret, NULL, 0 );
	
	x = 20;

	printf("Hello, world! My X is %d\n", x);

	return 0;
}
