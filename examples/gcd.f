| Example of GCD algorithm:

: gcd ( a b -- gcd )
	0; tuck mod gcd ;


: .gcd ( a b -- )
	." GCD of "
	2dup . ." and " . ." is:"
	gcd . cr ;


100 80 .gcd
23 17 .gcd
64 12 .gcd
5 0 .gcd
bye

