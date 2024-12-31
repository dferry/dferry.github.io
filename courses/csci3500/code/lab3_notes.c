



void hash_and_check( char* buffer, char* hash, struct crypt_data* data ){


	char* result = crypt_r( buffer, salt, data )
	if( strcmp( result, hash ) == 0 ){
		printf("We found it\n");
	}
}

//Iterates from aaaa-zzzz over string of length
void iterate( char* startOfBuffer, char* startOfWork, int length, 
		struct crypt_data* data){
	
	char startChar = 'a';
	char endChar = 'z';
	startChar++;

	//Generates all passwords in a loop
	loop{
		hash_and_check( startOfBuffer, hash, data );
	}

}


struct thread_args{
	char start;
	char end;
}

void* thread_entry( void* args){

	struct crypt_data data;

	struct thread_args* my_args = args;

	char start = my_args->start;
	char end = my_args->end;
	char buffer[keysize+1];
	
	//Pointer "trick" to iterate over aaa-mzz

	for( char i = start; i <= end; i++ ){
		buffer[0] = i;
		iterate( buffer, buffer+1, keysize-1, &data );
	}
}




int main( int argc, char* argv[] ){

	struct thread_args structs[num_threads];

	for( i = 0; i < num_threads; i++ ){
		
		structs[i].start = ...; //compute start point of thread i
		structs[i].end = ...; //compute end point of thread i

		pthread_create( &tid, NULL, thread_entry, &structs[i] );
	}


}
