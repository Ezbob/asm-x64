
.include "functions.s"

.data
number: .asciz "The number of the day is: "

.text
.global _start

_start:
	movq $number, %rax
	call sprint

	movq $42, %rax
	call iprintln

	call quit

