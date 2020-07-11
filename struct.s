# heap allocated struct example

.include "functions.s"

.data
astruct: .zero 8

.text
.global _start

_start:
	pushq %rsi
	movq $astruct, %rsi
	movl $42, (%rsi)
	movl $37, 4(%rsi)
	
	movl (%rsi), %eax
	call iprintln

	movl 4(%rsi), %eax
	call iprintln 
	
	call quit

