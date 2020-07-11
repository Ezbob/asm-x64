
.include "functions.s"

.data
str: .string "Hello world"

.text

.global _start

_start:
	movq $str, %rax
	call sprintln
	call quit

