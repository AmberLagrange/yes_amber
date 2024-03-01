global _start

SYS_WRITE	equ 1
STDOUT		equ 1

%ifndef Y_COUNT
%assign Y_COUNT 1
%endif

%ifndef ITER
%assign ITER 1
%endif

SECTION .rodata
yes	times Y_COUNT db "y", 10
len	equ $-yes

SECTION .text

_start:
	mov		rdi, STDOUT
	mov 	rsi, yes
	mov 	rdx, len

	loop:
	
	%rep ITER
	mov		rax, SYS_WRITE
	syscall
	%endrep

	jmp loop
