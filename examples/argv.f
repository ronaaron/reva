| example to create an 'argv' array for passing to C libraries

256 constant MAXARGV
create (argv) MAXARGV cells allot

: argv[]  ( -- argc argv[] )
	argc MAXARGV min dup		| argc' argc'
	0do
		i dup argv drop swap
		cells (argv) + !
	loop
	(argv)
	;

: do-argv
	argv[] swap 0do
		i dup .
		cells over + @ 
		zcount type cr
	loop
	;

do-argv bye
