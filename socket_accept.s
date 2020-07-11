
.include "functions.s"

.text
.global _start

_start:
	xor %rax, %rax
	xor %rdx, %rdx
	xor %rdi, %rdi
	xor %rsi, %rsi
_socket:
	movq $2, %rdi # family  -> AF_INET
	movq $1, %rsi # type -> SOCK_STREAM
	xor %rdx, %rdx # no protocol -> set zero
	movq $41, %rax # sys_socket
	syscall

_bind:
	movq %rax, %rdi # move socket fd into first arg

	# making the sockaddr_in on the stack
	pushw $0x0000 
	pushw $0x0000 # due to how push works on 64bit vs 32bit, we need to push twice to get pushl effect
	pushw $0x2923 # socket number in network notation
	pushw $2
	movq %rsp, %rsi # get stack address as pointer
	movq $16, %rdx # byte size of sockaddr_in struct
	movq $49, %rax # bind function number
	syscall

_listen:
	movq $1, %rsi
	movq $50, %rax
	syscall

_accept:
	movq $0x0, %rsi
	movq $0x0, %rdx
	movq $43, %rax
	syscall	

_close:
	movq $3, %rax   # close call
	syscall

	call quit

