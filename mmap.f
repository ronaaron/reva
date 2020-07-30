| on linux ...

6 func: mmap | addr len prot flags fd offset
2 func: munmap

: memmap ( fd n -- b n )
	swap >r					| n r:fd
	0 over					| n 0 n r:h
	3 1 r@ 0 
	mmap swap
	r> close
	;
: slurp2 ( a n -- b m )
	open/rw dup fsize
	memmap
	;


