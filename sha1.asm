	.file	"sha1.c"
	.intel_syntax noprefix
	.text
.globl SHA1Transform
	.type	SHA1Transform, @function
SHA1Transform:
	push	ebp
	mov	ebp, esp
	push	edi
	push	esi
	push	ebx
	sub	esp, 1084
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [ebp-28], eax
	mov	DWORD PTR [esp+8], 20
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp+4], eax
	lea	eax, [ebp-1072]
	mov	DWORD PTR [esp], eax
	call	memcpy
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, DWORD PTR [ebp-1064]
	mov	ecx, DWORD PTR [ebp-1060]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-32], ebx
	mov	eax, DWORD PTR [ebp-32]
	mov	ecx, eax
	and	ecx, -16711936
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-36], ebx
	mov	eax, DWORD PTR [ebp-36]
	and	eax, 16711935
	or	ecx, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-40], ebx
	mov	eax, DWORD PTR [ebp-40]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-44], ebx
	mov	eax, DWORD PTR [ebp-44]
	mov	DWORD PTR [ebp-1068], eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, DWORD PTR [ebp-1068]
	mov	ecx, DWORD PTR [ebp-1064]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 4
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 4
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 81 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-48], ebx
	mov	ecx, DWORD PTR [ebp-48]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 4
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 81 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-52], ebx
	mov	ecx, DWORD PTR [ebp-52]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-56], ebx
	mov	eax, DWORD PTR [ebp-56]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-60], ebx
	mov	eax, DWORD PTR [ebp-60]
	mov	DWORD PTR [ebp-1072], eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, DWORD PTR [ebp-1072]
	mov	ecx, DWORD PTR [ebp-1068]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 8
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 81 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-64], ebx
	mov	ecx, DWORD PTR [ebp-64]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 8
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 81 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-68], ebx
	mov	ecx, DWORD PTR [ebp-68]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-72], ebx
	mov	eax, DWORD PTR [ebp-72]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-76], ebx
	mov	eax, DWORD PTR [ebp-76]
	mov	DWORD PTR [ebp-1056], eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, DWORD PTR [ebp-1056]
	mov	ecx, DWORD PTR [ebp-1072]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 12
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 12
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 81 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-80], ebx
	mov	ecx, DWORD PTR [ebp-80]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 12
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 81 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-84], ebx
	mov	ecx, DWORD PTR [ebp-84]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-88], ebx
	mov	eax, DWORD PTR [ebp-88]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 81 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-92], ebx
	mov	eax, DWORD PTR [ebp-92]
	mov	DWORD PTR [ebp-1060], eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, DWORD PTR [ebp-1060]
	mov	ecx, DWORD PTR [ebp-1056]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 16
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 16
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-96], ebx
	mov	ecx, DWORD PTR [ebp-96]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 16
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-100], ebx
	mov	ecx, DWORD PTR [ebp-100]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-104], ebx
	mov	eax, DWORD PTR [ebp-104]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-108], ebx
	mov	eax, DWORD PTR [ebp-108]
	mov	DWORD PTR [ebp-1064], eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, DWORD PTR [ebp-1064]
	mov	ecx, DWORD PTR [ebp-1060]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 20
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 20
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-112], ebx
	mov	ecx, DWORD PTR [ebp-112]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 20
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-116], ebx
	mov	ecx, DWORD PTR [ebp-116]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-120], ebx
	mov	eax, DWORD PTR [ebp-120]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-124], ebx
	mov	eax, DWORD PTR [ebp-124]
	mov	DWORD PTR [ebp-1068], eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, DWORD PTR [ebp-1068]
	mov	ecx, DWORD PTR [ebp-1064]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 24
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 24
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-128], ebx
	mov	ecx, DWORD PTR [ebp-128]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 24
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-132], ebx
	mov	ecx, DWORD PTR [ebp-132]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-136], ebx
	mov	eax, DWORD PTR [ebp-136]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-140], ebx
	mov	eax, DWORD PTR [ebp-140]
	mov	DWORD PTR [ebp-1072], eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, DWORD PTR [ebp-1072]
	mov	ecx, DWORD PTR [ebp-1068]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 28
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-144], ebx
	mov	ecx, DWORD PTR [ebp-144]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 28
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 82 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-148], ebx
	mov	ecx, DWORD PTR [ebp-148]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-152], ebx
	mov	eax, DWORD PTR [ebp-152]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 82 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-156], ebx
	mov	eax, DWORD PTR [ebp-156]
	mov	DWORD PTR [ebp-1056], eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, DWORD PTR [ebp-1056]
	mov	ecx, DWORD PTR [ebp-1072]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 32
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-160], ebx
	mov	ecx, DWORD PTR [ebp-160]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 32
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-164], ebx
	mov	ecx, DWORD PTR [ebp-164]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-168], ebx
	mov	eax, DWORD PTR [ebp-168]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-172], ebx
	mov	eax, DWORD PTR [ebp-172]
	mov	DWORD PTR [ebp-1060], eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, DWORD PTR [ebp-1060]
	mov	ecx, DWORD PTR [ebp-1056]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 36
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 36
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-176], ebx
	mov	ecx, DWORD PTR [ebp-176]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 36
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-180], ebx
	mov	ecx, DWORD PTR [ebp-180]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-184], ebx
	mov	eax, DWORD PTR [ebp-184]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-188], ebx
	mov	eax, DWORD PTR [ebp-188]
	mov	DWORD PTR [ebp-1064], eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, DWORD PTR [ebp-1064]
	mov	ecx, DWORD PTR [ebp-1060]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 40
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 40
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-192], ebx
	mov	ecx, DWORD PTR [ebp-192]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 40
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-196], ebx
	mov	ecx, DWORD PTR [ebp-196]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-200], ebx
	mov	eax, DWORD PTR [ebp-200]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-204], ebx
	mov	eax, DWORD PTR [ebp-204]
	mov	DWORD PTR [ebp-1068], eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, DWORD PTR [ebp-1068]
	mov	ecx, DWORD PTR [ebp-1064]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 44
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 44
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-208], ebx
	mov	ecx, DWORD PTR [ebp-208]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 44
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 83 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-212], ebx
	mov	ecx, DWORD PTR [ebp-212]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-216], ebx
	mov	eax, DWORD PTR [ebp-216]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 83 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-220], ebx
	mov	eax, DWORD PTR [ebp-220]
	mov	DWORD PTR [ebp-1072], eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, DWORD PTR [ebp-1072]
	mov	ecx, DWORD PTR [ebp-1068]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 48
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 48
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-224], ebx
	mov	ecx, DWORD PTR [ebp-224]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 48
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-228], ebx
	mov	ecx, DWORD PTR [ebp-228]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-232], ebx
	mov	eax, DWORD PTR [ebp-232]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-236], ebx
	mov	eax, DWORD PTR [ebp-236]
	mov	DWORD PTR [ebp-1056], eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, DWORD PTR [ebp-1056]
	mov	ecx, DWORD PTR [ebp-1072]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 52
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-240], ebx
	mov	ecx, DWORD PTR [ebp-240]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 52
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-244], ebx
	mov	ecx, DWORD PTR [ebp-244]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-248], ebx
	mov	eax, DWORD PTR [ebp-248]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-252], ebx
	mov	eax, DWORD PTR [ebp-252]
	mov	DWORD PTR [ebp-1060], eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, DWORD PTR [ebp-1060]
	mov	ecx, DWORD PTR [ebp-1056]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 56
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 56
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-256], ebx
	mov	ecx, DWORD PTR [ebp-256]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 56
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-260], ebx
	mov	ecx, DWORD PTR [ebp-260]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-264], ebx
	mov	eax, DWORD PTR [ebp-264]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-268], ebx
	mov	eax, DWORD PTR [ebp-268]
	mov	DWORD PTR [ebp-1064], eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, DWORD PTR [ebp-1064]
	mov	ecx, DWORD PTR [ebp-1060]
	xor	ecx, ebx
	and	ecx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, ecx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 60
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 60
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	ror 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-272], ebx
	mov	ecx, DWORD PTR [ebp-272]
	mov	edi, ecx
	and	edi, -16711936
	mov	ecx, DWORD PTR [ebp-28]
	add	ecx, 60
	mov	ecx, DWORD PTR [ecx]
	mov	ebx, ecx
#APP
# 84 "sha1.c" 1
	rol 8,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-276], ebx
	mov	ecx, DWORD PTR [ebp-276]
	and	ecx, 16711935
	or	ecx, edi
	mov	DWORD PTR [eax], ecx
	mov	eax, DWORD PTR [eax]
	lea	ecx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-280], ebx
	mov	eax, DWORD PTR [ebp-280]
	lea	eax, [ecx+eax]
	lea	eax, [edx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 84 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-284], ebx
	mov	eax, DWORD PTR [ebp-284]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1064]
	xor	edx, ebx
	and	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	xor	eax, edx
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-288], ebx
	mov	edx, DWORD PTR [ebp-288]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-292], ebx
	mov	eax, DWORD PTR [ebp-292]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-296], ebx
	mov	eax, DWORD PTR [ebp-296]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1068]
	xor	edx, ebx
	and	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 4
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 86 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-300], ebx
	mov	edx, DWORD PTR [ebp-300]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-304], ebx
	mov	eax, DWORD PTR [ebp-304]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-308], ebx
	mov	eax, DWORD PTR [ebp-308]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1072]
	xor	edx, ebx
	and	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 86 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-312], ebx
	mov	edx, DWORD PTR [ebp-312]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-316], ebx
	mov	eax, DWORD PTR [ebp-316]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-320], ebx
	mov	eax, DWORD PTR [ebp-320]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1056]
	xor	edx, ebx
	and	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 12
	mov	edx, DWORD PTR [ebp-28]
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 86 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-324], ebx
	mov	edx, DWORD PTR [ebp-324]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-328], ebx
	mov	eax, DWORD PTR [ebp-328]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1518500249
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 86 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-332], ebx
	mov	eax, DWORD PTR [ebp-332]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 16
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 87 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-336], ebx
	mov	edx, DWORD PTR [ebp-336]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-340], ebx
	mov	eax, DWORD PTR [ebp-340]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-344], ebx
	mov	eax, DWORD PTR [ebp-344]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 20
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 87 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-348], ebx
	mov	edx, DWORD PTR [ebp-348]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-352], ebx
	mov	eax, DWORD PTR [ebp-352]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-356], ebx
	mov	eax, DWORD PTR [ebp-356]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 24
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 87 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-360], ebx
	mov	edx, DWORD PTR [ebp-360]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-364], ebx
	mov	eax, DWORD PTR [ebp-364]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-368], ebx
	mov	eax, DWORD PTR [ebp-368]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 87 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-372], ebx
	mov	edx, DWORD PTR [ebp-372]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-376], ebx
	mov	eax, DWORD PTR [ebp-376]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 87 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-380], ebx
	mov	eax, DWORD PTR [ebp-380]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 88 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-384], ebx
	mov	edx, DWORD PTR [ebp-384]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-388], ebx
	mov	eax, DWORD PTR [ebp-388]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-392], ebx
	mov	eax, DWORD PTR [ebp-392]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 36
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 88 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-396], ebx
	mov	edx, DWORD PTR [ebp-396]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-400], ebx
	mov	eax, DWORD PTR [ebp-400]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-404], ebx
	mov	eax, DWORD PTR [ebp-404]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 40
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 88 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-408], ebx
	mov	edx, DWORD PTR [ebp-408]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-412], ebx
	mov	eax, DWORD PTR [ebp-412]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-416], ebx
	mov	eax, DWORD PTR [ebp-416]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 44
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 88 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-420], ebx
	mov	edx, DWORD PTR [ebp-420]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-424], ebx
	mov	eax, DWORD PTR [ebp-424]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 88 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-428], ebx
	mov	eax, DWORD PTR [ebp-428]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 48
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 89 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-432], ebx
	mov	edx, DWORD PTR [ebp-432]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-436], ebx
	mov	eax, DWORD PTR [ebp-436]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-440], ebx
	mov	eax, DWORD PTR [ebp-440]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 89 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-444], ebx
	mov	edx, DWORD PTR [ebp-444]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-448], ebx
	mov	eax, DWORD PTR [ebp-448]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-452], ebx
	mov	eax, DWORD PTR [ebp-452]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 56
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 89 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-456], ebx
	mov	edx, DWORD PTR [ebp-456]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-460], ebx
	mov	eax, DWORD PTR [ebp-460]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-464], ebx
	mov	eax, DWORD PTR [ebp-464]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 60
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 89 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-468], ebx
	mov	edx, DWORD PTR [ebp-468]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-472], ebx
	mov	eax, DWORD PTR [ebp-472]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 89 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-476], ebx
	mov	eax, DWORD PTR [ebp-476]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	xor	eax, edx
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-480], ebx
	mov	edx, DWORD PTR [ebp-480]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-484], ebx
	mov	eax, DWORD PTR [ebp-484]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-488], ebx
	mov	eax, DWORD PTR [ebp-488]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 4
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 90 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-492], ebx
	mov	edx, DWORD PTR [ebp-492]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-496], ebx
	mov	eax, DWORD PTR [ebp-496]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-500], ebx
	mov	eax, DWORD PTR [ebp-500]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 90 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-504], ebx
	mov	edx, DWORD PTR [ebp-504]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-508], ebx
	mov	eax, DWORD PTR [ebp-508]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-512], ebx
	mov	eax, DWORD PTR [ebp-512]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 12
	mov	edx, DWORD PTR [ebp-28]
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 90 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-516], ebx
	mov	edx, DWORD PTR [ebp-516]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-520], ebx
	mov	eax, DWORD PTR [ebp-520]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 90 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-524], ebx
	mov	eax, DWORD PTR [ebp-524]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 16
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 91 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-528], ebx
	mov	edx, DWORD PTR [ebp-528]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-532], ebx
	mov	eax, DWORD PTR [ebp-532]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-536], ebx
	mov	eax, DWORD PTR [ebp-536]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 20
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 91 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-540], ebx
	mov	edx, DWORD PTR [ebp-540]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-544], ebx
	mov	eax, DWORD PTR [ebp-544]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-548], ebx
	mov	eax, DWORD PTR [ebp-548]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 24
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 91 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-552], ebx
	mov	edx, DWORD PTR [ebp-552]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-556], ebx
	mov	eax, DWORD PTR [ebp-556]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-560], ebx
	mov	eax, DWORD PTR [ebp-560]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 91 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-564], ebx
	mov	edx, DWORD PTR [ebp-564]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-568], ebx
	mov	eax, DWORD PTR [ebp-568]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	add	eax, 1859775393
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 91 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-572], ebx
	mov	eax, DWORD PTR [ebp-572]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 92 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-576], ebx
	mov	edx, DWORD PTR [ebp-576]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-580], ebx
	mov	eax, DWORD PTR [ebp-580]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-584], ebx
	mov	eax, DWORD PTR [ebp-584]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 36
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 92 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-588], ebx
	mov	edx, DWORD PTR [ebp-588]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-592], ebx
	mov	eax, DWORD PTR [ebp-592]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-596], ebx
	mov	eax, DWORD PTR [ebp-596]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 40
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 92 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-600], ebx
	mov	edx, DWORD PTR [ebp-600]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-604], ebx
	mov	eax, DWORD PTR [ebp-604]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-608], ebx
	mov	eax, DWORD PTR [ebp-608]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 44
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 92 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-612], ebx
	mov	edx, DWORD PTR [ebp-612]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-616], ebx
	mov	eax, DWORD PTR [ebp-616]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 92 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-620], ebx
	mov	eax, DWORD PTR [ebp-620]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 48
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 93 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-624], ebx
	mov	edx, DWORD PTR [ebp-624]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-628], ebx
	mov	eax, DWORD PTR [ebp-628]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-632], ebx
	mov	eax, DWORD PTR [ebp-632]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 93 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-636], ebx
	mov	edx, DWORD PTR [ebp-636]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-640], ebx
	mov	eax, DWORD PTR [ebp-640]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-644], ebx
	mov	eax, DWORD PTR [ebp-644]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 56
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 93 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-648], ebx
	mov	edx, DWORD PTR [ebp-648]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-652], ebx
	mov	eax, DWORD PTR [ebp-652]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-656], ebx
	mov	eax, DWORD PTR [ebp-656]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 60
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 93 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-660], ebx
	mov	edx, DWORD PTR [ebp-660]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-664], ebx
	mov	eax, DWORD PTR [ebp-664]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 93 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-668], ebx
	mov	eax, DWORD PTR [ebp-668]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	xor	eax, edx
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-672], ebx
	mov	edx, DWORD PTR [ebp-672]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-676], ebx
	mov	eax, DWORD PTR [ebp-676]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-680], ebx
	mov	eax, DWORD PTR [ebp-680]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 4
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 94 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-684], ebx
	mov	edx, DWORD PTR [ebp-684]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-688], ebx
	mov	eax, DWORD PTR [ebp-688]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-692], ebx
	mov	eax, DWORD PTR [ebp-692]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 94 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-696], ebx
	mov	edx, DWORD PTR [ebp-696]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-700], ebx
	mov	eax, DWORD PTR [ebp-700]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-704], ebx
	mov	eax, DWORD PTR [ebp-704]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 12
	mov	edx, DWORD PTR [ebp-28]
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 94 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-708], ebx
	mov	edx, DWORD PTR [ebp-708]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-712], ebx
	mov	eax, DWORD PTR [ebp-712]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 94 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-716], ebx
	mov	eax, DWORD PTR [ebp-716]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 16
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 95 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-720], ebx
	mov	edx, DWORD PTR [ebp-720]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-724], ebx
	mov	eax, DWORD PTR [ebp-724]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-728], ebx
	mov	eax, DWORD PTR [ebp-728]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 20
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 95 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-732], ebx
	mov	edx, DWORD PTR [ebp-732]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-736], ebx
	mov	eax, DWORD PTR [ebp-736]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-740], ebx
	mov	eax, DWORD PTR [ebp-740]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 24
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 95 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-744], ebx
	mov	edx, DWORD PTR [ebp-744]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-748], ebx
	mov	eax, DWORD PTR [ebp-748]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-752], ebx
	mov	eax, DWORD PTR [ebp-752]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 95 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-756], ebx
	mov	edx, DWORD PTR [ebp-756]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-760], ebx
	mov	eax, DWORD PTR [ebp-760]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 95 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-764], ebx
	mov	eax, DWORD PTR [ebp-764]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 96 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-768], ebx
	mov	edx, DWORD PTR [ebp-768]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-772], ebx
	mov	eax, DWORD PTR [ebp-772]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-776], ebx
	mov	eax, DWORD PTR [ebp-776]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 36
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 96 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-780], ebx
	mov	edx, DWORD PTR [ebp-780]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-784], ebx
	mov	eax, DWORD PTR [ebp-784]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-788], ebx
	mov	eax, DWORD PTR [ebp-788]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 40
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 96 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-792], ebx
	mov	edx, DWORD PTR [ebp-792]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-796], ebx
	mov	eax, DWORD PTR [ebp-796]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-800], ebx
	mov	eax, DWORD PTR [ebp-800]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	or	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, edx
	and	ebx, eax
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	and	eax, edx
	mov	esi, ebx
	or	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 44
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 96 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-804], ebx
	mov	edx, DWORD PTR [ebp-804]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-808], ebx
	mov	eax, DWORD PTR [ebp-808]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 1894007588
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 96 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-812], ebx
	mov	eax, DWORD PTR [ebp-812]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 48
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 97 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-816], ebx
	mov	edx, DWORD PTR [ebp-816]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-820], ebx
	mov	eax, DWORD PTR [ebp-820]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-824], ebx
	mov	eax, DWORD PTR [ebp-824]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 97 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-828], ebx
	mov	edx, DWORD PTR [ebp-828]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-832], ebx
	mov	eax, DWORD PTR [ebp-832]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-836], ebx
	mov	eax, DWORD PTR [ebp-836]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 56
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 97 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-840], ebx
	mov	edx, DWORD PTR [ebp-840]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-844], ebx
	mov	eax, DWORD PTR [ebp-844]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-848], ebx
	mov	eax, DWORD PTR [ebp-848]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 60
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 97 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-852], ebx
	mov	edx, DWORD PTR [ebp-852]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-856], ebx
	mov	eax, DWORD PTR [ebp-856]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 97 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-860], ebx
	mov	eax, DWORD PTR [ebp-860]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	eax, DWORD PTR [eax]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	xor	eax, edx
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-864], ebx
	mov	edx, DWORD PTR [ebp-864]
	mov	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-28]
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-868], ebx
	mov	eax, DWORD PTR [ebp-868]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-872], ebx
	mov	eax, DWORD PTR [ebp-872]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 4
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 98 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-876], ebx
	mov	edx, DWORD PTR [ebp-876]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-880], ebx
	mov	eax, DWORD PTR [ebp-880]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-884], ebx
	mov	eax, DWORD PTR [ebp-884]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 8
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 98 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-888], ebx
	mov	edx, DWORD PTR [ebp-888]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-892], ebx
	mov	eax, DWORD PTR [ebp-892]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-896], ebx
	mov	eax, DWORD PTR [ebp-896]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 12
	mov	edx, DWORD PTR [ebp-28]
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 98 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-900], ebx
	mov	edx, DWORD PTR [ebp-900]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-904], ebx
	mov	eax, DWORD PTR [ebp-904]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 98 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-908], ebx
	mov	eax, DWORD PTR [ebp-908]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 16
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 99 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-912], ebx
	mov	edx, DWORD PTR [ebp-912]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-916], ebx
	mov	eax, DWORD PTR [ebp-916]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-920], ebx
	mov	eax, DWORD PTR [ebp-920]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 20
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 99 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-924], ebx
	mov	edx, DWORD PTR [ebp-924]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-928], ebx
	mov	eax, DWORD PTR [ebp-928]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-932], ebx
	mov	eax, DWORD PTR [ebp-932]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 24
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 99 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-936], ebx
	mov	edx, DWORD PTR [ebp-936]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-940], ebx
	mov	eax, DWORD PTR [ebp-940]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-944], ebx
	mov	eax, DWORD PTR [ebp-944]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 28
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 99 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-948], ebx
	mov	edx, DWORD PTR [ebp-948]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-952], ebx
	mov	eax, DWORD PTR [ebp-952]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 99 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-956], ebx
	mov	eax, DWORD PTR [ebp-956]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 32
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 100 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-960], ebx
	mov	edx, DWORD PTR [ebp-960]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-964], ebx
	mov	eax, DWORD PTR [ebp-964]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-968], ebx
	mov	eax, DWORD PTR [ebp-968]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 36
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 100 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-972], ebx
	mov	edx, DWORD PTR [ebp-972]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-976], ebx
	mov	eax, DWORD PTR [ebp-976]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-980], ebx
	mov	eax, DWORD PTR [ebp-980]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 40
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 8
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 100 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-984], ebx
	mov	edx, DWORD PTR [ebp-984]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-988], ebx
	mov	eax, DWORD PTR [ebp-988]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-992], ebx
	mov	eax, DWORD PTR [ebp-992]
	mov	DWORD PTR [ebp-1064], eax
	mov	ecx, DWORD PTR [ebp-1056]
	mov	edx, DWORD PTR [ebp-1068]
	mov	eax, DWORD PTR [ebp-1064]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 44
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 32
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 12
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 100 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-996], ebx
	mov	edx, DWORD PTR [ebp-996]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1000], ebx
	mov	eax, DWORD PTR [ebp-1000]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1056], eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 100 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1004], ebx
	mov	eax, DWORD PTR [ebp-1004]
	mov	DWORD PTR [ebp-1068], eax
	mov	ecx, DWORD PTR [ebp-1060]
	mov	edx, DWORD PTR [ebp-1072]
	mov	eax, DWORD PTR [ebp-1068]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 48
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 36
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 16
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 101 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1008], ebx
	mov	edx, DWORD PTR [ebp-1008]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1012], ebx
	mov	eax, DWORD PTR [ebp-1012]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1060], eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1016], ebx
	mov	eax, DWORD PTR [ebp-1016]
	mov	DWORD PTR [ebp-1072], eax
	mov	ecx, DWORD PTR [ebp-1064]
	mov	edx, DWORD PTR [ebp-1056]
	mov	eax, DWORD PTR [ebp-1072]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1068]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 52
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 40
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 20
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 52
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 101 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1020], ebx
	mov	edx, DWORD PTR [ebp-1020]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1024], ebx
	mov	eax, DWORD PTR [ebp-1024]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1028], ebx
	mov	eax, DWORD PTR [ebp-1028]
	mov	DWORD PTR [ebp-1056], eax
	mov	ecx, DWORD PTR [ebp-1068]
	mov	edx, DWORD PTR [ebp-1060]
	mov	eax, DWORD PTR [ebp-1056]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1072]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 56
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 44
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 24
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 56
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 101 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1032], ebx
	mov	edx, DWORD PTR [ebp-1032]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1036], ebx
	mov	eax, DWORD PTR [ebp-1036]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1068], eax
	mov	eax, DWORD PTR [ebp-1060]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1040], ebx
	mov	eax, DWORD PTR [ebp-1040]
	mov	DWORD PTR [ebp-1060], eax
	mov	ecx, DWORD PTR [ebp-1072]
	mov	edx, DWORD PTR [ebp-1064]
	mov	eax, DWORD PTR [ebp-1060]
	xor	edx, eax
	mov	eax, DWORD PTR [ebp-1056]
	mov	esi, edx
	xor	esi, eax
	mov	eax, DWORD PTR [ebp-28]
	add	eax, 60
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 48
	mov	ebx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 28
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 4
	mov	edx, DWORD PTR [edx]
	xor	ebx, edx
	mov	edx, DWORD PTR [ebp-28]
	add	edx, 60
	mov	edx, DWORD PTR [edx]
	xor	edx, ebx
	mov	ebx, edx
#APP
# 101 "sha1.c" 1
	rol 1,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1044], ebx
	mov	edx, DWORD PTR [ebp-1044]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [eax]
	lea	edx, [esi+eax]
	mov	eax, DWORD PTR [ebp-1068]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	rol 5,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1048], ebx
	mov	eax, DWORD PTR [ebp-1048]
	lea	eax, [edx+eax]
	lea	eax, [ecx+eax]
	sub	eax, 899497514
	mov	DWORD PTR [ebp-1072], eax
	mov	eax, DWORD PTR [ebp-1064]
	mov	ebx, eax
#APP
# 101 "sha1.c" 1
	ror 2,ebx
# 0 "" 2
#NO_APP
	mov	DWORD PTR [ebp-1052], ebx
	mov	eax, DWORD PTR [ebp-1052]
	mov	DWORD PTR [ebp-1064], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp-1072]
	add	edx, eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 4
	mov	edx, DWORD PTR [ebp+8]
	add	edx, 4
	mov	ecx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-1068]
	lea	edx, [ecx+edx]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 8
	mov	edx, DWORD PTR [ebp+8]
	add	edx, 8
	mov	ecx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-1064]
	lea	edx, [ecx+edx]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 12
	mov	edx, DWORD PTR [ebp+8]
	add	edx, 12
	mov	ecx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-1060]
	lea	edx, [ecx+edx]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 16
	mov	edx, DWORD PTR [ebp+8]
	add	edx, 16
	mov	ecx, DWORD PTR [edx]
	mov	edx, DWORD PTR [ebp-1056]
	lea	edx, [ecx+edx]
	mov	DWORD PTR [eax], edx
	add	esp, 1084
	pop	ebx
	pop	esi
	pop	edi
	pop	ebp
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
	movzx	edx, BYTE PTR zEncode.2559[eax]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax], dl
	add	DWORD PTR [ebp+12], 1
	mov	eax, DWORD PTR [ebp+8]
	movzx	eax, BYTE PTR [eax]
	movzx	eax, al
	and	eax, 15
	movzx	edx, BYTE PTR zEncode.2559[eax]
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
	.type	zEncode.2559, @object
	.size	zEncode.2559, 17
zEncode.2559:
	.string	"0123456789abcdef"
	.ident	"GCC: (Ubuntu/Linaro 4.5.2-8ubuntu4) 4.5.2"
	.section	.note.GNU-stack,"",@progbits
