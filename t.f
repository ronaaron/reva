
: 30lrot inline{ C1 C0 1E } ;inline

: put ( m n -- ) inline{ 89 C3 AD 89 04 9E AD } ; 

: roll5 inline{ 8B 5E 0C 89 5E 10 8B 5E 08 C1 C3 1E 89 5E 0C 8B 5E 
        04 89 5E 08 8D 76 04 } ;
: roll5 inline{ 8B 5E 0C 89 5E 10 8B 5E 08 89 5E 0C 8B 5E 04 C1 C3 
        1E 89 5E 08 8D 76 04 } ; 
: roll5 inline{ 8B 5E 0C 89 5E 10 8B 5E 08 89 5E 0C 8B 5E 04 C1 C3 
        1E 89 5E 08 8B 1E 89 5E 04 8D 76 04 } ; 

: init reset 10 20 30 40 50 60 70 ;

: original
	init .s cr
	4 pick 5 put
	3 pick 4 put
	2 pick 30lrot 3 put
	rot drop
	.s cr
	;
: improved
	init .s cr
	roll5
	.s cr
	;
original improved bye
