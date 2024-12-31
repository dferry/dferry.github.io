//David Ferry
//This program calls a useful function

#include <stdio.h>
#include "useful.h"

int main ( int argc, char* argv[] ){

  printf("About to call useful function.\n");
  int ret = useful(10);
  printf("Finished calling useful function.\n");
  
  if( ret == USEFUL_ERROR ){
    printf("Error calling useful function!\n");
    return -1;
  }

  return 0;
}
