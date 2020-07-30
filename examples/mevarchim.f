needs date/sedra 
with~ ~date

: skip-to-shabbat ( fixed -- fixed' )
    dup fixed>dow 6 swap - + ;

variable hebrew-year
variable greg-year

: .2 ( nr -- s d ) 2 '0 (p.r) type space ;
: date-format ( mm dd yyyy -- )
	3dup gregorian>fixed fixed>hebrew
		-rot
		.2 hebrew-month-name type 
		dup hebrew-year @ <>if
			dup space hebrew-year ! . 
		else drop then
    -rot
	." ,("   .
	1-	monthname type
	dup greg-year @ <>if
		."  "
		dup greg-year ! (.) type
	else  drop then
	." )"
;

: chag? ( date -- date )
	dup fixed>hebrew drop 
	15 23 between if
		dup 1 =if ."  PESACH" then
		7 =if ."  SUCCOT" then
	then
	drop
	;

: mevarchim? ( date -- flag )
	dup rosh-chodesh? if ;; then
	dup
	7 + fixed>hebrew drop nip
	| in range: 2-7
	dup
	1 7 between  swap | if ." *" then
	30 = or if ." *" then
;

: comma ', emit ;
: rh? dup rosh-chodesh? if ." [RH]" then ;
: print-one-shabbat ( date -- date )
    >r
    r@ fixed>gregorian date-format comma
    r> dup sedra type space 
	rh? mevarchim? chag? cr
;

: calc ( -- )
    today>fixed skip-to-shabbat
	dup fixed>hebrew 1+ hebrew>fixed 1- swap
    do i print-one-shabbat 6 skip loop ;

: main ." Shabbat calculator v3 " cr true in-israel calc cr bye ;
with~ ~sys
' main is appstart

." This application will print one year of shabbatot and parasha readings" cr
." Rosh-Hodesh is denoted by [RH].  Shabbat mevarchim by *.  Holidays as appropriate" cr
cr
" mevarchim" makeexename (save) bye
