#compile with gcc -m32 template.s -o template

#Declare program code section of program
.text
.global main                            /* program entry point */

procedure:
	pushl	%ebp
	movl	%esp, 	%ebp

	movl	8(%esp), %eax

	leave
	ret

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Our code starts here
	
	#Call the function "procedure"
        pushl   a
        call    procedure
	popl	%edx

	#Call the function "printf"
	pushl	%eax
	pushl	$string
	call	printf
	popl	%eax
	popl	%eax

	#Our code ends here

	#Finish the main function with leave and ret
	leave
	ret

#Declare read-only data section of program
.section	.rodata
    string:
	.string	"Hello, world! Result is %d.\n"

#Declare read/write data section of program
.section .data
    a:
	.long	100


