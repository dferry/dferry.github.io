

int main( int argc, char* argv[] ){

	while( 1 ){

		char* retval = fgets( buffer, bufferSize, stdin );
		if( retval == NULL ){
			break; //Terminate program
		}

		//Step 1 input processing with STRTOK

		//Strip newline from input

		char* commands[15];
		//parse input with strtok, put each command in commands vector
		//E.g. if input is "grep file ( cat ( ls -l"
		//then:
		//commands[0] = " ls -l"
		//commands[1] = " cat "
		//commands[2] = "grep file "
		//commands[3] = NULL


		//Step 2 fork and exec each command
		if( numCommands == 1 ){
			//Fork and exec command separately

			continue;
		}

		int i;
		int pipefd[2];
		for( i = 0; i < numCommands; i++ ){
			int oldPipeFD;
				oldpipeFD = pipefd[0];
			if( is_first_process || is_middle_process ){
				pipe(pipefd);
			}

			int ret = fork();
			if( ret == 0 ){ //Start child
				if( is_first_process ){
					//redirect output to pipefd[1]
					//close pipefd[0]
				}

				if( is_middle_process ){
					//redirect input from oldpipefd
					//redirect output to pipefd[1]
					//close pipefd[0]
				}

				if( is_end_process ){
					//redirect input from oldpipefd
				}

				ret = execvp(...);
				perror("Could not exec");
				exit(-1);
			} //End child

			//We still have the parent
			if( is_first_process ){
				//Close pipefd[1]
			}

      if( is_middle_process ){
	      //Close oldpipefd
	      //Close pipefd[1]
      }

      if( is_end_process ){
	      //Close oldpipefd
	      //waitpid on end process (ret) 
      }
		
		}

	}


}

