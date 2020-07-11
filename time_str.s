
.include "functions.s"

.data
prefix: .asciz "Current time is: "

.bss
time_buf: .skip 256

.text
.global _start

_start:
	xorq %rdi, %rdi
	movq $201, %rax
	syscall

	movq $time_buf, %rdi
	call itoa

	movq $time_buf, %rax
	call sprintln

	call quit
