| update reva if there is a new version:

needs net/http
with~ ~net

create new-version 256 allot
create fname 256 allot
variable fh

: (get-update) ( a n -- ) fh @ write '. emit ;
: get-update ( -- )
	new-version count 
	2dup '/ \char 1 /string 2dup fname place creat fh !
	['] (get-update) getpage
	fh @ close cr
	;

: (update?) ( a n -- ) new-version +place ;

: update? ( a n -- flag )
	new-version off
	" http://ronware.org/reva/reva.php?ver="   scratch place
	scratch +place
	scratch count ['] (update?) getpage
	new-version count
	" nothing" cmp 0 <> ;

: thelatest ." the latest Reva" ;

: check-and-download
	revaver update? 0if ." You have " thelatest cr ;then
	." Please wait while " thelatest ."  downloads:" cr
	get-update cr
	." Done!  Please unzip: " fname ctype cr
	;

check-and-download bye
