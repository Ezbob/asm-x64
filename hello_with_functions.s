
.include "functions.s"

.data
msg: 	.asciz "Hello world!\n"

.text
.global _start

_start:
	movq $msg, %rax
	call slen
	movq %rax, %rdx

	movq $1, %rax
	movq $1, %rdi
	movq $msg, %rsi
	syscall


	call quit
