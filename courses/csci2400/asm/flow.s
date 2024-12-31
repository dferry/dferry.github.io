#compile with gcc -m32 flow.s -o flow

#Declare program code section of program
.text
.global main                            /* program entry point */

compare:
	pushl	%ebp
	movl	%esp, %ebp
	pusha

	#Move the arguments A and B into the registers EAX and EBX respectively
	movl	8(%ebp), %eax #Argument A
	movl	12(%ebp), %ebx #Argument B

	#Your comparison code goes here

	#Execute this code to exit function
	compare_exit:
	popa
	leave
	ret

main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Example calling the function compare with
	#A = 75
	#B = 100
	pushl	$100
	pushl	$75
	call	compare
	pop	%eax
	pop	%eax



	#Finish the main function with leave and ret
	EXIT:
	leave
	ret

print_all:
	pushl	%ebp
	movl	%esp, %ebp
	call	print_intro
	call	print_eax
	call	print_ebx
	call	print_ecx
	call	print_edx
	call	print_cf
	call	print_zf
	call	print_sf
	call	print_of
	leave
	ret

print_intro:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%eax
	pushl	%ecx
	pushl	%edx
	pushl	$intro
	call	printf
	pop	%eax
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	leave
	ret

print_eax:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
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
	popf
	leave
	ret

print_ebx:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
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
	popf
	leave
	ret

print_ecx:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
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
	popf
	leave
	ret

print_edx:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
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
	popf
	leave
	ret

print_cf:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx
	pushf	#push eflags onto stack
	pop	%eax #move flags from stack to reister
	andl	$0x1, %eax #select first bit of flags
	pushl	%eax #push that value onto the stack
	pushl	$strcf
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	leave
	ret

print_zf:
	#function preamble
	pushl	%ebp
	movl	%esp, %ebp
	#save processor state
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx

	#Now we select the seventh bit and move it to the first place
	pushf	#push eflags onto stack
	pop	%eax #put eflags into register
	andl	$0x40, %eax #select seventh bit of flags
	shrl	$6, %eax #move the seventh bit down to the first place

	#Set up and call printf function
	pushl	%eax #push the 0/1 value onto the stack for printf
	pushl	$strzf #push the zf string onto stack for printf
	pushl	$string #push the specifier string onto stack for printf
	call	printf
	pop	%eax #clear $string from stack
	pop	%eax #clear $strzf from stack
	pop	%eax #clear the 0/1 value from the stack

	#restore processor state
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	#function exit
	leave
	ret


print_sf:
	#function preamble
	pushl	%ebp
	movl	%esp, %ebp
	#save the existing state of the processor
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx

	#Finish this function by writing your code here
	#Now we select the eighth bit and move it to the first place
        pushf   #push eflags onto stack
        pop     %eax #put eflags into register
        andl    $0x80, %eax #select eigth bit of flags
        shrl    $7, %eax #move the eigth bit down to the first place

        #Set up and call printf function
        pushl   %eax #push the 0/1 value onto the stack for printf
        pushl   $strsf #push the zf string onto stack for printf
        pushl   $string #push the specifier string onto stack for printf
        call    printf
        pop     %eax #clear $string from stack
        pop     %eax #clear $strzf from stack
        pop     %eax #clear the 0/1 value from the stack

	#restore the existing state of the processor
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	#Function exit code
	leave
	ret

print_of:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx
	pushf	#push eflags onto stack
	pop	%eax #move eflags from stack to register
	andl	$0x800, %eax #select twelfth bit of flags
	shrl	$11,	%eax #move place 12 to place 1
	pushl	%eax #push that value onto the stack
	pushl	$strof
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	leave
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
    strcf:
	.string "Carry Flag"
    strzf:
	.string "Zero Flag"
    strsf:
	.string "Sign Flag"
    strof:
	.string "Overflow Flag"
    intro:
	.string "Printing processor state:\n"

#Declare read/write data section of program
.section .data
	#not needed for this assignment
    #a:
	#.long 	100
