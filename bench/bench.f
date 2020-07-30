needs math/doubles
needs os/shell
:: cr ." Interrupted" cr bye ; is ctrl-c

~doubles
| benchmark code for Reva
: .ms 1000 /mod (.) type '. emit 3 '0 (p.r) type space ;
: fib ( x -- y )
	dup 2 >if 1- dup fib
		swap 1- fib + ;;
	then drop 1 ;
create joe 0 ,

: dl 100000 0 do joe @ drop loop ; 
: dltest 0 do dl loop ;

| fp test

: oldreva " revaver" find dup 0if 2drop 1 else 7 =if drop 1 else 0  then then ;
oldreva [IF]
: smr ;
: 500sines ;
[ELSE]
needs math/floats
~floats
: smr f0 5001 1 do i s>f fsin f+ loop ;
19 sigdig ! 
| cr ." smr (.27970133224749172): " smr f. cr
: 500sines 10000 1 do smr fdrop loop ;
[THEN]

include bench-common.f
.ver cr 
bench 
bye
