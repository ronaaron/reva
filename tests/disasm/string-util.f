needs string/misc
| Stackrobatics for fun and practice :)

~priv
| move string `addr u` to dst, skipping over all instances of char `c` 
: move-skipping  ( addr u dst c -- dst')
    2swap
    bounds do  ( dst c)
	i c@ 
	2dup <> if        
	    third c!
	    _1+
	else
	    drop
	then
    loop 
    drop  
;

: shift  ( addr u n)
    >r
    over r@ +
    swap
    r>  
    0 <if  move  else  cmove>  then 
;
variable whitespace

~strings
with~ ~priv
| delete in-place all instances of char `c` 
| from the string at `addr u`
: remove  ( addr u c -- addr u')
   >r
   2dup 
   r@  /char  ?dup 0if
	drop rdrop 
   ;then
   ( orig len found len)
   over 1+  swap  1-  rot  r>  move-skipping
   nip over -
;

| replace in-place the first instance of `a2 u2` in `a1 u1` with `a3 u3`
:  replace  ( a1 u1 a2 u2 a3 u3 -- a1 u')
    dup    >r
    swap   >r 
    over - >r                       | length difference
    2over 2swap                     | (S: a1 u1 a1 u1 a2 u2 ; R: u3 a3 diff)
    strsplit  0if
	2drop rdrop rdrop rdrop
    ;then
    r@ shift
    +  r>                           | (S: a1 u1 insert-addr diff ; R: u3 a3 )
    r> rot r> move
    +
;

: space? ( ch -- ?)
    dup 32 = swap 9 = or ;

: compact-whitespace   ( addr u -- addr u')
    whitespace off
    _dup _dup bounds
    do
	i c@ dup space?
	whitespace @ if
	    if 
		drop
	    else
		whitespace off
		over c! 1+
	    then
	else
	    if drop 32 whitespace on then
	    over c! 1+
	then
    loop 
    over - ;

without~ 
exit~
