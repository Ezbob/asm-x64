
.include "functions.s"

.data
prefix: .asciz "Current time is: "

.text
.global _start

_start:
	movq $prefix, %rax
	call sprint

	xor %rdi, %rdi # time takes a pointer arg
	movq $201, %rax
	syscall

	call iprintln

	call quit
