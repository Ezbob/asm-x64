
# This is x86_64 assembler

.data
msg: .ascii "Hello world\n"

.text
.global _start

# syscall argument conventions in x86_64 is 
# rax: the syscall number e.g. the function number
# rdi: 1st arg
# rsi: 2nd arg
# rdx: 3rd arg
# r10: 4th arg
# r8: 5th arg
# r9: 6th arg

_start:
	movq $1, %rax # write syscall #1
	movq $1, %rdi # file descriptor
	movq $msg, %rsi # pointer to string
	movq $12, %rdx # length of string
	syscall

	movq $60, %rax # exit syscall #60
	movq $0, %rdi # return code zero
	syscall

