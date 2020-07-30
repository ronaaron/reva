	.file	"x.c"
	.intel_syntax noprefix
	.text
.globl SHA1Transform
	.type	SHA1Transform, @function
SHA1Transform:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	eax, DWORD PTR [ebp+12]
	add	eax, 1
	movzx	eax, BYTE PTR [eax]
	mov	BYTE PTR [ebp-1], al
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 8
	mov	edx, DWORD PTR [eax]
	movzx	eax, BYTE PTR [ebp-1]
	lea	eax, [edx+eax]
	leave
	ret
	.size	SHA1Transform, .-SHA1Transform
.globl main
	.type	main, @function
main:
	push	ebp
	mov	ebp, esp
	sub	esp, 8
	mov	DWORD PTR [esp+4], 0
	mov	DWORD PTR [esp], 0
	call	SHA1Transform
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.5.2-8ubuntu4) 4.5.2"
	.section	.note.GNU-stack,"",@progbits
