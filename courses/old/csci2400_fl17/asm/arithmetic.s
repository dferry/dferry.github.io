#compile with gcc -m32 arithmetic.s -o arithmetic

#Declare program code section of program
.text
.global main                            /* program entry point */

empty:
	ret

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Our code starts here


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
