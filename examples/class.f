| How to use a "class" word in Reva


| A clone of the 'forth class, but in high-level Forth
: 'newclass ( xt -- )
	cr	." Thank you for using the 'newclass word!" cr

	~sys.compiling? if
		compile
	else
		execute
	then
	; newclass	| register in the list of 'classes'

| show our new class is registered:
cr .classes cr

| define a word to use the new class:
: usenewclass ['] 'newclass ~sys.default_class ! ;

usenewclass
: anewclass cr ." this is a 'newclass instance" cr ;
forth


| see if it works...
| compiling:
: anc cr ." compiled ... " anewclass ;
." interpreted ... " anewclass 
." executed ..." anc


bye
