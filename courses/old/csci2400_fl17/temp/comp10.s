//Compile with gcc 

.text
.global main

//This function compares a given value to 10

comp10:
	pushl 	%ebp
	movl	%esp, 		%ebp

	movl	8(%ebp),	%ebx
	
	cmp	$10,		%ebx
	jle	lessEq

	pushl	%ebx
	pushl	$greaterStr
	jmp	end	

lessEq:

	pushl	%ebx
	pushl	$lessEqStr

end:
	call	printf	
	popl	%ebx
	popl	%ebx

	popl	%ebp  
	ret



main:
	pushl 	%ebp
	movl	%esp, %ebp


	pushl	$7
	call	comp10
	popl	%eax

	pushl	$15
	call	comp10
	popl	%eax
	
	pushl	$10
	call	comp10
	popl	%eax

	popl	%ebp  
	ret



.data
lessEqStr:
	.string "%d is less or equal to 10\n"
	
greaterStr:	
	.string "%d is greater than 10\n"

