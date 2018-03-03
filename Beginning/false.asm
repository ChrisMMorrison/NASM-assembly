global _start

section .text
_start:
	mov rdi, 55
	mov rax, 60
	syscall
