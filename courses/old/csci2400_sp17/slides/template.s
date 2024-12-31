
.text
.global main                            /* program entry point */

procedure:
	movl	4(%esp), %eax
	ret

main:
	pushl	%ebp
	movl	%esp, %ebp

        pushl   a
        call    procedure

	pushl	%eax
	pushl	$string
	call	printf

	leave
	ret

.section	.rodata
    string:
	.string	"result is %d\n"

.section .data
    a:
	.long	-25

