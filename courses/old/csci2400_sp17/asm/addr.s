#Instructor's version

#Declare program code section of program
.text
.global main                            /* program entry point */

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp,	%ebp

	#Our code starts here

	leal	a,	%eax
	movl	$0,	%ebx

	#Call the function "printf"
	pushl	3(%eax,%ebx,4)
	incl	%ebx
	pushl	(%eax,%ebx,4)
	incl	%ebx
	pushl	(%eax,%ebx,4)
	incl	%ebx
	pushl	(%eax,%ebx,4)
	incl	%ebx
	pushl	(%eax,%ebx,4)
	incl	%ebx
	pushl	(%eax,%ebx,4)
	incl	%ebx
	pushl	(%eax,%ebx,4)
	pushl	$string
	call	printf
	
	/*
	#Call the function "printf"
	pushl	(%eax)
	pushl	4(%eax)
	pushl	8(%eax)
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
	.string	"Value is %u %u %u %u %u %u %u\n"
	#.string	"Value is %d %d %d\n"

#Declare read/write data section of program
.section .data
    a:
	.long	100
	.long	200
	.long	300
	.long	400
	.long	500
	.long	600
	.long	700
