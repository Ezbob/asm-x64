
.include "functions.s"

.text
.global _start
	
_start:
	popq %rdi
	
1:
	popq %rax
	call sprintln

	decq %rdi
	test %rdi, %rdi
	jne 1b

	call quit

