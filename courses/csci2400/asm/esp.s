#compile with gcc -m32 template.s -o template

#Declare program code section of program
.text
.global main                            /* program entry point */


main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Our code starts here

	pushl $1024
	pushl $512	
	pushl $256

	#Call the function "printf"
	pushl	0(%esp)
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%eax

	#Our code ends here

	#Finish the main function with leave and ret
	leave
	ret

#Declare read-only data section of program
.section	.rodata
    string:
	.string	"Hello, world! Result is %d\n"

#Declare read/write data section of program
.section .data
    a:
	.long	100
