| print a diamond of stars

: stars ( n -- ) 0 max 0; '* emit 1- stars ; 
: .row  ( m n -- ) spaces 2* 1- stars cr ;
: .upper ( n -- ) 1 do i remains .row loop ;
: .lower ( n -- ) 1 do remains 1+ i .row loop  ;
: diamond ( n -- )  0; dup 1+ .upper .lower ;

5 diamond bye
