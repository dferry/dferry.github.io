#include <thread>
#include <iostream>

void thread_function (int a, int b){

	std::cout << "Thread got values " << a << " and " << b << std::endl;

}


int main( int argc, char* argv[] ){

	std::thread thread_handle;

	thread_handle = std::thread( thread_function, 10, 20 );

	thread_handle.join();	

	std::cout << "Main thread joined with child thread" << std::endl;
}
