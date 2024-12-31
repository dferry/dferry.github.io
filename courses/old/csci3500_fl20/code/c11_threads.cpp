#include <iostream>
#include <thread>

void thread_entry( int x, char y, char* str ){
	std::cout << "Arg1 is " << x << "  Arg 2 is " << y << "   Arg 3 is " << str << std::endl;
}

int main( int argc, char* argv[] ){

	std::thread myThread = std::thread( thread_entry, 42, 'z', "This is my string" );

	myThread.join();

}


