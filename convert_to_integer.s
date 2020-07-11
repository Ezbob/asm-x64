
.include "functions.s"

.data
number: .asciz "42"

.text
.global _start

_start:
	movq $number, %rax
	call atoi

	call iprintln

	call quit

