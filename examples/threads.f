needs os/threads

1 [IF]
0 value A
0 value B

variable count
: a count !
: aa count ++ 5 ms 
	count @ 1600 >if ." a exiting" cr exitthread ;then
	aa ;

variable lastcount
: b . 
: bb count ? 100 ms 
	count @ lastcount 2dup @ =if 500 ms ." b exiting" cr exitthread ;then
	!
	bb ;

: threads
	cr ." Thread test:" cr
	['] a 1234 100 thread to A
	['] b 5234 100 thread to B
	;
: threads-test
	threads
	A waitthread cr ." A is done" cr
	B waitthread cr ." B is done" cr
	;
[THEN]

variable m m mutex
0 value T1
0 value T2
0 value T3
0 value done

: t m lockmutex done m unlockmutex not 0;drop dup emit  15 ms t ;

: t3 'X emit  
	1000 ms m 
	'X emit
	lockmutex 
	true to done
	m unlockmutex
	'X emit
	;

: setup
	cr ." Mutex test:" cr 
	['] t 'A 200 thread to T1
	['] t 'B 200 thread to T2
	['] t3 0 200 thread to T3
	;

: run
	T3 waitthread 
	m closemutex
	cr ." Done!" cr
	;

: main threads-test setup run cr bye ;

main
