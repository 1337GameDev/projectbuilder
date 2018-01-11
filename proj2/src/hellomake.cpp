#include <1/2/hellomake.h>
#include <boost/filesystem.hpp>
#include <stdio.h>
#include <iostream>

int main(){
  myPrintHelloMake();

	if(!boost::filesystem::exists("test.txt") ) {
	  std::cout << "Can't find my file!" << std::endl;
	} else {
		std::cout << "\"test.txt\" exists!" << std::endl;
	}

  return 0;
}
