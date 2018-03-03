section .data
codes:
	db '0123456789ABCDEF'

section .text
global _start
_start:
	;number to print
	lea rax, [codes]

	mov rdi, 1
	mov rdx, 1 	;only printing 1b at a time to stdout
	mov rcx, 64
	; Each 4 bits is output as 1 hex digit
	; Use shift and bitwise AND to isolate them
	; result is then offset in 'codes' array
.loop:
	push rax
	sub rcx, 4
	; cl is smallest part of rcx
	sar rax, cl
	and rax, 0xF
	
	lea rsi, [codes + rax]
	mov rax, 1
	
	;syscall will change rcx and r11
	push rcx
	syscall 	;print number
	pop rcx

	pop rax 	;return rax to original number so shifting works
	;test rcx, rcx is like sub rcx, rcx but faster
	test rcx, rcx
	jnz .loop

	mov rax, 60	;exit
	xor rdi, rdi
	syscall
