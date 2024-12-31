#compile with gcc -m32 template.s -o template

#Declare program code section of program
.text
.global main                            /* program entry point */

procedure:
	movl	4(%esp), %eax
	ret

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Our code starts here
	
	movl $50, %eax
	movl %eax, a

	#Call the function "procedure"
        pushl   a
        call    procedure

	#Call the function "printf"
	pushl	%eax
	pushl	$string
	call	printf
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
