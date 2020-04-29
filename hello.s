.global _start

.data
a:
    .long 50

str:
    .string "Hi!"

.text
_start:
    movl a, %eax
    addl $100, %eax

    movl $str, %ebx
    movl $2, %ecx
    movb $126, (%ebx, %ecx)

done:
    nop
