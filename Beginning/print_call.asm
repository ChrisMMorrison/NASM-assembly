section .data

newline_char: db 0x0D, 0x0A
codes: db '0123456789abcdef'

section .text
global _start

print_newline:
	mov rax, 1 		;syscall will be write
	mov rdi, 1 		;writing to stdout
	mov rsi, newline_char	;where we take data from
	mov rdx, 1 		;only writing 1 byte
	ret

print_hex:
	mov rax, rdi

	mov rdi, 1		;values for writing: 1 byte to stdout
	mov rdx, 1
	mov rcx, 64		;shifting rax 16 times since rax has 16 hex digits (64/4 = 16)
iterate:
	push rax		;save initial rax value since where fucking with it and then using a syscall with it
	sub rcx, 4
	sar rax, cl 		;shift over by x bytes each time (60, 56, 52,...,0)
				;cl is smallest part of rcx
	and rax, 0xf 		;AND with 0xf (1111) to return only first for bytes
	lea rsi, [codes + rax]	;find ASCII table of new found digit
	
	mov rax, 1

	push rcx		;save rcx from syscall
	syscall			;rax = 1: write command
				;rdi = 1: write to stdout
				;rsi = line 28: what ever ascii code of number is
	pop rcx

	pop rax
	test rcx, rcx
	jnz iterate

	ret

_start:
	mov rdi, rsp ;hex number to print
	call print_hex
	call print_newline

	push rax
	
	mov rdi, rsp
	call print_hex

	mov rax, 60
	xor rdi, rdi ;mov rdi, 0 but faster
	syscall
