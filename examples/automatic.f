| Testing automatic initialization of variables
|
| Sometimes a variable needs to be initialized just once, the first time it is
| used.  For example, a database handle.  The user code needs to check if the
| variable has been initialized, and if not then do whatever needs to be done.
| Here are some ways to accomplish this in Reva.

| The variable to initialize.  Note that in Reva 'variable's are always
| initially zero (but if you 'save' the image after having initialized the
| variable, it will have the value you saved!)

variable handle
| this is the code which does actual variable initialization
: initialize-variable
	1234 handle !
	;

| Traditional code:
: case1
	handle @ 0if
		initialize-variable
	then
	handle @ ;

." case1: " handle ? ."  after init: " case1 . case1 . cr ;

handle off	| reset

| Use of a defer to hide the conditional:

defer: case2
	." first time " cr
	initialize-variable
	{ handle @ } is case2
	handle @
	;


." case2: " handle ? ."  after init: " case2 . case2 . cr ;

handle off	| reset


::  1234 ; autovar: case3 

." case3: " handle ? ."  after init: " case3 . case3 . cr ;

bye
