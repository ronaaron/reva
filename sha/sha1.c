/*
 ** This implementation of SHA1.
 */
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>


/*
 ** The SHA1 implementation below is adapted from:
 **
 **  $NetBSD: sha1.c,v 1.6 2009/11/06 20:31:18 joerg Exp $
 **  $OpenBSD: sha1.c,v 1.9 1997/07/23 21:12:32 kstailey Exp $
 **
 ** SHA-1 in C
 ** By Steve Reid <steve@edmweb.com>
 ** 100% Public Domain
 */
typedef struct SHA1Context SHA1Context;
struct SHA1Context {
	unsigned int count[2];
	unsigned int state[5];
	unsigned char buffer[64];
};

#if 1
extern void sha1transform(unsigned int state[5], const unsigned char buffer[64]);
#else
/*
 * blk0() and blk() perform the initial expand.
 * I got the idea of expanding during the round function from SSLeay
 */

#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
#define rol(x,n)	SHA_ASM("rol", x, n)
#define ror(x,n)	SHA_ASM("ror", x, n)
#define blk0(i) (block[i] = (ror(block[i],8)&0xFF00FF00) \
		|(rol(block[i],8)&0x00FF00FF))
#define blk(i) (block[i&15] = rol(block[(i+13)&15]^block[(i+8)&15] \
			^block[(i+2)&15]^block[i&15],1))


/*
 * (R0+R1), R2, R3, R4 are the different operations (rounds) used in SHA1
 *
 * R0() for little-endian and Rb0() for big-endian.  Endianness is 
 * determined at run-time.
 */
#define MIX(w) \
	w=ror(w,2);
#define R0(v,w,x,y,z,i) \
	z+=0x5A827999+((w&(x^y))^y)+blk0(i)+rol(v,5);MIX(w);
#define R1(v,w,x,y,z,i) \
	z+=0x5A827999+((w&(x^y))^y)+blk(i)+rol(v,5);MIX(w);
#define R2(v,w,x,y,z,i) \
	z+=0x6ED9EBA1+(w^x^y)+blk(i)+rol(v,5);MIX(w);
#define R3(v,w,x,y,z,i) \
	z+=0x8F1BBCDC+(((w|x)&y)|(w&x))+blk(i)+rol(v,5);MIX(w);
#define R4(v,w,x,y,z,i) \
	z+=0xCA62C1D6+(w^x^y)+blk(i)+rol(v,5);MIX(w);

/*
 * Hash a single 512-bit block. This is the core of the algorithm.
 */
#define a qq[0]
#define b qq[1]
#define c qq[2]
#define d qq[3]
#define e qq[4]
__attribute__((fastcall))
void sha1transform(unsigned int state[5], const unsigned char buffer[64])
{
	unsigned int *block =(unsigned int *)buffer;
	unsigned int qq[5];

	/* Copy context->state[] to working vars */
	memcpy(qq,state,5*sizeof(unsigned int));


	/* 4 rounds of 20 operations each. Loop unrolled. */
	R0(a,b,c,d,e, 0); R0(e,a,b,c,d, 1); R0(d,e,a,b,c, 2); R0(c,d,e,a,b, 3);
	R0(b,c,d,e,a, 4); R0(a,b,c,d,e, 5); R0(e,a,b,c,d, 6); R0(d,e,a,b,c, 7);
	R0(c,d,e,a,b, 8); R0(b,c,d,e,a, 9); R0(a,b,c,d,e,10); R0(e,a,b,c,d,11);
	R0(d,e,a,b,c,12); R0(c,d,e,a,b,13); R0(b,c,d,e,a,14); R0(a,b,c,d,e,15);

	R1(e,a,b,c,d,16); R1(d,e,a,b,c,17); R1(c,d,e,a,b,18); R1(b,c,d,e,a,19);
	R2(a,b,c,d,e,20); R2(e,a,b,c,d,21); R2(d,e,a,b,c,22); R2(c,d,e,a,b,23);
	R2(b,c,d,e,a,24); R2(a,b,c,d,e,25); R2(e,a,b,c,d,26); R2(d,e,a,b,c,27);
	R2(c,d,e,a,b,28); R2(b,c,d,e,a,29); R2(a,b,c,d,e,30); R2(e,a,b,c,d,31);
	R2(d,e,a,b,c,32); R2(c,d,e,a,b,33); R2(b,c,d,e,a,34); R2(a,b,c,d,e,35);
	R2(e,a,b,c,d,36); R2(d,e,a,b,c,37); R2(c,d,e,a,b,38); R2(b,c,d,e,a,39);
	R3(a,b,c,d,e,40); R3(e,a,b,c,d,41); R3(d,e,a,b,c,42); R3(c,d,e,a,b,43);
	R3(b,c,d,e,a,44); R3(a,b,c,d,e,45); R3(e,a,b,c,d,46); R3(d,e,a,b,c,47);
	R3(c,d,e,a,b,48); R3(b,c,d,e,a,49); R3(a,b,c,d,e,50); R3(e,a,b,c,d,51);
	R3(d,e,a,b,c,52); R3(c,d,e,a,b,53); R3(b,c,d,e,a,54); R3(a,b,c,d,e,55);
	R3(e,a,b,c,d,56); R3(d,e,a,b,c,57); R3(c,d,e,a,b,58); R3(b,c,d,e,a,59);
	R4(a,b,c,d,e,60); R4(e,a,b,c,d,61); R4(d,e,a,b,c,62); R4(c,d,e,a,b,63);
	R4(b,c,d,e,a,64); R4(a,b,c,d,e,65); R4(e,a,b,c,d,66); R4(d,e,a,b,c,67);
	R4(c,d,e,a,b,68); R4(b,c,d,e,a,69); R4(a,b,c,d,e,70); R4(e,a,b,c,d,71);
	R4(d,e,a,b,c,72); R4(c,d,e,a,b,73); R4(b,c,d,e,a,74); R4(a,b,c,d,e,75);
	R4(e,a,b,c,d,76); R4(d,e,a,b,c,77); R4(c,d,e,a,b,78); R4(b,c,d,e,a,79);

	/* Add the working vars back into context.state[] */
	state[0] += a;
	state[1] += b;
	state[2] += c;
	state[3] += d;
	state[4] += e;
}
#endif


/*
 * SHA1Init - Initialize new context
 */
static void SHA1Init(SHA1Context *context){
	/* SHA1 initialization constants */
	context->state[0] = 0x67452301;
	context->state[1] = 0xEFCDAB89;
	context->state[2] = 0x98BADCFE;
	context->state[3] = 0x10325476;
	context->state[4] = 0xC3D2E1F0;
	context->count[0] = context->count[1] = 0;
}


/*
 * Run your data through this.
 */
#if 1
extern void sha1update(SHA1Context *context, const unsigned char *data, unsigned int len) ;
#else

__attribute__((fastcall))
static void sha1update(
		SHA1Context *context,
		const unsigned char *data,
		unsigned int len
		){
	unsigned int i, j;

	j = context->count[0];
	if ((context->count[0] += len << 3) < j)
		context->count[1] += (len>>29)+1;
	j = (j >> 3) & 63;
	if ((j + len) > 63) {
		(void)memcpy(&context->buffer[j], data, (i = 64-j));
		sha1transform(context->state, context->buffer);
		for ( ; i + 63 < len; i += 64)
			sha1transform(context->state, &data[i]);
		j = 0;
	} else {
		i = 0;
	}
	(void)memcpy(&context->buffer[j], &data[i], len - i);
}
#endif

/*
 * Add padding and return the message digest.
 */
__attribute__((fastcall))
static void SHA1Final(SHA1Context *context, unsigned char digest[20]){
	unsigned int i;
	unsigned char finalcount[8];

	for (i = 0; i < 8; i++) {
		finalcount[i] = (unsigned char)((context->count[(i >= 4 ? 0 : 1)]
					>> ((3-(i & 3)) * 8) ) & 255);	 /* Endian independent */
	}
	sha1update(context, (const unsigned char *)"\200", 1);
	while ((context->count[0] & 504) != 448)
		sha1update(context, (const unsigned char *)"\0", 1);
	sha1update(context, finalcount, 8);  /* Should cause a SHA1Transform() */

	if (digest) {
		for (i = 0; i < 20; i++)
			digest[i] = (unsigned char)
				((context->state[i>>2] >> ((3-(i & 3)) * 8) ) & 255);
	}
}


/*
 ** Convert a digest into base-16.  digest should be declared as
 ** "unsigned char digest[20]" in the calling function.  The SHA1
 ** digest is stored in the first 20 bytes.  zBuf should
 ** be "char zBuf[41]".
 */
static void DigestToBase16(unsigned char *digest, char *zBuf){
	static char const zEncode[] = "0123456789abcdef";
	int i;

	for(i=0; i<20; i++){
		*zBuf++ = zEncode[(*digest>>4)&0xf];
		*zBuf++ = zEncode[*digest++ & 0xf];
	}
	*zBuf = 0;
}

/*
 ** Compute the SHA1 checksum of a file on disk.  Store the resulting
 ** checksum in the blob pCksum.  pCksum is assumed to be ininitialized.
 */
static char thesum [64];
#define BUFSIZE 64*1024
char * sha1sum_file(const char *zFilename){
	FILE *in;
	int isStdIn = strcmp(zFilename, "-") == 0;
	SHA1Context ctx;
	unsigned char zResult[20];
	unsigned char *zBuf = (unsigned char *)malloc(BUFSIZE);

	in = isStdIn ? stdin : fopen(zFilename,"rb");
	if( in==0 ){
		return NULL;
	}
	SHA1Init(&ctx);
	for(;;){
		int n;
		n = fread(zBuf, 1, BUFSIZE, in);
		if( n<=0 ) break;
		sha1update(&ctx, (unsigned char*)zBuf, (unsigned)n);
	}
	free(zBuf);
	if (!isStdIn)
		fclose(in);
	SHA1Final(&ctx, zResult);
	DigestToBase16(zResult, thesum);
	return thesum;
}


/*
 ** Compute the SHA1 checksum of a zero-terminated string.  The
 ** result is held in memory obtained from mprintf().
 */
char *sha1sum(const char *zIn){
	SHA1Context ctx;
	unsigned char zResult[20];
	char zDigest[41];

	SHA1Init(&ctx);
	sha1update(&ctx, (unsigned const char*)zIn, strlen(zIn));
	SHA1Final(&ctx, zResult);
	DigestToBase16(zResult, thesum);
	return thesum;
}

int main ( int argc, char ** argv)
{
	int ix;
	for (ix=1; ix<argc; ix++)
	{
		char *sum = sha1sum_file(argv[ix]);
		printf("%s %s\n", sum, argv[ix]);
	}
	return 0;
}
