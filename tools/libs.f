| Tell what versions of external libraries are being used:


needs db/sqlite
needs string/regex
needs string/iconv
needs string/xmlparse
needs ui/iup
needs ui/cd
| needs util/pdf

with~ ~db with~ ~sqlite

: test-sqlite ." SQLite: " 
	sqlite3_libversion zcount ;

: test-pcre ." PCRE: " 
	~priv.pcre_version zcount ;

: test-iconv ." libiconv: " 
	iconv_ver 256 /mod (.) type '. emit 256 /mod swap (.) type '. emit .  ;

: test-expat ." libexpat: "
	with~ ~xml ~expat.XML_ExpatVersion zcount ;

: test-iup ." IUP: "
	with~ ~iup IupVersion zcount ;

: test-cd ." CD: "
	with~ ~cd cd-version  zcount ;

| : test-pdf ." PDF: "
| 	with~ ~pdf.~pdf-priv HPDF_GetVersion zcount ;

os [IF] 
	| linux specific
[ELSE]
	| windows specific
: test-pdcurses  ." PD-CURSES: "
	" \" pdcurses.dll\" lib curses" eval
	" 0	func: curses_version" eval
	" curses_version" eval zcount
	;

" freetype6.dll" lib ft
| 3 vfunc: FT_Library_Version
1 func: FT_Init_FreeType

: test-freetype ." FreeType: "
	scratch 60 0 fill
	scratch FT_Init_FreeType if " failed proper loading" ;then
	scratch @ 20 + 
		dup
		@ swap
		cell- dup @ swap
		cell- @
|	scratch @ ftmaj ftmin ftpatch FT_Library_Version
	(.) scratch place 
		'. scratch c+place
	(.) scratch +place 
		'. scratch c+place
	(.) scratch +place
	scratch count
	;
[THEN]

create tests
	' test-sqlite ,
	' test-pcre ,
	' test-iconv ,
	' test-expat ,
	' test-iup ,
	' test-cd ,
|	' test-pdf ,
os [IF]
	| linux only
[ELSE]
	| windows only
	' test-pdcurses ,
	' test-freetype ,
[THEN]

here tests - 4 / constant num-tests

: do-tests
	num-tests 0do
		i cells tests + @ catch if
			." - not present"
		else
			type
		then
		cr
	loop
	;

do-tests bye
