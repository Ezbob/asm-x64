
# ascii to integer
# rax shall hold the pointer to a string
atoi:
	pushq %rbx
	pushq %rcx
	pushq %rdx
	pushq %rsi

	movq %rax, %rsi
	movq $0, %rax
	movq $0, %rcx

1:	
	xorq %rbx, %rbx
	movb (%rsi, %rcx), %bl
	cmpb $48, %bl
	jl 2f
	cmpb $57, %bl
	jg 2f

	subb $48, %bl
	addq %rbx, %rax
	movq $10, %rbx
	mulq %rbx
	incq %rcx
	jmp 1b

2:
	movq $10, %rbx
	divq %rbx
	
	popq %rsi
	popq %rdx
	popq %rcx
	popq %rbx
	ret

# integer to ascii:
# rax contains the input integer;
# rdi (output parameter) contains the pointer to the data drop-off buffer
# rax contains the number of characters, copied to the output buffer
itoa:
	pushq %rsi
	pushq %rdx
	pushq %rcx
	xor %rcx, %rcx
1:
	xor %rdx, %rdx
	movq $10, %rsi
	idivq %rsi
	addq $48, %rdx
	
	# our %rdx now contains the current ascii code
	pushq %rdx

	incq %rcx
	
	cmpq $0, %rax
	jnz 1b
	movq %rcx, %rax

	movb $0, (%rdi, %rcx) # null terminator added
	xor %rsi, %rsi
2:
	popq %rdx
	movb %dl, (%rdi, %rsi)
	incq %rsi

	cmpq %rsi, %rcx
	jne 2b

	popq %rcx
	popq %rdx
	popq %rsi
	ret


# int slen(unsigned char *)
# takes a str pointer in rax
slen:
	pushq %rbx
	pushq %rcx
	movq %rax, %rbx
	movb $0, %ch
1:
	movb (%rax), %cl
	cmpb %cl, %ch
	jz 2f
	incq %rax
	jmp 1b
2:
	subq %rbx, %rax
	popq %rcx
	popq %rbx
	ret

# iprint: print integers in rax
iprint:
	pushq %rax
	pushq %rcx
	pushq %rdx
	pushq %rsi
	xor %rcx, %rcx
1:
	incq %rcx
	xor %rdx, %rdx
	movq $10, %rsi
	idivq %rsi
	addq $48, %rdx
	pushq %rdx # remainder is the result; saving on stack the character
	cmpq $0, %rax
	jnz 1b
2:
	decq %rcx
	movq %rsp, %rax
	call sprint
	popq %rax
	cmpq $0, %rcx
	jnz 2b

	popq %rsi
	popq %rdx
	popq %rcx
	popq %rax
	ret

# print integer new line
iprintln:
	call iprint
	pushq %rax

	movq $0x0A, %rax	
	pushq %rax
	movq %rsp, %rax
	call sprint
	popq %rax
	
	popq %rax	
	ret

# void sprint(unsigned char *)
# prints a string to stdout, pointer to string is expected in rax
sprint:
	pushq %rdx
	pushq %rcx
	pushq %rsi
	pushq %rdi

	pushq %rax	

	call slen
	movq %rax, %rdx

	popq %rsi

	movq $1, %rax
	movq $1, %rdi
	syscall

	popq %rdi
	popq %rsi
	popq %rcx
	popq %rdx
	ret

# sprint with a newline feed, %rax is expected to hold the pointer of the string
sprintln:
	call sprint
	
	pushq %rax
	movq $0x0A, %rax

	pushq %rax
	movq %rsp, %rax # the address of our newline feed
	call sprint
	popq %rax

	popq %rax
	ret

# void quit(void)
# exit this application gracefully
quit:
	movq $60, %rax
	movq $0, %rdi
	syscall	
	ret

