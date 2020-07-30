sha1: sha1.c sha1transform.o
	gcc -o sha1  sha1.c sha1transform.o

sha1a: sha1.c
	gcc -o sha1a  sha1.c

sha1transform.o: sha1transform.asm
	nasm -felf32 sha1transform.asm

debug: sha1
	gdb -x gdb.gdb   ./sha1

test: sha1
	./sha1 README

bench: sha1
	bash bench.sh
