
.include "functions.s"

.data
msg: 	.asciz "Hello world!"

.text
.global _start

_start:
	movq $msg, %rax
	call sprintln

	call quit
