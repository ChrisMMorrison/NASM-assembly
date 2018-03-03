section .data
codes:
	db	'0123456789ABCDEF'

section .text
global _start
_start:
	; number 1234567887654321 in hex format
	mov rax, 0x1234567812345678  

	mov rdi, 1 ;print to stdout
	mov rdx, 1 ;we're printing a byte each time
	mov rcx, 64
	; Each 4 bits should be output as one hex digit
	; Use shift and logical AND to isolate them
	; the result is the offset in 'codes' array
.loop:
	push rax; store our number "1234567887654321"
	sub rcx, 4
	sar rax, cl
	and rax, 0xf
	
	lea rsi, [codes + rax]
	mov rax, 1

	; syscall affects rcx and r11
	push rcx 
	syscall
	pop rcx
	
	pop rcx
	;test is fastest is it zero check
	test rcx, rcx
	jnz .loop

	mov rax, 60
	xor rdi, rdi
	syscall
