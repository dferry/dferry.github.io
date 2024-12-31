#include <thread>
#include <iostream>

void thread_start( int x, int y ){

	std::cout << "Executing thread with x=" << x << " and y=" << y << std::endl;

	return;
}


int main( int argc, char* argv[] ){

  std::thread t1 (thread_start, 15, 400 );
  t1.join();

  return 0;

}

