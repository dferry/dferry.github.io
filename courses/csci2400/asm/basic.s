#Compile with: gcc -m32 basic.s -o basic

#Declare the start of the .text section
.text
.global main #make procedure main globally visible

#Declare procedure called "add"
add:
	addl	4(%esp), %eax #add the value of "a" pushed onto stack to eax
	ret

main:
	#Set up stack pointer and stack frame base pointer
	pushl	%ebp
	movl	%esp, %ebp

	#Move decmial value 10 into eax register
	movl	$10, %eax

	#Compute the effective address of variable "a" and store 100 there
	leal	a, %ebx
	movl	$100, (%ebx)

	#Push the value "a" onto the call stack and call procedure add
	pushl	a
	call	add
	
	#Push the value of eax and address of "string" onto the call stack and
	#call the C function printf()
	pushl	%eax
	pushl	$string
	call	printf

	#Clean up stack
	leave
	#Return from main
	ret

#Declare the start of section .rodata (read-only data)
.section .rodata
	string:
		.string "Hello, world! Value: %d \n"

#Declare the start of section .data (read/write data)
.section .data
	a:
		.long 23
