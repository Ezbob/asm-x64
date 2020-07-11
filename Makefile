
%: %.s functions.s
	as --gstabs $< -o a.o
	ld a.o -o $@
	rm -f a.o

