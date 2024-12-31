.text
.global main                            /* program entry point */

myFunc:
	pushl	%ebp
	movl	%esp, %ebp

	addl	$15, %eax

	leave
	ret

main:
	//Preamble start
	pushl	%ebp
	movl	%esp, %ebp
	//Preamble finish

	movl	a, %eax
	call	myFunc

	pushl	%eax
	pushl	$myStr
	call	printf
	popl	%eax	
	popl	%eax


	//End of function start
	leave
	ret
	//End of function finish

.section .rodata
    myStr:
	.string	"Hello, world. Value: %d\n"

.section .data
    a:
	.long	10

