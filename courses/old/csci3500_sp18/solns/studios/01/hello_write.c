//David Ferry
//Aug 30, 2017
//Introduction to using write system call

#include <unistd.h>

int main (int argc, char* argv[]){

	char* buf = "Hello world with write!\n";

	write(STDOUT_FILENO, buf, 500);

	return 0;
}
