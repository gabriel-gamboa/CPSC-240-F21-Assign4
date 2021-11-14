/*
;********************************************************************************************
; Program name:          		                                        *
; Programming Language:  x86 Assembly                                                       *
; Program Created:		 November 4, 2020													*
; Program Completed:	 November 6, 2020													*
; Last Modified:		 November 10, 2020													*
; Program Description:     *
;                                                                                           *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Bilal El-haghassan                                                          *
; Email:        bilalelhaghassan@csu.fullerton.edu                                          *
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2020 Bilal El-haghassan                                                     *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program Information                                                                       *
; Program name:   				                           				*
; Languages used:                   	*
; Files included:                                 *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      isfloat.cpp                                                        	*
;    Purpose:   Validates if a string of characters is a floating point number              *
;	 Language:	C++																			*
   *
;																							*
;********************************************************************************************
*/
#include <cstdlib>                      // Header to include atof function in area.asm.
#include <ctype.h>                      // Header to include isdigit function.

using namespace std;

// Declare and extern function to make it callable by other linked files.
extern "C" bool ispositivefloat(char []);

// Definition of ispositivefloat function.
bool ispositivefloat(char w[])
{
    bool result = true;                 // Assume floating number until proven otherwise.
    bool found = false;                 // Checks if only 1 decimal is entered.
    int start = 0;
    if (w[0] == '+') start = 1;         // Checks to see if a valid plus sign is entered and
    unsigned long int k = start;        // increments the starting index for loop.
    while( !(w[k]=='\0') && result )
    {
        // Checks for decimal character in string with only 1 occurence.
        if ((w[k] == '.') && !found) { found = true;
        }
        else {
            // Sets result to true only if character at index k is a digit.
            result = result && isdigit(w[k]);
        }
        k++;
    }
    // Returns true if all characters in string are digits with exactly 1 decimal.
    return result && found;
}
//End of ispositivefloat.
