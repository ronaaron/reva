: b-fib 40 fib drop ;
: b-do 1000 dltest ;
: b-smr 500sines ;

: b-rot 1 2 3    4000 0do  100000 0do rot loop loop 3drop ;
: b-swap 23 534 4000 0do 100000 0do swap loop loop 2drop ;

variable fun
: test
	fun !
	3 0 do
	ms@ >r 
		fun @ execute
	ms@ r> - .ms
	loop cr ;
: bench
	cr
	ms@ >r 
		." recursive fib: " ['] b-fib test
		." noop do-loop:  " ['] b-do test
		." rot : " ['] b-rot test
		." swap : " ['] b-swap test
	ms@	r@ - ." Old bench:   " .ms cr
		." 500sine sum:   " ['] b-smr test
	ms@	r> - ." Total time:  " .ms cr
	;
