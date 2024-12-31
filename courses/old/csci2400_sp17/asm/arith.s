#compile with gcc -m32 arithmetic.s -o arithmetic

#Declare program code section of program
.text
.global main                            /* program entry point */

myfunc:
	#pre-amble
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax	#argument A
	movl	12(%ebp), %ebx	#argument B
	movl	16(%ebp), %ecx	#argument C

	#d = b * c
	movl	%ebx,	%edx
	imull	%ecx,	%edx
	
	#a = a + 2*b
	addl	%ebx,	%eax
	addl	%ebx,	%eax

	#c = c * c
	imull	%ecx,	%ecx

	#return a + b + c + d
	addl	%ebx,	%eax
	addl	%ecx,	%eax
	addl	%edx,	%eax

	#post-amble
	leave
	ret

empty:
	ret

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Our code starts here

	#1
	mov 	$100, 	%eax
	mov 	$5, 	%ebx
	mov 	%eax, 	%ecx
	addl	%ebx,	%ecx
	call	print_ecx

	#2
	mov 	%eax, 	%ecx
	subl	%ebx,	%ecx
	call	print_ecx

	#3
	mov 	%eax, 	%ecx
	imull	%ebx,	%ecx
	call	print_ecx

	#4
	movl	$40, 	%eax
	sall	$2,	%eax
	movl	%eax,	%ebx
	call	print_ebx
	
	#5
	movl	$-500, 	%eax
	sarl	$2,	%eax
	movl	%eax,	%ebx
	call	print_ebx

	#6
	movl	$1000, 	%eax
	movl	%eax,	%ebx
	movl	%eax,	%ecx
	sall	$5,	%eax
	sall	$4,	%ecx
	addl	%eax,	%ebx
	addl	%ecx,	%ebx
	call	print_ebx

	#7
	pushl	$10
	pushl	$5
	pushl	$1
	call	myfunc
	call 	print_all

	pushl	$16
	pushl	$8
	pushl	$4
	call	myfunc
	call 	print_all

	#Our code ends here

	#Finish the main function with leave and ret
	leave
	ret

print_all:
	call	print_eax
	call	print_ebx
	call	print_ecx
	call	print_edx
	ret

print_eax:
	pushl	%ecx
	pushl	%edx
	pushl 	%eax
	pushl	$streax
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%edx
	pop	%ecx
	ret

print_ebx:
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	pushl 	%ebx
	pushl	$strebx
	pushl	$string
	call	printf
	pop	%ebx
	pop	%ebx
	pop	%ebx
	pop	%eax
	pop	%edx
	pop	%ecx
	ret

print_ecx:
	pushl	%edx
	pushl	%eax
	pushl 	%ecx
	pushl	$strecx
	pushl	$string
	call	printf
	pop	%ecx
	pop	%ecx
	pop	%ecx
	pop	%eax
	pop	%edx
	ret

print_edx:
	pushl	%ecx
	pushl	%eax
	pushl 	%edx
	pushl	$stredx
	pushl	$string
	call	printf
	pop	%edx
	pop	%edx
	pop	%edx
	pop	%eax
	pop	%ecx
	ret

#Declare read-only data section of program
.section	.rodata
    string:
	.string "Value of %s: %d\n"
    streax:
	.string	"EAX"
    strebx:
	.string	"EBX"
    strecx:
	.string	"ECX"
    stredx:
	.string	"EDX"

#Declare read/write data section of program
.section .data
	#not needed for this assignment
    #a:
	#.long 	100
