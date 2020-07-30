needs string/base64

: instr " Hi there, this is my string!" ;
: shouldbe " SGkgdGhlcmUsIHRoaXMgaXMgbXkgc3RyaW5nIQ==" ;

| QUJDCg==
: doit ( a n a n -- )
	2dup type cr
	>base64 type cr
	type cr cr
	;

: doit2 ( a n -- )
	." Round-trip test: " cr
	2dup type cr
	>base64 base64> 
	type cr cr
	;

shouldbe instr doit
" QUJD" " ABC" doit
" QUJDRA==" " ABCD" doit
" QUJDREU=" " ABCDE" doit
" QUJDREVG" " ABCDEF" doit

" testing" doit2

bye

