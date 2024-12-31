.text
.global main                            /* program entry point */

test10:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	pushl	%eax

	cmpl	$10, %eax

	jle	lessEq
	
	pushl	$greaterStr
	jmp	end		

lessEq:

	pushl	$lessEqStr

end:
	call 	printf
	popl 	%eax
	popl	%eax

	popl	%ebp
	ret

main:
	//Preamble start
	pushl	%ebp
	movl	%esp, %ebp
	//Preamble finish

	pushl	$5
	call	test10
	popl	%eax

	pushl	$17
	call	test10
	popl	%eax

	pushl	$10
	call	test10
	popl	%eax

	//End of function start
	leave
	ret
	//End of function finish

.section .rodata
    greaterStr:
	.string	"%d is greater than 10\n"
    lessEqStr:
	.string "%d is less than or equal to 10\n"


