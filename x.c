
+8 +12
unsigned int SHA1Transform(unsigned int state[5], const unsigned char buffer[64])
{
	unsigned char x=buffer[1];
	return state[2] + x;
}

void main(void)
{
	SHA1Transform(0, 0);
}
