| Demo of [IFTEST] ... [THEN]

: square ( n -- n^2 )
	dup * ;

[IFTEST]

test: simple square
	3 square 9 = ;

test: what a failure!
	false ;

test: exceptional
	1 throw ;
[ELSE]

quote *
You are seeing this message because you ran Reva without the '-t' flag.

Try again with 'reva -t examples/testing.f' to see the testing code run.
* 
type cr bye

[THEN]

