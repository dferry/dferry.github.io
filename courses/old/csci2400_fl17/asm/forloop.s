.text
.global main                            /* program entry point */

main:
	//Preamble start
	pushl	%ebp
	movl	%esp, %ebp
	//Preamble finish

	movl 	$0, 	%ebx

loop:
	cmp	$20,	%ebx
	je	end	

	pushl	%ebx
	pushl	$loopIdx
	call 	printf
	popl	%ebx
	popl	%ebx

	addl	$4,	%ebx
	jmp	loop
	
end:


	//End of function start
	leave
	ret
	//End of function finish

.section .rodata
     loopIdx:
	.string	"loop index is %d\n"


