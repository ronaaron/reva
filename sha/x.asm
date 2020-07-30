	.file	"sha1.c"
	.intel_syntax noprefix
	.text
.globl SHA1Transform
	.type	SHA1Transform, @function
SHA1Transform:
	push	ebp
	mov	ebp, esp
	sub	esp, 40
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+12]
	add	eax, 1
	movzx	eax, BYTE PTR [eax]
	mov	BYTE PTR [ebp-9], al
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	sha1transform
	leave
	ret
	.size	SHA1Transform, .-SHA1Transform
	.type	SHA1Init, @function
SHA1Init:
	push	ebp
	mov	ebp, esp
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], 1732584193
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+4], -271733879
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+8], -1732584194
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+12], 271733878
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+16], -1009589776
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+24], 0
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [eax+24]
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+20], edx
	pop	ebp
	ret
	.size	SHA1Init, .-SHA1Init
	.type	SHA1Update, @function
SHA1Update:
	push	ebp
	mov	ebp, esp
	sub	esp, 56
	mov	DWORD PTR [ebp-28], ecx
	mov	DWORD PTR [ebp-32], edx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax+20]
	mov	DWORD PTR [ebp-16], eax
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax+20]
	mov	edx, DWORD PTR [ebp+8]
	sal	edx, 3
	lea	edx, [eax+edx]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax+20], edx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax+20]
	cmp	eax, DWORD PTR [ebp-16]
	jae	.L4
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax+24]
	mov	edx, DWORD PTR [ebp+8]
	shr	edx, 29
	add	eax, edx
	lea	edx, [eax+1]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax+24], edx
.L4:
	mov	eax, DWORD PTR [ebp-16]
	shr	eax, 3
	and	eax, 63
	mov	DWORD PTR [ebp-16], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [ebp-16]
	lea	eax, [edx+eax]
	cmp	eax, 63
	jbe	.L5
	mov	eax, 64
	sub	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [ebp-12], eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	add	eax, DWORD PTR [ebp-16]
	mov	edx, DWORD PTR [ebp-12]
	mov	DWORD PTR [esp+8], edx
	mov	edx, DWORD PTR [ebp-32]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	memcpy
	mov	eax, DWORD PTR [ebp-28]
	lea	edx, [eax+28]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	SHA1Transform
	jmp	.L6
.L7:
	mov	eax, DWORD PTR [ebp-12]
	mov	edx, DWORD PTR [ebp-32]
	add	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	SHA1Transform
	add	DWORD PTR [ebp-12], 64
.L6:
	mov	eax, DWORD PTR [ebp-12]
	add	eax, 63
	cmp	eax, DWORD PTR [ebp+8]
	jb	.L7
	mov	DWORD PTR [ebp-16], 0
	jmp	.L8
.L5:
	mov	DWORD PTR [ebp-12], 0
.L8:
	mov	eax, DWORD PTR [ebp-12]
	mov	edx, DWORD PTR [ebp+8]
	mov	ecx, edx
	sub	ecx, eax
	mov	eax, DWORD PTR [ebp-12]
	mov	edx, DWORD PTR [ebp-32]
	add	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	add	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp+8], ecx
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	memcpy
	leave
	ret	4
	.size	SHA1Update, .-SHA1Update
	.section	.rodata
.LC0:
	.string	"\200"
.LC1:
	.string	""
	.string	""
	.text
	.type	SHA1Final, @function
SHA1Final:
	push	ebp
	mov	ebp, esp
	push	esi
	push	ebx
	sub	esp, 48
	mov	DWORD PTR [ebp-28], ecx
	mov	DWORD PTR [ebp-32], edx
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR [ebp-12], eax
	xor	eax, eax
	mov	DWORD PTR [ebp-24], 0
	jmp	.L10
.L11:
	cmp	DWORD PTR [ebp-24], 3
	setbe	al
	movzx	edx, al
	mov	eax, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [eax+4+edx*4]
	mov	eax, DWORD PTR [ebp-24]
	not	eax
	and	eax, 3
	sal	eax, 3
	mov	ebx, edx
	mov	ecx, eax
	shr	ebx, cl
	mov	eax, ebx
	mov	edx, eax
	lea	eax, [ebp-20]
	add	eax, DWORD PTR [ebp-24]
	mov	BYTE PTR [eax], dl
	add	DWORD PTR [ebp-24], 1
.L10:
	cmp	DWORD PTR [ebp-24], 7
	jbe	.L11
	mov	edx, OFFSET FLAT:.LC0
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [esp], 1
	mov	ecx, eax
	call	SHA1Update
	sub	esp, 4
	jmp	.L12
.L13:
	mov	edx, OFFSET FLAT:.LC1
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [esp], 1
	mov	ecx, eax
	call	SHA1Update
	sub	esp, 4
.L12:
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax+20]
	and	eax, 504
	cmp	eax, 448
	jne	.L13
	lea	edx, [ebp-20]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [esp], 8
	mov	ecx, eax
	call	SHA1Update
	sub	esp, 4
	cmp	DWORD PTR [ebp-32], 0
	je	.L9
	mov	DWORD PTR [ebp-24], 0
	jmp	.L15
.L16:
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, DWORD PTR [ebp-32]
	add	edx, eax
	mov	eax, DWORD PTR [ebp-24]
	mov	ecx, eax
	shr	ecx, 2
	mov	eax, DWORD PTR [ebp-28]
	mov	ebx, DWORD PTR [eax+ecx*4]
	mov	eax, DWORD PTR [ebp-24]
	not	eax
	and	eax, 3
	sal	eax, 3
	mov	esi, ebx
	mov	ecx, eax
	shr	esi, cl
	mov	eax, esi
	mov	BYTE PTR [edx], al
	add	DWORD PTR [ebp-24], 1
.L15:
	cmp	DWORD PTR [ebp-24], 19
	jbe	.L16
.L9:
	mov	eax, DWORD PTR [ebp-12]
	xor	eax, DWORD PTR gs:20
	je	.L17
	call	__stack_chk_fail
.L17:
	lea	esp, [ebp-8]
	add	esp, 0
	pop	ebx
	pop	esi
	pop	ebp
	ret
	.size	SHA1Final, .-SHA1Final
	.type	DigestToBase16, @function
DigestToBase16:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	DWORD PTR [ebp-4], 0
	jmp	.L19
.L20:
	mov	eax, DWORD PTR [ebp+8]
	movzx	eax, BYTE PTR [eax]
	shr	al, 4
	movzx	eax, al
	and	eax, 15
	movzx	edx, BYTE PTR zEncode.2049[eax]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax], dl
	add	DWORD PTR [ebp+12], 1
	mov	eax, DWORD PTR [ebp+8]
	movzx	eax, BYTE PTR [eax]
	movzx	eax, al
	and	eax, 15
	movzx	edx, BYTE PTR zEncode.2049[eax]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax], dl
	add	DWORD PTR [ebp+12], 1
	add	DWORD PTR [ebp+8], 1
	add	DWORD PTR [ebp-4], 1
.L19:
	cmp	DWORD PTR [ebp-4], 19
	jle	.L20
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax], 0
	leave
	ret
	.size	DigestToBase16, .-DigestToBase16
	.local	thesum
	.comm	thesum,64,32
	.section	.rodata
.LC2:
	.string	"rb"
	.text
.globl sha1sum_file
	.type	sha1sum_file, @function
sha1sum_file:
	push	ebp
	mov	ebp, esp
	sub	esp, 10408
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [ebp-10380], eax
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR [ebp-12], eax
	xor	eax, eax
	mov	eax, OFFSET FLAT:.LC2
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [ebp-10380]
	mov	DWORD PTR [esp], eax
	call	fopen
	mov	DWORD PTR [ebp-10368], eax
	cmp	DWORD PTR [ebp-10368], 0
	jne	.L22
	mov	eax, 0
	jmp	.L23
.L22:
	lea	eax, [ebp-124]
	mov	DWORD PTR [esp], eax
	call	SHA1Init
.L25:
	mov	eax, DWORD PTR [ebp-10368]
	mov	DWORD PTR [esp+12], eax
	mov	DWORD PTR [esp+8], 10240
	mov	DWORD PTR [esp+4], 1
	lea	eax, [ebp-10364]
	mov	DWORD PTR [esp], eax
	call	fread
	mov	DWORD PTR [ebp-10372], eax
	cmp	DWORD PTR [ebp-10372], 0
	jg	.L24
	mov	eax, DWORD PTR [ebp-10368]
	mov	DWORD PTR [esp], eax
	call	fclose
	lea	edx, [ebp-32]
	lea	eax, [ebp-124]
	mov	ecx, eax
	call	SHA1Final
	mov	DWORD PTR [esp+4], OFFSET FLAT:thesum
	lea	eax, [ebp-32]
	mov	DWORD PTR [esp], eax
	call	DigestToBase16
	mov	eax, OFFSET FLAT:thesum
	jmp	.L23
.L24:
	mov	ecx, DWORD PTR [ebp-10372]
	lea	edx, [ebp-10364]
	lea	eax, [ebp-124]
	mov	DWORD PTR [esp], ecx
	mov	ecx, eax
	call	SHA1Update
	sub	esp, 4
	jmp	.L25
.L23:
	mov	edx, DWORD PTR [ebp-12]
	xor	edx, DWORD PTR gs:20
	je	.L26
	call	__stack_chk_fail
.L26:
	leave
	ret
	.size	sha1sum_file, .-sha1sum_file
.globl sha1sum
	.type	sha1sum, @function
sha1sum:
	push	ebp
	mov	ebp, esp
	sub	esp, 200
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [ebp-172], eax
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR [ebp-12], eax
	xor	eax, eax
	lea	eax, [ebp-168]
	mov	DWORD PTR [esp], eax
	call	SHA1Init
	mov	eax, DWORD PTR [ebp-172]
	mov	DWORD PTR [esp], eax
	call	strlen
	mov	ecx, eax
	mov	edx, DWORD PTR [ebp-172]
	lea	eax, [ebp-168]
	mov	DWORD PTR [esp], ecx
	mov	ecx, eax
	call	SHA1Update
	sub	esp, 4
	lea	edx, [ebp-32]
	lea	eax, [ebp-168]
	mov	ecx, eax
	call	SHA1Final
	mov	DWORD PTR [esp+4], OFFSET FLAT:thesum
	lea	eax, [ebp-32]
	mov	DWORD PTR [esp], eax
	call	DigestToBase16
	mov	eax, OFFSET FLAT:thesum
	mov	edx, DWORD PTR [ebp-12]
	xor	edx, DWORD PTR gs:20
	je	.L28
	call	__stack_chk_fail
.L28:
	leave
	ret
	.size	sha1sum, .-sha1sum
	.section	.rodata
.LC3:
	.string	"%s %s\n"
	.text
.globl main
	.type	main, @function
main:
	push	ebp
	mov	ebp, esp
	and	esp, -16
	sub	esp, 32
	mov	DWORD PTR [esp+28], 1
	jmp	.L30
.L31:
	mov	eax, DWORD PTR [esp+28]
	sal	eax, 2
	add	eax, DWORD PTR [ebp+12]
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp], eax
	call	sha1sum_file
	mov	DWORD PTR [esp+24], eax
	mov	eax, DWORD PTR [esp+28]
	sal	eax, 2
	add	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [eax]
	mov	eax, OFFSET FLAT:.LC3
	mov	DWORD PTR [esp+8], edx
	mov	edx, DWORD PTR [esp+24]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	printf
	add	DWORD PTR [esp+28], 1
.L30:
	mov	eax, DWORD PTR [esp+28]
	cmp	eax, DWORD PTR [ebp+8]
	jl	.L31
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.type	zEncode.2049, @object
	.size	zEncode.2049, 17
zEncode.2049:
	.string	"0123456789abcdef"
	.ident	"GCC: (Ubuntu/Linaro 4.5.2-8ubuntu4) 4.5.2"
	.section	.note.GNU-stack,"",@progbits
