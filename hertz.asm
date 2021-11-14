;****************************************************************************************************************************
;Program name: "Assignment 4".  This program greets a user by their inputted name  *
;and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Gabriel Gamboa
;  Author email: gabe04@csu.fullerton.edu
;
;Program information
; Program name: Assignment 4
;  Programming languages X86 with one module in C and one module in C++
;  Date program began 2021-Nov-11
;  Date program completed 2021-Nov-14
;
;Purpose
;  This program takes the value of resistance and current and
;  returns the power computation if inputs are valid, otherwise
;  it tells user to try again
;Project information
;  Files: maxwell.c, hertz.asm, r.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm


;============================================================================================================================================================


;===== Begin code area ============================================================================================================
extern printf
extern scanf
extern fgets
extern strlen
extern stdin
extern atof
extern ispositivefloat
global power

segment .data
align 16
purpose db "We will find your power.", 10, 0
promptname db "Please enter your name.  You choose the format of your name: ", 0
welcome_message db "Welcome %s.", 10, 0
mess db "Invalid input detected.  You may run this program again", 10, 0
resprompt db "Please enter the resistance in your circuit: ", 0
curprompt db "Please enter the current flow in this circuit: ",0
pc_message db "Thank you %s.  Your power consumption is %5.9lf watts.", 10, 0
one_float_format db "%lf",0
stringform db "%s", 0
align 64
segment .bss  ;Reserved for uninitialized data

programmers_name resb 256                  ;256 byte space created
res_string resb 256                        ;256 byte space created
cur_string resb 256                        ;256 byte space created

segment .text ;Reserved for executing instructions.

power:

;=============================================================================================
;back up data in registers
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags


;====================================================================================================================================================

mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, purpose               ;"We will find your power."
call printf


;=========== Prompt for user's name =================================================================================================================================

mov qword  rax, 0                                           ;No floats used
mov        rdi, stringform                                ;
mov        rsi, promptname                                  ;"Please enter your name.  You choose the format of your name: "
call       printf                                           ;C++ printf() function handles the output

;===== Obtain the programmer's name =============================================================================================================================================


mov qword rax, 0                                            ;no floats in scanf?
mov       rdi, programmers_name                             ;Start of array address to rdi
mov       rsi, 256                                           ;Size of input available to fgets for inputs
mov       rdx, [stdin]                                      ;rdx gets the inputting thing
call      fgets                                             ;gets a line of text less than 255 chars or stops when NULL is reached

;remove new line character from input of programmer name
mov rax, 0                                              ;No floats used
mov rdi, programmers_name                               ;Once the name is in rdi we can call strlen to get the length of the name. rdi is parameter in strlen
call strlen                                             ;call the C function strlen to get length
mov r14, rax                                            ;r14 contains the length of the string. I guess it's stored in rax after strlen is called
mov r15, 0                                              ;i was having bugs and heard this helps, not sure if this was ultimately what did the trick
mov [programmers_name + r14 -1],r15                     ;changed to 256 bytes of reserved data for programmer name instead of 32 bytes cause a test case was getting cut off
                                                        ;we replace it with 0 so that's why we do the ,r15
                                                        ;i don't know why we have to put in the [hello.programmers_name + r14 - 1]
                                                        ;or what the brackets are for. I'd think it would work without the hello.programmers_name, assuming the length is stored in r14

;============================================================================================================================================================================================

mov qword  rax, 0                                           ;No floats used
mov        rdi, welcome_message                             ;"Welcome %s. "
mov        rsi, programmers_name
call       printf                                           ;C printf() function handles the output



;===================Prompt user for resistance ===================================================================================================================================================

mov rax, 0                            ;format for printf, no floats used
mov rdi, resprompt                    ;"Please enter the resistance in your circuit: "
call printf                           ;prints out resprompt


;===== Obtain the resistance value and validate=============================================================================================================================================

;set up scanf for res_string
mov rax, 0
mov rdi, stringform
mov rsi, res_string
call scanf


;check input value for float
mov rax, 0
mov rdi, res_string
call ispositivefloat
mov r15, rax        ;r15 {0 is invalid, 1 is valid}

;check whether input is valid or not
cmp r15, 0
jne validprocess

;message run again
mov rax, 0
mov rdi, mess
call printf

;create -1.0 to return to driver for invalid inputs
push qword -1            ;push qword onto stack so we can convert it to float format to use in our calculations
cvtsi2sd xmm14, [rsp]   ;convert -1 to -1.0 and store it in xmmm15
pop rax                 ;why do we need to pop rax. what is in it?

jmp continue

;if valid, convert string to float
validprocess:
mov rax, 0
mov rdi, res_string
call atof
movsd xmm13, xmm0
;Done w/ input data validation

;============================================================================================================================================================================================



;=======Prompt user for current =====================================================================================================================================================================================


mov rax, 0                            ;format for printf, no floats used
mov rdi, curprompt                    ;"Please enter the current flow in this circuit: "
call printf                           ;prints out curprompt

;=======Obtain the current value and validate===============================================================================================================================================

;set up scanf for res_string
mov rax, 0
mov rdi, stringform
mov rsi, cur_string
call scanf


;check input value for float
mov rax, 0
mov rdi, cur_string
call ispositivefloat
mov r15, rax        ;r15 {0 is invalid, 1 is valid}

;check whether input is valid or not
cmp r15, 0
jne validp

;message run again
mov rax, 0
mov rdi, mess
call printf

;create -1.0 to return to driver for invalid inputs
push qword -1            ;push qword onto stack so we can convert it to float format to use in our calculations
cvtsi2sd xmm14, [rsp]   ;convert 2 to 2.0 and store it in xmmm15
pop rax                 ;why do we need to pop rax. what is in it?

jmp continue

;if valid, convert string to float
validp:
mov rax, 0
mov rdi, cur_string
call atof
movsd xmm14, xmm0
;Done w/ input data validation

;============================================================================================================================================================================================




;============= Begin arithmetic section  ===============================================================

;push qword 0            ;why do we do this?
mov rax, 1              ;1 floating point number will be passed into printf
mov rdi, pc_message   ;"Thank you %s.  Your power consumption is %5.9lf watts.."
mov rsi, programmers_name
mulsd xmm14, xmm14      ;computes the area of the right triangle and stores it in xmm14
mulsd xmm14,xmm13        ;printf prints out starting in xmm0?
movsd xmm0, xmm14
call printf
;pop rax





;============= End of arightmetic section ==============================================================



;============================================================================================================

continue:                     ;invalid input jumps to this part
movsd xmm0, xmm14              ;power return to caller.

;=================================================================================================================


;===== Restore backed up registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
