
.text
.global main


myMax:
	pushl %ebp
	movl  %esp, %ebp

	movl  8(%ebp), %eax
	movl  12(%ebp), %edx

	cmpl  %eax, %edx

	jle  less
	movl $1, %eax
	jmp end
less:

end:
	leave
	ret



main:

	pushl %ebp
	movl  %esp, %ebp

	pushl %10
	pushl %5
	

	leave
	ret
