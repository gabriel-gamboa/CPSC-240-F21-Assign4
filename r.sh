#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program Assignment 2"

echo "Assemble the module hertz.asm"
nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm

echo "Compile the C++ module isfloat.cpp"
g++ -c -Wall -m64 -no-pie -l isfloat.lis -o isfloat.o isfloat.cpp -std=c++17 #look up c version

echo "Compile the C module maxwell.c"
g++ -c -Wall -m64 -no-pie -o maxwell.o maxwell.c -std=c++17 #look up c version

echo "Link the three object files already created"
g++ -m64 -no-pie -o power.out isfloat.o maxwell.o hertz.o -std=c++17  #look up version

echo "Run the program Assignment 2"
./power.out

echo "The bash script file is now closing."
