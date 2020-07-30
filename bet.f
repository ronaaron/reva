
: bet ( a lo hi ) 
	-rot | hi a lo 
	over | hi a lo a
	> not -rot < not  and
	;

