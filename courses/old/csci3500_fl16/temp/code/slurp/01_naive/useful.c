//David Ferry
//This file provides a function that does something useful

#include <stdio.h>
#include "useful.h"

int useful( int arg ){

  int ret;
  ret = printf("Useful function called locally\n");

  if( ret < 0 ){
    return USEFUL_ERROR;
  }

  return USEFUL_SUCCESS;
}
