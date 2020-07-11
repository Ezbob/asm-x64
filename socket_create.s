
.include "functions.s"

.text
.global _start

_start:

socket:
	movq $1, %rdi # family  -> AF_INET
	movq $1, %rsi # type -> SOCK_STREAM
	xor %rdx, %rdx # no protocol -> set zero
	movq $41, %rax # sys_socket
	syscall

	pushq %rax

	call iprintln

	popq %rdi    	# close this fd 
	movq $3, %rax   # close call
	syscall

	call quit

