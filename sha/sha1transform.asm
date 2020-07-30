; vim: ft=nasm: 
global sha1transform
global sha1update

; C called w/ parameters 
;   unsigned int state[5], const unsigned char buffer[64]
; We need seven variables:
;    [esp+4] unsigned int *block --> buffer
;    ebx state[0]
;    ecx state[1]
;    edx state[2]
;    esi state[3]
;    edi state[4]

;%define STATE [esp+40]
%define CODESECTION SECTION .wtext 
%define DATASECTION SECTION .data
%define BSSSECTION SECTION .bss

CODESECTION
%define STATE [esp+(4*9)]
%define BUFFER [esp+(4*10)]

;#define blk0(i) (block[i] = (ror(block[i],8)&0xFF00FF00) \
;		|(rol(block[i],8)&0x00FF00FF))
%macro BLK0 1
	push ebx
	push eax
	
	mov ebp, [__buffer]
;	mov ebp, [esp+48]
	%if (%1 == 0)
		mov eax, [ebp]
	%else
		mov eax, [ebp+4*%1]
	%endif
	mov ebx, eax
	ror eax, 8
	rol ebx, 8
	and eax, 0xFF00FF00
	and ebx, 0X00FF00FF
	or ebx, eax
	%if (%1 == 0)
		mov [ebp], ebx
	%else
		mov [ebp+4*%1], ebx
	%endif

	pop eax
	add eax, ebx
	pop ebx
;	add eax,[ebp+4*%1]

%endmacro
; #define blk(i) (block[i&15] = rol(block[(i+13)&15]^block[(i+8)&15] \
; 			^block[(i+2)&15]^block[i&15],1))
%macro BLK 1
	push eax
	mov ebp, [__buffer]
	;mov ebp, [esp+44]

	mov eax, [ebp+4*((%1+13)&15)]
	xor eax, [ebp+4*((%1+8)&15)]
	xor eax, [ebp+4*((%1+2)&15)]
	xor eax, [ebp+4*(%1&15)] 
	rol eax, 1

	mov [ebp+4*(%1&15)], eax 

	pop eax
	add eax,[ebp+4*(%1&15)]
%endmacro

; v=%1, w=%2, x=%3, y=%4, z=%5, i=%6
; z+=0x5A827999+((w&(x^y))^y)+blk0(i)+rol(v,5);MIX(w);

; %1=const, %2=index, %3=v, %4=z, %5=w
%macro MIX0 5
	add eax, %1
	BLK0 %2
	mov ebp, %3
	rol ebp, 5
	add eax, ebp
	add %4, eax		; z += eax
	ror %5, 2
%endmacro
%macro MIX 5
	add eax, %1
	BLK %2
	mov ebp, %3
	rol ebp, 5
	add eax, ebp
	add %4, eax		; z += eax
	ror %5, 2
%endmacro

; #define R0(v,w,x,y,z,i) \
; 	z+=0x5A827999+((w&(x^y))^y)+blk0(i)+rol(v,5);MIX(w);
; w&x or (!w)&y
; y ^ ( w & ( x ^ y))
%macro R0 6
	; (w&(x^y))^y
	mov eax, %3
	xor eax, %4
	and eax, %2
	xor eax, %4
	MIX0 0x5a827999, %6, %1, %5, %2
%endmacro
;#define R1(v,w,x,y,z,i) \
;	z+=0x5A827999+((w&(x^y))^y)+blk(i)+rol(v,5);MIX(w);
%macro R1 6
	; (w&(x^y))^y
	mov eax, %3
	xor eax, %4
	and eax, %2
	xor eax, %4
	MIX 0x5a827999, %6, %1, %5, %2
%endmacro
;#define R2(v,w,x,y,z,i) \
;	z+=0x6ED9EBA1+(w^x^y)+blk(i)+rol(v,5);MIX(w);
%macro R2 6
	; w^x^y
	mov eax, %2
	xor eax, %3
	xor eax, %4
	MIX 0x6ED9EBA1, %6, %1, %5, %2
%endmacro
;#define R3(v,w,x,y,z,i) \
;	z+=0x8F1BBCDC+(((w|x)&y)|(w&x))+blk(i)+rol(v,5);MIX(w);
%macro R3 6
	; (((w|x)&y)|(w&x))
	mov eax, %2
	or eax, %3
	and eax, %4
	mov ebp, %2
	and ebp, %3
	or eax, ebp
	MIX 0x8F1BBCDC, %6, %1, %5, %2
%endmacro
;#define R4(v,w,x,y,z,i) \
;	z+=0xCA62C1D6+(w^x^y)+blk(i)+rol(v,5);MIX(w);
%macro R4 6
	; w^x^y
	mov eax, %2
	xor eax, %3
	xor eax, %4
	MIX 0xCA62C1D6, %6, %1, %5, %2
%endmacro

%define A ebx
%define B ecx
%define C edx
%define D esi
%define E edi

ALIGN 16
sha1transform: ; state[5]=esp+8, buffer[64]=esp+12
	pusha

	mov eax, BUFFER
	mov [__buffer], eax
	mov eax, STATE
;	push eax

	mov A, [eax]		; state[0]
	mov B, [eax+4]
	mov C, [eax+8]
	mov D, [eax+12]
	mov E, [eax+16]

	R0 A, B, C, D, E, 0
	R0 E, A, B, C, D, 1
	R0 D, E, A, B, C, 2
	R0 C, D, E, A, B, 3
	R0 B, C, D, E, A, 4

	R0 A, B, C, D, E, 5
	R0 E, A, B, C, D, 6
	R0 D, E, A, B, C, 7
	R0 C, D, E, A, B, 8
	R0 B, C, D, E, A, 9

	R0 A, B, C, D, E, 10
	R0 E, A, B, C, D, 11
	R0 D, E, A, B, C, 12
	R0 C, D, E, A, B, 13
	R0 B, C, D, E, A, 14

	R0 A, B, C, D, E, 15
	R1 E, A, B, C, D, 16
	R1 D, E, A, B, C, 17
	R1 C, D, E, A, B, 18
	R1 B, C, D, E, A, 19

	R2 A, B, C, D, E, 20
	R2 E, A, B, C, D, 21
	R2 D, E, A, B, C, 22
	R2 C, D, E, A, B, 23
	R2 B, C, D, E, A, 24

	R2 A, B, C, D, E, 25
	R2 E, A, B, C, D, 26
	R2 D, E, A, B, C, 27
	R2 C, D, E, A, B, 28
	R2 B, C, D, E, A, 29

	R2 A, B, C, D, E, 30
	R2 E, A, B, C, D, 31
	R2 D, E, A, B, C, 32
	R2 C, D, E, A, B, 33
	R2 B, C, D, E, A, 34

	R2 A, B, C, D, E, 35
	R2 E, A, B, C, D, 36
	R2 D, E, A, B, C, 37
	R2 C, D, E, A, B, 38
	R2 B, C, D, E, A, 39

	R3 A, B, C, D, E, 40
	R3 E, A, B, C, D, 41
	R3 D, E, A, B, C, 42
	R3 C, D, E, A, B, 43
	R3 B, C, D, E, A, 44

	R3 A, B, C, D, E, 45
	R3 E, A, B, C, D, 46
	R3 D, E, A, B, C, 47
	R3 C, D, E, A, B, 48
	R3 B, C, D, E, A, 49

	R3 A, B, C, D, E, 50
	R3 E, A, B, C, D, 51
	R3 D, E, A, B, C, 52
	R3 C, D, E, A, B, 53
	R3 B, C, D, E, A, 54

	R3 A, B, C, D, E, 55
	R3 E, A, B, C, D, 56
	R3 D, E, A, B, C, 57
	R3 C, D, E, A, B, 58
	R3 B, C, D, E, A, 59

	R4 A, B, C, D, E, 60
	R4 E, A, B, C, D, 61
	R4 D, E, A, B, C, 62
	R4 C, D, E, A, B, 63
	R4 B, C, D, E, A, 64

	R4 A, B, C, D, E, 65
	R4 E, A, B, C, D, 66
	R4 D, E, A, B, C, 67
	R4 C, D, E, A, B, 68
	R4 B, C, D, E, A, 69

	R4 A, B, C, D, E, 70
	R4 E, A, B, C, D, 71
	R4 D, E, A, B, C, 72
	R4 C, D, E, A, B, 73
	R4 B, C, D, E, A, 74

	R4 A, B, C, D, E, 75
	R4 E, A, B, C, D, 76
	R4 D, E, A, B, C, 77
	R4 C, D, E, A, B, 78
	R4 B, C, D, E, A, 79
	
;	pop ebp
	mov ebp, STATE
	add [ebp], A
	add [ebp+4], B
	add [ebp+8], C
	add [ebp+12], D 
	add [ebp+16], E

	popa
	ret

ALIGN 16
; static void SHA1Update( SHA1Context *context, const unsigned char *data, unsigned int len
;	unsigned int i, j;
;
;	j = context->count[0];
;	if ((context->count[0] += len << 3) < j)
;		context->count[1] += (len>>29)+1;
;	j = (j >> 3) & 63;
;	if ((j + len) > 63) {
;		(void)memcpy(&context->buffer[j], data, (i = 64-j));
;		sha1transform(context->state, context->buffer);
;		for ( ; i + 63 < len; i += 64)
;			sha1transform(context->state, &data[i]);
;		j = 0;
;	} else {
;		i = 0;
;	}
;	(void)memcpy(&context->buffer[j], &data[i], len - i);

extern memcpy
%define CONTEXT [esp+4*9]
%define DATA [esp+4*10]
%define LEN [esp+4*11]
sha1update:
	pusha
	mov ebx, CONTEXT
	mov eax, [ebx]		; j = context->count[0]
	mov ecx, LEN
	mov edx, [ebx+4]	; context->count[1]
	mov esi, ecx
	shl esi, 3
	add [ebx], esi		; count[0] += len << 3
	cmp [ebx], eax
	jge jnotless
	; context->count[1] += (len>>29)+1
	mov esi, ecx
	shr esi, 29
	inc esi
	add [ebx+4], esi	; count[1] += (len>>29)+1

jnotless:
	shl eax, 3
	and eax, 63
	mov esi, eax
	add esi, ecx
	cmp esi, 63
	jle izero
	; 
	mov edi, CONTEXT
	mov eax, [edi]
	lea edi, [edi+7*4]		; edi <-buffer
	lea edi, [edi+4*eax]		; edi <-&buffer[j]
	mov esi, DATA


;	(void)memcpy(&context->buffer[j], data, (i = 64-j));
;	sha1transform(context->state, context->buffer);
;	for ( ; i + 63 < len; i += 64)
;		sha1transform(context->state, &data[i]);
izero:

	popa
	ret


BSSSECTION
__buffer resd 1

