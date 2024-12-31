.global main

main:

        pushl   %ebp
        movl    %esp,   %ebp

        movl    (0x1000),       %eax
        movl    (0x1004),       %ebx
        movl    %eax,           (0x1004)
        movl    %ebx,           (0x1000)


        leave
        ret
