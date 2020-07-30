| Generate "SHA1" checksum for a list of files
| vim: ft=reva :


needs crypt/sha1
needs timer

: do1file ( n -- )
	argv 2dup
	sha1file type space space type cr
	;
: dofiles argc 2 do i do1file loop ;

' dofiles timer-xt 
." Elapsed time: " .timer cr bye
