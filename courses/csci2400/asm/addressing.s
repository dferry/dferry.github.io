#Compile with: gcc -m32 addressing.s -o addressing

#Declare program code section of program
.text
.global main                            /* program entry point */

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp,	%ebp

	#Our code starts here

	/*
	#How we called printf from last time
	pushl	%eax
	pushl	$string
	call	printf
	*/

	#Our code ends here

	#Finish the main function with leave and ret
	leave
	ret

#Declare read-only data section of program
.section	.rodata
    string:
	.string	"Value is %u\n"

#Declare read/write data section of program
.section .data
    myarray:
	.long	100
	.long	200
	.long	300
	.long	400
	.long	500
	.long	600
	.long	700
