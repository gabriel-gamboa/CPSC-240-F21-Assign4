//****************************************************************************************************************************
//Program name: "Assignment 4".  This program greets a user by their inputted name  *
//and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




// ;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
// ;Author information
// ;  Author name: Gabriel Gamboa
// ;  Author email: gabe04@csu.fullerton.edu
// ;
// ;Program information
// ; Program name: Assignment 4
// ;  Programming languages X86 with one module in C and one module in C++
// ;  Date program began 2021-Nov-11
// ;  Date program completed 2021-Nov-14
// ;
// ;Purpose
// ;  This program takes the value of resistance and current and
// ;  returns the power computation if inputs are valid, otherwise
// ;  it tells user to try again
// ;Project information
// ;  Files: maxwell.c, hertz.asm, r.sh
// ;  Status: The program has been tested extensively with no detectable errors.
// ;
//This file
//   File name: maxwell.c
//   Language: C
//   Compile: g++ -c -Wall -m64 -no-pie -o maxwell.o maxwell.c -std=c++17 #look up c version
//   Link: g++ -m64 -no-pie -o power.out isfloat.o maxwell.o hertz.o -std=c++17
//
//
// ;============================================================================================================================================================
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <string.h>

extern "C" double power(); //don't know what the "C" does, but when using isfloat which uses "C", this function
//requires the "C" now too.  Other program with similar structure did not require "C"
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("Welcome to Power Unlimited programmed by Gabriel Gamboa.\n");
 answer = power();
 printf("The main function recieved this number %8.5lf and will keep it.\n",answer);
 printf("Next zero will be returned to the OS. Bye.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
