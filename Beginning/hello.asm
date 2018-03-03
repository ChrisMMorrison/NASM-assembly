section .data
message: db 'Hello', 10

section .text
global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 6
	syscall
	
	mov rax, 60
	xor rdi, rdi ; ie. mov rdi, 0
	syscall
