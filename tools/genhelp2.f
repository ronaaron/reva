| convert help.txt to help.db
| Version 2: use hash instead of database to eliminate SQLite dependency

needs data/hash
needs data/parray
needs string/trim
needs string/misc
needs os/dir

~sys ~parray ~hash ~

| English help.  Other languages will appear in "words.xx", where 'xx' is the
| two-letter language code (as in 'de' for German, for example)
| These extra variables are generated when a "lang:" word is parsed
|
15 hash: languages
variable current-lang

variable #defs
| libraries:
128 parray: help-libraries
128 parray: help-contexts

variable serial-entry
variable serial-library
variable serial-context

: find-lib ( a n -- m | a n 0 )
	help-libraries ~parray.>len @ 0do
		| a n a n
		i help-libraries ~parray.get lcount 
		2over cmp
		0if 2drop i unloop 
		;then
	loop false ;

: add-lib ( a n -- number )
	find-lib ?dup 0if
		strdupl help-libraries ~parray.append
		help-libraries ~parray.>len @
	then
	;


: find-ctx ( a n -- m | a n 0 )
	help-contexts ~parray.>len @ 0do
		| a n a n
		i help-contexts ~parray.get lcount 
		2over cmp
		0if 2drop i 1+ unloop 
		;then
	loop false ;

: add-ctx ( a n -- number )
	find-ctx ?dup 0if
		strdupl help-contexts ~parray.append
		help-contexts ~parray.>len @
	then
	;

: add-lang ( a n -- )
	2dup
	| create hash to store the language:
	" 1023 hash: words." pad place pad +place pad count eval
	last @ exec temp ! temp	4 2swap languages put

	;

: (do-lang) ( a n -- )
	temp off
	temp swap move 
	temp @
: do-lang ( m -- ) 
	temp ! 
	temp 2
	languages get 
	?dup if
		>payload current-lang swap move
	then ;
: reset-lang " en" (do-lang) ;

: place> ( a n b -- a' )
	over >r dup >r place r> r> + 1+ 1+ ;

| the data to store in the hash table for each word:
|	word	serial-entry-number
|	word	serial-library-number
|	word	serial-context-number
|	cstr	stack-diagram
|	cstr	version
|	lstr	description
|	lstr	also

| staging area for the new word entry:
20000 constant CWSIZE 
create  cw  CWSIZE allot
variable cw-size
variable currentlib 100 allot

| accessors:
: cw>name cw count ;
: cw>ctx  cw>name + count ;
: cw>stack cw>ctx + count ;
: cw>lib  cw>stack + count ;
: cw>desc cw>lib + lcount ;
: cw>also cw>desc + lcount ;

| note that these need to be performed in order!
| name, ctx, stack, lib, desc, also 
: name>cw cw place ;
: ctx>cw  cw>name + place ;
: stack>cw cw>ctx + place ;
: lib>cw   currentlib count cw>stack + place ;
: desc>cw  cw>lib + lplace ;
: also>cw  cw>desc + lplace ;

false value verbose
create langbuf 16 allot			| name of language
create wordbuf 256 allot		| name of word
create stackbuf 256 allot		| stack diagram
create osbuf 256 allot			| os this appears in (blank =both, or linux or windows)
create descbuf 10000 allot		| description of word
create verbuf 256 allot			| version of Reva this word first appears
create buf 10000 allot			| the SQL to write out
create enq	10000 allot

: notnull! dup c@ 0if wordbuf ctype ."  is incomplete" cr THROW_GENERIC  ;then count ;

| trim is bad ?!?
: getline parseln trim ;
: stack: ( <stack> )
	getline stackbuf place 
	;

: orig: ( <stack> ) getline add-lib serial-library ! ;
orig: genhelp2.f

: ctx: ( <context> ) getline add-ctx serial-context ! ;
: os: ( <os> ) getline osbuf place ;
: ver: ( <os> ) getline verbuf place ;
: lang: ( <[xx]> ) 
	temp off
	parsews 
	2dup add-lang
	temp swap move
	temp 2 
		(header)
		temp @ literal, 
		['] do-lang compile
		p: ;
	;

::	cr type_ ." not found in file: "
	serial-library @
	help-libraries ~parray.get
	lcount type cr bye
	; is word?
0 [IF]
[THEN]
200 parray: to-permute
: dopermute ( l1 l2 -- )
	2drop
	;

: permute1 ( n -- )
	dup to-permute ~parray.get 
	swap 1+ 
	to-permute ~parray.>len @ swap 
	?do
		dup i to-permute ~parray.get
		dopermute
	loop
	drop
	;

| m strings (a,n) of 'related' words are on the stack
: permute ( ... m -- )
	| put the strings in the to-permute array
	to-permute ~parray.clear
	0drop; 1+ 0do
		strdupl to-permute ~parray.append
	loop

	to-permute ~parray.>len @ 0do i permute1 loop
	;

: related ( a n -- )
	verbose if cr ." related: " 2dup type cr then
	?dup 0if drop ;then
	trim
	| split the string into component words:
	32 split[]
	dup 0if 2drop ;then
	permute 
	;

| This word must only occur *after* the 'related' words!  It's a good idea to
| place it at the bottom of the help file.
: related: 10 parse related ;
create last_id 20 allot
| This must be the *last* word of a help definition:
: desc: ( <desc>^L ) 
    parsews drop c@ parse 
	9996 min descbuf lplace 

	| write out the word
	| initialize:
	cw CWSIZE zero
	cw-size off

	| fill in the blanks:
	cw #defs @ over !
	cell+ serial-library @ over !	
	cell+ serial-context @ over !
	cell+ stackbuf count rot place>
	verbuf count rot place>
	descbuf lcount rot lplace>
	| also ???
	cw swap over -				| (a,n)
	wordbuf count 
	current-lang  @
	put
	reset-lang

|	langbuf @ if
|		| put in the 'lang' table
|		" insert into lang values (" buf lplace
|		last_id count buf +lplace ,,
|		39 buf c+lplace
|		langbuf count buf +lplace 
|		39 buf c+lplace
|		,,
|		descbuf lcount buf +lplace
|		" )" buf +lplace
|		langbuf off
|		db buf lcount sql_exec
|	else
|		" insert into help values (NULL," buf lplace
|		wordbuf count buf +lplace ,,
|		stackbuf count buf +lplace ,,
|		ctxbuf notnull! buf +lplace ,,
|		origbuf2 count buf +lplace ,,
|		osbuf count buf +lplace ,,
|		verbuf count buf +lplace ,,
|		descbuf lcount
|		buf +lplace ,,
|		currentlib count buf +lplace
|		" )" buf +lplace
|		db buf lcount sql_exec
|		db " select last_insert_rowid() from help" sql_fetch$ 
|			last_id place
|	then
	;

| $2d5c7c2f variable, spinner
: countdefs
| 	8 emit 
	#defs ++
| 	spinner #defs @ 4 mod + 
| 	c@ emit
	;
: def: ( <name> <stack> <desc> )
	countdefs

|	verbose if #defs @ .  else '. emit then

	getline wordbuf place
	verbose if wordbuf ctype space then
	stackbuf off
	osbuf off
	descbuf off
	verbuf off
	; 

: readin | db sql_begin
	libdir 1- pathsep -chop 1+  pad place 
	" src/help.txt" pad +place pad count 
	2dup  type cr
	(include)
|	db sql_commit
	;

: dolib ( a n -- )
	2dup type cr
	slurp 2dup | a n a n
	" |||" search if
		| a n a1 a2
		4 /string eval
	then
	drop free
	;
: (dolibs) ( a n -- )
	~os.fullname 
	| a n
	2dup
	libdir nip cell- /string 
	verbose if cr 2dup type cr  then
	2dup add-lib serial-library !
	dolib 2drop
	;
: dolibs
	| iterate over help-libraries and process each one ...
	['] (dolibs) ['] 2drop libdir in~ ~os rdir
	;

: nohelp
	cr
|	db 
|	" select name from orig where ix not in (select orig from help)"
|	{
|		0 sql_getcol$ type cr
|		false
|	} sql_fetch cr . ." help-libraries without help" cr
	;

: count> ( a -- a' a n ) count 2dup + 1+ -rot ;
: println? ( a n a n -- )
	third if type_ type cr ;then
	2drop 2drop ;
: dump-word ( a n -- )
	drop
|	." word #"
|	lcount drop | .x
	cell+
	." lib: " lcount help-libraries ~parray.get lcount type cr
	." ctx: " lcount help-contexts ~parray.get lcount type cr
	count> " stack:" println?
	count> " ver:" println?
	." desc: " lcount type cr
	;

: dump-lib { dup >key type cr >payload dump-word } swap iter ;
: dumplibs { 
	dup >key type cr 
	>payload 
 	temp swap move temp @ dump-lib 
	} languages iter ;

readin dolibs 
cr dumplibs
nohelp 
cr #defs ? ." word definitions in database" cr bye

