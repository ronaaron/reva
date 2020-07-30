needs testing
with~ ~test

| declare tests here:
test: Simple math +
	" Simple math tests" blab
	2 5 + 7 = ;
test: Simple math -
	~sys
	2 5 - -3 = ;
test: Simple math *
	2 5 * 10 = ;
test: Simple math /
	10 2 / 5 = ;
test: Simple math mod
	235 13 mod 1 = ;
test: Simple math /mod
	102 10 /mod - -8 = ;
test: Simple math /mod 2
	123 10 /mod 12 = ;
test: Simple math /mod 3
	123 10 /mod drop 3 = ;
test: Simple math boundary condtions
	1000000000 1 + 1000000001 = ;
test: Negatives 1
	23 -2 + 21 = ;
test: Negatives 2
	-300 -22 + -322 = ;
test: Negatives 3
	-3 2 * -6 = ;
test: Negatives 4
	-10 2 / -5 = ;
test: minmax 1
	456 123 max 456 = ;
test: minmax 1a
	123 456 max 456 = ;
test: minmax 2
	456 123 min 123 = ;
test: minmax 2a
	123 456 min 123 = ;
test: minmax 3a
	-1 1 max 1 = ;
test: minmax 3b
	1 -1 max 1 = ;
test: minmax 3c
	-1 1 min -1 = ;
test: minmax 3d
	1 -1 min -1 = ;
test: between 1a
	1 2 3 between 0 = ;
test: between 1b
	2 2 3 between -1 = ;
test: between 1c
	3 2 3 between -1 = ;
test: between 1d
	4 2 3 between 0 = ;
test: */ 1
	100 3 2 */ 150 = ;
test: */ 2
	100 3 -2 */ -150 = ;
test: negate 1
	1 negate -1 = ;
test: negate 2
	-1 negate 1 = ;
test: negate 0
	0 negate 0 = ;
test: <<
	1 3 << 8 = ;
test: >>
	8 3 >> 1 = ;
test: abs 1
	123 abs 123 = ;
test: abs 2
	-123 abs 123 = ;
test: abs 3
	0 abs 0 = ;
test: abs 4
	-1 abs 1 = ;


| BITWISE LOGIC
test: Bits 1
	" Bit logic" blab
	1 2 and 0 = ;
test: Bits 2
	1 2 or 3 = ;
test: Bits 3
	2 2 xor 0 = ;
test: Bits 4
	2 1 xor 3 = ;
test: Bits 5
	1 not 0 = ;
test: Bits 6
	0 not -1 = ;
test: Bits 7
	-1 not 0 = ;
test: Bits 8
	1 invert $fffffffe = ;

| Number conversion
test: cvt 1
	" Number conversions" blab
	2 3 '0 (p.r) " 002" cmp 0 = ;
test: cvt 2
	2 3 (.r) "   2" cmp 0 = ;
test: cvt 3
	2 (.) " 2" cmp 0 = ;
test: >digit 1
	0 >digit '0 = ;
test: >digit 2
	$a >digit 'A = ;
test: digit> 1
	'0 digit> 0 = ;
test: digit> 2
	'B digit> -1 = ;
test: digit> 2a
	hex 'B digit> decimal 11 = ;

: >number >single 0if ~doubles.>double 00; drop 2 else 1 then ;

test: cvts 1
	" 1234" >number 1 = ;
test: cvts 2
	" 1,234L" >number 2 = ;
test: cvts 3
	" 123e4" >number 0 = ;
test: cvts 4
	" 123e4" >number drop " 123e4" cmp 0 = ;

test: >single 1
	" -1" >single drop -1 = ;
test: >single 2
	" 1000" >single drop 1000 = ;
test: >single 3
	" 1,000" >single 0 = ;
test: >single 4
	" -1,000" >single 0 = ;
test: >single 5
	" $10" >single drop 16 = ;
test: >single 6
	" %10" >single drop 2 = ;
test: >single 7
	" #10" >single drop 10 = ;
test: >single 8
	" &10" >single drop 8 = ;

| Stack
test: stack 1
	" Stack manipulation" blab
	1 2 over 1 = ;
test: stack 2
	1 2 3 rot 1 = ;
test: stack 3
	1 2 3 -rot 2 = ;
test: stack 4
	1 2 swap 1 = ;
test: stack 5
	0 2 dup + 4  = ;
test: stack 6
	1 2 3 nip swap 1 = ;
test: stack 7
	1 2 3 drop 2 = ;
test: stack 8
	1 2 3 2 pick 1 = ;
test: stack 9
	1 0 ?dup drop 1 = ;
test: stack 10
	1 2 ?dup drop 2 = ;
test: stack 11
	1 2 3 tuck 2drop 3 = ;
test: stack 12
	1 2 2dup 10 -rot + 3 = ;
test: stack 13 
	1 2 3 2drop 1 = ;


| Misc stuff
: ax drop ;
test: prior
	" Various" blab
	" : ax dup prior ax ; " eval
	10 20 " ax" eval 20 = ;
: ax2 3 : ay 10 * ;
test: fall-through colon
	4 ay 40 = ;

test: fall-through colon 2
	1 4 ax2 30 = ;

test: execute ay
	2 ['] ay execute 20 = ;

test: ++
	temp off
	temp ++
	temp @ 1 = ;
test: --
	temp off
	temp --
	temp @ -1 = ;
test: +!
	temp off
	10 temp +!
	5 temp +!
	temp @ 15 = ;

' swap alias myswap
test: myswap
	12 32 myswap 12 = ;
' myswap alias myswap2
13 test2: myswap2
	13 31 myswap2 13 ;

| Memory manipulation
test: ! @
	" Memory access" blab
	2 temp ! temp @ 2 = ;
test: here
	here 1 , 2 , cell+ @ 2 = ;
test: c@
	" joe" drop c@ 'j = ;
test: c!
	pad 10 0 fill
	'X pad c!
	pad c@ 'X = ;
test: w@
	$12345678 temp !
	temp w@ $5678 = ;
test: w!
	temp off
	$aabbccdd temp w!
	temp @ $ccdd = ;
test: move
	" hi there" pad swap move
	" hi there" pad 8 cmp 0 = ;
test: fill
	pad 30 $ab fill
	pad 20 + @ $abababab = ;

| Conditionals
: bigif 0if 
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop 
	1 else 
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop noop noop noop noop noop noop noop noop
	noop noop noop noop noop noop 
	0 then ;
test: bigif
	" Conditionals" blab
	1 bigif 0 = ;
test: bigif 2
	10 0 bigif 1 = ;
test: >if
	5 4 >if true else false then ;
test: >if 2
	4 5 >if false else true then ;
test: <if
	4 5 <if true else false then ;
test: =if
	5 5 =if true else false then ;

| Loops
test: doloop
	" Loops" blab
	temp off
	100 0 do temp ++ loop temp @ 100 = ;
test: doloop 2
	temp off
	10 0 do 3 2 do i j * temp ! loop loop
	temp @ 18 = ;
test: doloop 3
	temp off
	10 0 do i 5 =if leave then i temp ! loop 
	temp @ 4 = ;
test: doloop 4
	0 10 0 do i 5 =if i eleave then loop 5 = ;
test: doloop 5
	3 0 0 ?do 1+ loop 1 0 ?do 1- loop  2  = ;
test: repeatwhile
	temp off
	150 repeat temp ++ 1- dup while
	temp @ 150 = ;
test: bigwhile
	temp off
	10 repeat
		noop noop noop noop noop noop noop noop noop noop noop noop noop noop
		noop noop noop noop noop noop noop noop noop noop noop noop noop noop
		noop noop noop noop noop noop noop noop noop noop noop noop noop noop
		noop noop noop 
		temp ++ 1- dup 
		while 
	temp @ 10 = ;
test: bigloop
	temp off
	100 0 do temp ++
		noop noop noop noop noop noop noop noop noop noop noop noop noop noop
		noop noop noop noop noop noop noop noop noop noop noop noop noop noop
		noop noop 
		loop 
	temp @ 100 =
		; 

| File IO
: testfname " testfilename" ;
: testdata " 0123456789" ;
test: file creation
	" File I/O" blab
	testfname creat >r
	ioerr @ 
	r> close
	0 =
	;

test: file open/rw
	testfname open/rw ioerr @ over close 0 =
	;
test: file open/rw and write
	testfname open/rw >r
	testdata r@ write ioerr @
	r> close 0 =
	;

test: file size
	testfname open/rw >r
	r@ fsize
	r> close
	10 =
	;

test: file open/r
	testfname open/r ioerr @ over close 0 =
	;

test: file read
	pad 10 0 fill
	testfname open/r >r
	pad 10 r@ read
	r> close
	10 = temp !
	pad 10 testdata cmp 0 = temp @ and
	;

test: file seek
	pad 10 0 fill
	testfname open/r >r
	5 r@ seek
	 pad 4 r@ read
	 r> close
	| pad 4 blab
	 pad c@ '5 =
	;
	
test: file tell
	testfname open/r >r
	5 r@ seek
	 pad 4 r@ read
	 r@ tell temp !
	 r> close
	 temp @ 9 =
	;

test: file open/r and write
	testfname open/r >r 
	" ABC" r@ write
	ioerr @ 0 <> temp !
	r> close 
	temp @
	;

test: file open/rw and write
	testfname open/rw >r 
	" ABC" r@ write
	ioerr @ 0 = temp !
	r> close 
	temp @
	;

test: file mtime
	testfname 2dup mtime temp !
	open/rw >r
	1000 ms
	" xxx" r@ write
	r> close
	temp @ testfname mtime u<
	;

test: file rename
	testfname " test.fname" rename
	ioerr @ 0 =
	;
test: file delete
	" test.fname" delete
	ioerr @ 0 =
	;

test: chdir/getcwd
	getcwd pad place
	" bin" chdir
	getcwd pad count cmp 0 <> temp !
	" .." chdir
	temp @
	;

| Strings
test: empty string
	" Strings" blab
	1
	" \" \"" eval 
	0 =
	;
test: empty string 2
	1
	" "
	0 =
	;
test: lplace
	" joe" pad lplace
	" joe" pad lcount cmp 0 = ;
test: +lplace
	" bob" pad +lplace
	" joebob" pad lcount cmp 0 = ;

| Catch/throw
: c1 2 -1 throw ; : c2 4 10 throw ; : c3 11 c2 ; : c4 0 throw ;
test: catchthrow
	" Catch/throw" blab
	10 ['] c1 catch -1 = ;
test: catchthrow 2
	5 ['] c3 catch 10 = ;
test: catchthrow 3
	33 ['] c4 catch 0 = ;

| Libraries
needs random/simple
needs alg/bubblesort
needs alg/quicksort
needs alg/hsort
needs alg/insertsort

6 constant #arr
create arr 3 , 1 , 4 , 10 , 1000 , 20 ,
: mix
	#arr 10 + #arr do
		rand abs #arr mod cells arr +
		rand abs #arr mod	cells arr +					| x y -- two random array elements to exchange
		over @										| x y x@
		over @										| x y x@ y@
		-rot										| x y@ y x@
		swap !	swap !
	loop
	;
: arrok?
	#arr 1- 0do
		arr i cells + @
		arr i 1+ cells + @ 
		>if  unloop false ;then
	loop
	true ;
test: bsort
	mix arr #arr bsort arrok? -1 =  ;
test: hsort
	mix arr #arr hsort arrok? -1 =  ;
test: qsort
	mix arr #arr qsort arrok? -1 =  ;
test: isort
	mix arr #arr isort arrok? -1 =  ;

needs crypt/md5
create hi 'h 1, 'i 1, 10 1,
test: md5
	hi 3 md5 scratch place
	" 764EFA883DDA1E11DB47671C4A3BBD9E" scratch count cmp 
	0 = 
	;


needs util/eachline
: doeach >single if temp ! else 2drop then ;
test: eachline
	quote " 123
		345
		567
		"
	temp off
	['] doeach eachline temp @ 567 = 
	;

needs alg/enum
100 enum: meah meah1 enum;

test: enum
	300 meah1 101 = ;

| Regression tests

: r205 0 ?do 1+ loop ;
: r205a 0 do 1+ loop ;
test: bug 205
	" Regression tests" blab
	0 -1 r205 0 = ;
test: bug 205a
	0 -1 r205a 1 = ;
: fail28 ioerr @ if rdrop 1 ;; then ;
variable fileh
: test28
	2drop
	" dummy-file" 2dup creat fail28 fileh !
	" stuff" fileh @ write fail28 
	fileh @ 
	close fail28
	open/r 
	fail28 fileh !
	pad 5 fileh @ read fail28 drop
	fileh @ close fail28
	" dummy-file" delete
	0 | indicate success
	;
test: bug 28
	123 test28 0 = ;

: dd ~doubles.>double if 1 else 0 then ;
: sd >single if 1 else 0 then ;
test: bug 52 a
	" 123456L" dd 1 = ;
test: bug 52 b
	" 123d456" dd 0 = ;
test: bug 52 c
	" 12356" sd 1 = ;
test: bug 52 d
	" 123d56" sd 0 = ;

: ifnoelse  if if 2 ( else 0 ) then  else 1 then ;
test: bug 53
	0 0 1 ifnoelse 0 = ;

test: bug 18
	reset . . . . . . . . . . . cr reset 0 0 = ;

: #20 parsews find ?dup if execute ;; then 2drop ;
test: bug 20
	0 " #20 dup " eval 0 = ;
test: bug 20a
	0 " #20 #20a " eval 0 = ;

test: bug 21
	123 invert -124 = ;

test: bug 22
	reset drop depth -1 = ;

: foo ;
test: bug 56
	123 " foo" find ?dup if 0 else 1 then  0 = ;

: 57a " : 57x abogusword ;" eval ;
test: bug 57
	123 57a	" 57x" find not
	;

test: bug 64
	1234 4 (.r) " 1234" cmp 0 = ;

: #65 ( -- ) 5 4 <if  0 noop then ;
: #65a ( -- ) 1 0 do leave loop ;
: #65b ( -- ) repeat while ;
test: bug 65 
	1 #65 1 = ;
10 test2: bug 65a
	10 #65a ;
10 test2: bug 65b
	10 0 #65b ;

MAC not [IF]
| TODO: Why do 'floats' mess up on the Mac?
test: bug 80
	22
	" 1 needs ansi needs math/floats " eval 1 = ;

test: bug 81
	" needs math/floats ~floats f 123.0 1 (f.) \" 123.0\" cmp " eval 0 = ;
[THEN]

: #82 repeat 1- dup 0 <if drop 0 ;; then again 24 ;
test: bug 82 
	10 #82 0 = ;

0 [IF]
test: bug 85a
	false ;
[THEN]

0 [IF]
test: bug 85b
	false ;
[ELSE]
[THEN]

1 [IF]
test: bug 85c
	true ;
[ELSE]
test: bug 85d
	false ;
[THEN]

: #107 " :: lala ; " eval ;
test: bug 107
	0 #107 1 dup 1 = ;

test: bug 108
	1 " -1.0e0" eval 1 = ;
test: bug 108a
	1 " 1.0e0" eval 1 = ;

test: bug 109
	" 2-" >single not ;

: 3d dup 2over rot ;
test: bug 115
	1 2 3 4 3d 4 = ;

test: slurp
	false " slurp-test" 2dup delete 2dup creat dup " blah" rot write close
	slurp " blah" cmp not ;

: dodah create 2 , does> @ 1+ 1+ ;
test: does
		" dodah doody 2 doody" eval
		4 = ;

variable temp100
~sys
:: temp100 on chain word? ; is word?
exit~
test: bug 100
	temp100 off
	" 23423a" eval
	temp100 @ 
	;

test: bug 79
	temp off
	10 0 do  
		5 0 do 
			i 3 =if i temp ! leave then 
		loop 
	loop 
	temp @ 3 =
	;

test: bug 105
	44
	10 0 do 3 skip loop 
	44 =
	;

test: bug 99
	22
	" test.txt" delete
	" test.txt" slurp 2drop
	22 =
	;

: a ;
: b a ;
test: tail-call
	1 ['] b c@ $e9 = ;

test: bug 116
	1234
	" : x create 0 , does> ; x y y drop " eval
	1234 = ;

: a 1 ;
: b: create , does> @execute 2 ;
' a b: b
2 test2: bug 134
	234 b ;

| test: bug 135
| 	" needs debugger 13 see see" eval 13 = ;

test: bug 136
	12 ['] noop execute 12 = ;

: setup-137 " ~floats : f=0 123. 321. f= ; : f=-1 123. 123. f= ; " eval ;
test: bug 137
	setup-137
	" 5 f=-1 -1 =" eval ;
0 test2: bug 137a
	455
	" ' f=0 temp ! " eval temp @ ;

test: bug 167
	5 1+ 6 = ;
test: bug 167a
	5 1- 4 = ;

test: bug 174
	" ~ : 174test ; to~ ~ 174test" eval 
	" 174test" find not 0 =
	;

test: bug 179
	10
	" reset~ help" eval 
	10 =
	;

test: bug 243
	" ~floats \" abd.\" >float" eval not ;
test: bug 243a
	" ~floats \" .qwer\" >float" eval not ;
test: bug 243b
	" ~floats \" .123eq\" >float" eval not ;

MAC not [IF]
test: bug 253
	" ~floats \" .12\" >float" eval ;
test: bug 253a
	" ~floats \" 1.12\" >float" eval ;
[THEN]

test: bug 242
	quote X
	needs date/calendar ~date
	3 1 2007 gregorian>fixed 
	fixed>gregorian 
	X eval
	over 1 =
	;

test: bug 229
	123
	" 1." eval
	123 = ;

: 215a ['] asdsasdfsfs ;
test: bug 215
	215a 0 = ;

test: bug 266
	" '' ~sys.appstart" eval not not ;

: skippy 3 0do 1+ 1 skip loop ;
test: bug 190
	10 skippy 12 = ;
| parse problem
: b273test '/ parse 2drop '/ parse ;
: b273 " b273test abc/def/ drop c@ 'd =" eval ;
test: bug 273
	false b273 ;
| parse problem
|
: b292 true ;
test: bug 292
	false b292 ;

: badparse quote @
	Hi there, bubba
@ ;
test: parse badness
	badparse + 1- c@ '@ <> ;

: a '/ parse ;
: badparse2 " a xy" eval ;
test: more parse badness
	badparse2 2 = ;

| defer 300.x
| test: bug 300a
| 	" make 300.x 100 ; " eval
| 	200 300.x 100 = ;

| test: bug 300b
| 	" make 300.x 300 ; " eval
| 	200 300.x 300 = ;

| test: bug 300c
| 	" undo 300.x " eval
| 	200 300.x 100 = ;

| test: make/undo depth
| 	depth
| 	" : 300.a make 300.x 123 ; " eval
| 	" : 300.b undo 300.x ; " eval
| 	depth 1- - 0 = ;

| test: bug 300d
| 	" 300.a " eval
| 	200 300.x 123 = ;
| test: bug 300e
| 	" 300.b " eval
| 	200 300.x 100 = ;

test: bug 236a 
	" 0 [IF] 1 [ELSE] 2 [THEN]" eval 2 = ;
test: bug 236b 
	" 1 [IF] 1 [ELSE] 2 [THEN]" eval 1 = ;
test: bug 236c 
	" 0 [IF] 1 [IF] 10 [ELSE] 20 [THEN] [ELSE] 1 [IF] 30 [ELSE] 40 [THEN] [THEN]" eval 30 = ;
test: bug 236d 
	" 1 [IF] 1 [IF] 10 [ELSE] 20 [THEN] [ELSE] 1 [IF] 30 [ELSE] 40 [THEN] [THEN]" eval 10 = ;
test: bug 236e 
	" 0 [IF] 1 [IF] 10 [ELSE] 20 [THEN] [ELSE] 0 [IF] 30 [ELSE] 40 [THEN] [THEN]" eval 40 = ;
test: bug 236f 
	" 1 [IF] 0 [IF] 10 [ELSE] 20 [THEN] [ELSE] 1 [IF] 30 [ELSE] 40 [THEN] [THEN]" eval 20 = ;
test: bug236g
	" 1 [IF] 3 [THEN]" eval 3 = ;
test: bug236h
	" 4 0 [IF] 3 [THEN]" eval 4 = ;
test: bug236i 
	~priv.if-flag stack-size  0 = ;

test: bug352a
	" abc" " abc" cmp 0 = ;
test: bug352b
 	" " " cmp" cmp not 0 = ;
test: bug352c
 	0 0 " cmp" cmp not 0 = ;
test: bug352d
 	" cmp" 0 0 cmp not 0 = ;
test: bug352e
 	" cmp" " " cmp not 0 = ;
test: bug352aI
	" abc" " abc" cmpi 0 = ;
test: bug352bI
 	" " " cmp" cmpi not 0 = ;
test: bug352cI
 	0 0 " cmp" cmpi not 0 = ;
test: bug352dI
 	" cmp" 0 0 cmpi not 0 = ;
test: bug352eI
 	" cmp" " " cmpi not 0 = ;

test: bug369a
	" abc1" " abc2" cmpi 0 <> ;
test: bug369b
	" [a" " {a" cmpi 0 <> ;

test: bug369b-1
	'[ lc '[ = ;
test: bug369b-2
	'A lc 'a = ;
test: bug369b-3
	'a lc 'a = ;
test: bug369b-4
	'Z lc 'z = ;
test: bug369b-5
	'z lc 'z = ;


: teststr " reva" ;
create bug374-buf 20 allot
: bug374 'x parse bug374-buf place ;
test: bug374
	" bug374 revax " eval
	bug374-buf count
	teststr cmp 0 = ; | "

1024 1024 * 8 *  constant FILESIZE
variable thebuffer
: teststring " Rar" ;
test: bug359
	FILESIZE allocate thebuffer  !
	thebuffer @ FILESIZE 'R fill
	thebuffer @ FILESIZE 3 /string teststring search
	0 =
	;

test: tick1
	123 " ' this-doesnt-exist" eval drop 123 =
	;
test: tick2
	123 " ' this-doesnt-exist" eval 0 =
	;

WIN [IF]
needs os/shell
: maketestfile
	" test344.bat" 2dup delete creat >r
	" @reva -e \"123 . bye\" " r@ write r> close ;

: spawnReva " cmd /c test344.bat" shell$ ;
test: bug344
	maketestfile
	spawnReva blab
	spawnReva " 123" cmp 0 = ;
[THEN]


test bye
