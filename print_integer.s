
.include "functions.s"

.data
number: .asciz " is the number of the day"

.text
.global _start

_start:
	movq $42, %rax
	call iprint

	movq $number, %rax
	call sprintln

	call quit

