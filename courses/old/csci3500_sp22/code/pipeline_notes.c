




char* commands[15]; //All the commands we've parsed
char* newArgv[15]; //We will use this to parse each command

int old_pipe;

FOR_EACH_PROGRAM {

	int pipefd[2];
	int lastPID;

	if( FIRST OR MIDDLE ){
		pipe( pipefd );
	}

	if( FIRST ){

		FORK_AND_EXEC( commands[i] );
		close( pipefd[1] ); //Close write end of new pipe

	} else if( LAST ){

		lastPID = FORK_AND_EXEC( commands[i] );
		close( old_pipe ); //Close read end of OLD pipe

	} else { //The middle case

		FORK_AND_EXEC( commands[i] );
		close( old_pipe ); //Close read end of OLD pipe
		close( pipefd[1] ); //Close WRITE end of NEW pipe
	}

	if( FIRST OR MIDDLE ){
                old_pipe = pipefd[0];
	}

	if( LAST ){
		waitpid( lastPID, NULL, 0 );
	}

}













