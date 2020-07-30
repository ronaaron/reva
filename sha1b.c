/*
 ** This implementation of SHA1.
 */
#include <sys/types.h>
#include <stdio.h>
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
	unsigned char buffer[64];
	unsigned int state[5];
	unsigned int count[2];
};

/*
 * blk0() and blk() perform the initial expand.
 * I got the idea of expanding during the round function from SSLeay
 */
//#define rolme(value, bits) (((value) << (bits)) | ((value) >> (32 - (bits))))
#if 1
 __attribute__((fastcall,noinline))
unsigned int  rolme(unsigned int value, unsigned int bits) 
{
	asm("rol eax, cl" : :"a"(value),"c"(bits));
//	return value << bits
//		| value >> (32-bits);
}
#else
#define rolme(value,bits) \
	(value << bits | value >> (32-bits))
#endif
#define blk0 (block[offset] = (rolme(block[offset],24)&0xFF00FF00) \
		|(rolme(block[offset],8)&0x00FF00FF))
#define blk (block[offset&15] = rolme(block[(offset+13)&15]^block[(offset+8)&15] \
			^block[(offset+2)&15]^block[offset&15],1))


/*
 * (R0+R1), R2, R3, R4 are the different operations (rounds) used in SHA1
 *
 * R0() for little-endian and Rb0() for big-endian.  Endianness is 
 * determined at run-time.
 */
// a b c d e  -> e a b c d
#define SHIFT\
	q[1]=rolme(q[1],30);\
	qq=q[4];\
	q[4]=q[3];\
	q[3]=q[2];\
	q[2]=q[1];\
	q[1]=q[0];\
	q[0]=qq;\
	++offset;
// v=q[0], w=q[1], x=q[2], y=q[3], z=q[4]
#define R0 \
	q[4]+=((q[1]&(q[2]^q[3]))^q[3])+ \
	blk0+\
	0x5A827999+\
	rolme(q[0],5);\
	SHIFT;
#define R1 \
	q[4]+=((q[1]&(q[2]^q[3]))^q[3])+\
	blk+\
	0x5A827999+\
	rolme(q[0],5);\
	SHIFT;
#define R2 \
	q[4]+=(q[1]^q[2]^q[3])+\
	blk+\
	0x6ED9EBA1+\
	rolme(q[0],5);\
	SHIFT;
#define R3 \
	q[4]+=(((q[1]|q[2])&q[3])|(q[1]&q[2]))+\
	blk+\
	0x8F1BBCDC+\
	rolme(q[0],5);\
	SHIFT;
#define R4 \
	q[4]+=(q[1]^q[2]^q[3])+\
	blk+\
	0xCA62C1D6+\
	rolme(q[0],5);\
	SHIFT;

/*
 * Hash a single 512-bit block. This is the core of the algorithm.
 */
void SHA1Transform(unsigned int state[5], const unsigned char buffer[64])
{
	unsigned int q[5], qq; //a, b, c, d, e;
	unsigned int *block =(unsigned int *)buffer;

	/* Copy context->state[] to working vars */
	/*
	a = state[0];
	b = state[1];
	c = state[2];
	d = state[3];
	e = state[4];
	*/
	int ix;
	int offset=0;
	memcpy(q, state, 5 * sizeof(unsigned int));

	/* 4 rounds of 20 operations each. Loop unrolled. */
	R0; R0; R0; R0;
	R0; R0; R0; R0;
	R0; R0; R0; R0;
	R0; R0; R0; R0;
	R1; R1; R1; R1;

	R2; R2; R2; R2;
	R2; R2; R2; R2;
	R2; R2; R2; R2;
	R2; R2; R2; R2;
	R2; R2; R2; R2;

	R3; R3; R3; R3;
	R3; R3; R3; R3;
	R3; R3; R3; R3;
	R3; R3; R3; R3;
	R3; R3; R3; R3;

	R4; R4; R4; R4;
	R4; R4; R4; R4;
	R4; R4; R4; R4;
	R4; R4; R4; R4;
	R4; R4; R4; R4;

	/* Add the working vars back into context.state[] */
	/*
	state[0] += a;
	state[1] += b;
	state[2] += c;
	state[3] += d;
	state[4] += e;
	*/
	for (ix=0; ix<5; ix++)
		state[ix] += q[ix];

}


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
static void SHA1Update(
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
		SHA1Transform(context->state, context->buffer);
		for ( ; i + 63 < len; i += 64)
			SHA1Transform(context->state, &data[i]);
		j = 0;
	} else {
		i = 0;
	}
	(void)memcpy(&context->buffer[j], &data[i], len - i);
}


/*
 * Add padding and return the message digest.
 */
static void SHA1Final(SHA1Context *context, unsigned char digest[20]){
	unsigned int i;
	unsigned char finalcount[8];

	for (i = 0; i < 8; i++) {
		finalcount[i] = (unsigned char)((context->count[(i >= 4 ? 0 : 1)]
					>> ((3-(i & 3)) * 8) ) & 255);	 /* Endian independent */
	}
	SHA1Update(context, (const unsigned char *)"\200", 1);
	while ((context->count[0] & 504) != 448)
		SHA1Update(context, (const unsigned char *)"\0", 1);
	SHA1Update(context, finalcount, 8);  /* Should cause a SHA1Transform() */

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
	int i, j;

	for(j=i=0; i<20; i++){
		int a = digest[i];
		zBuf[j++] = zEncode[(a>>4)&0xf];
		zBuf[j++] = zEncode[a & 0xf];
	}
	zBuf[j] = 0;
}

/*
 ** The state of a incremental SHA1 checksum computation.  Only one
 ** such computation can be underway at a time, of course.
 */
static SHA1Context incrCtx;
static int incrInit = 0;


/*
 ** Compute the SHA1 checksum of a file on disk.  Store the resulting
 ** checksum in the blob pCksum.  pCksum is assumed to be ininitialized.
 */
char thesum [64];
char * sha1sum_file(const char *zFilename){
	FILE *in;
	SHA1Context ctx;
	unsigned char zResult[20];
	char zBuf[10240];

	in = fopen(zFilename,"rb");
	if( in==0 ){
		return NULL;
	}
	SHA1Init(&ctx);
	for(;;){
		int n;
		n = fread(zBuf, 1, sizeof(zBuf), in);
		if( n<=0 ) break;
		SHA1Update(&ctx, (unsigned char*)zBuf, (unsigned)n);
	}
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
	SHA1Update(&ctx, (unsigned const char*)zIn, strlen(zIn));
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
