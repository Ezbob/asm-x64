
.include "functions.s"

.bss
buffer: .skip 256

.data
response: .asciz "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: 14\r\n\r\nHello world\r\n"

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
	movq $0x0, %rsi # null pointer
	movq $0x0, %rdx # null pointer
	movq $43, %rax
	syscall	

	movq %rax, %rsi # our new fd from socket
_fork:
	movq $57, %rax
	syscall

	test %rax, %rax
	jz _read # child processes go to read

	jmp _accept # parent accepts more
_read:
	movq %rsi, %rdi # client FD
	movq $buffer, %rsi # buffer addr
	movq $255, %rdx # how many bytes to read
	movq $0, %rax
	syscall	

	movq $buffer, %rax
	call sprintln
_write:
	movq $response, %rsi # our response
	movq $78, %rdx # response byte count
	movq $1, %rax # syscall number
	syscall

_close:
	movq $3, %rax   # close call
	syscall

	call quit

