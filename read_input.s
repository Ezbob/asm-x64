
.include "functions.s"

.bss
buffer: .skip 256

.text
.globl _start

_start:
	movq $0, %rdi
	movq $buffer, %rsi
	movq $256, %rdx
	movq $0, %rax
	syscall

	movq $buffer, %rax
	call sprintln

	call quit
