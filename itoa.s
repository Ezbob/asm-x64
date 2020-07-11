
.include "functions.s"

.bss
buf: .skip 256

.text
.global _start

_start:
	movq $42, %rax
	movq $buf, %rdi
	movq $256, %rbx
	call itoa	

	movq $buf, %rax
	call sprintln

	call quit

