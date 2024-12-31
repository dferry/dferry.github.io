	.text
	.globl	main

hw4_prob2:
	movl	4(%esp), %eax		# 1st arg:  %eax = x
	movl	8(%esp), %edx		# 2nd arg:  %edx = y

	movl	%edx, %ecx		# %ecx = result = ...
	addl	%eax, %ecx
	sarl	$1, %ecx

	cmpl	$5, %eax
	jle	.L1

	cmpl	%eax, %ecx
	jg	.L1
	movl	%eax, %ecx
	subl	%edx, %ecx
	jmp	EXIT

.L1:
	cmpl	%edx, %eax
	jne	.L2
	movl	%eax, %ecx
	xorl	%edx, %ecx
	jmp	EXIT

.L2:
	movl	%eax, %ecx
	shll	$2, %ecx

EXIT:
	movl	%ecx, %eax
	ret


main:
        pushl  %ebp
        movl   %esp,%ebp
        andl   $-16,%esp
        subl   $32,%esp

	pushl	b
	pushl	a
        call   hw4_prob2

        movl   %eax, 4(%esp)
        movl   $prtString, (%esp)
        call   printf

        leave  
        ret    

.section        .rodata
    prtString:
        .string "\nresult is %d\n"

.section	.data
	a:
		.long 33
	b:
		.long 91
	c:
		.long -56


