section .data
message: db 'Hello'

section .text
global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 14
	syscall
	
	mov rax, 60
	xor rdi, rdi ; ie. mov rdi, 0
	syscall
