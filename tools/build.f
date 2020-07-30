| Program to rebuild Reva
|

needs os/shell

variable is-cross
variable build-type
: version " Build 1.1" type cr ;


here " 2 -fmacho" asciiz,
here " 1 -felf" asciiz,
here " 0 -fwin32" asciiz,
create nasm-tail , , ,

here " dl -Wl,-allow_stack_execute" asciiz,
here " dl -m32" asciiz,
here " kernel32 src/revares.o" asciiz,
create gcc-tail , , ,

here " mac/" asciiz,
here " lin/" asciiz,
here " win/" asciiz,
create os-dirs , , ,

create cmdline 256 allot
create filename 256 allot
: run ( a -- ) count  shell ;
: strip ( -- a n )
	is-cross @ if
		" ~/mingw/bin/i686-pc-mingw32-strip "
	else
		" strip "
	then
	;
: gcc ( -- a n ) 
	is-cross @ if
		" ~/mingw/bin/i686-pc-mingw32-gcc -nostartfiles -o "
	else
		" gcc -nostartfiles  -o "
	then
	;
: bin/ os 0if " bin\\" else " bin/" then filename place 
	is-cross @ if 0 else os then
	cells os-dirs + @ 
	count filename +place
	;
: src/ " src/" filename place ;

: os-suffix ( a -- )
	build-type @
	dup 0if
		" .exe" filename +place
	else
		drop	
	then
	;
: core-file 
	bin/ " core" filename +place
	os-suffix filename count
	;
: reva-file
	bin/ " reva" filename +place
	os-suffix filename count
	;
: add-wine " wine " cmdline +place ;
: runreva ( a n -- )
	cmdline off
	is-cross @ if
		add-wine
	then
	reva-file cmdline +place
	32 cmdline c+place
	cmdline +place
	cmdline run
	;


: syntax quote *
Build program for Reva.  It builds Reva for the operating system on which
it is running.  When invoked without options, will re-build Reva only.

The following options may be used:

   -h     Display this help screen
   -w     Build for Windows (using MingW cross compiler on Linux or OS/X)
   all    Clean, build, make the help file and check it
   check  Check the help file for missing words and other problems
   core   Build the core (only)
   help   Build the help file
   test   Run tests on Reva and selected libraries

* type cr bye ;

: build-core
	." Building the core..." cr
	" nasm -Ox -o core.o -DOS=" cmdline place
	build-type @ cells nasm-tail + @ count cmdline +place
	"  src/newcore.asm" cmdline +place
	cmdline ctype cr
	cmdline run
	

	| link it 
	gcc cmdline place
	core-file cmdline +place
	"  core.o -l" cmdline +place
	build-type @ cells gcc-tail + @ count cmdline +place
	cmdline ctype cr
	cmdline run

	| strip it
	strip cmdline place
	core-file cmdline +place
	cmdline ctype cr
	cmdline run

	| upx  the core (assuming upx is installed on the machine)
	" upx " cmdline place
	core-file cmdline +place
	cmdline run

	| add zero bytes padding at the end: 
	temp off
	core-file open/rw >r
	r@ fsize r@ seek
	temp 4 r@ write
	r> close
	;
: build-reva
	." Building Reva..." cr
	cmdline off
	is-cross @ if
		add-wine
	then
	core-file cmdline +place
	"  src/reva.f" cmdline +place
	cmdline run
	;

: test 
	" tests/test.f" runreva
	" -t -n math/floats" runreva
	" -t -n date/parse" runreva
	bye
	;
: -w 
	os 0 <>if 
		is-cross on
		build-type off
	then
	;
: -h syntax ;
: help " tools/genhelp.f" runreva bye ;
: check " tools/checkhelp.f" runreva bye ;
: core build-core bye ;
: all build-core build-reva help ;

: get-params ( -- ) argc 1 do i argv eval loop ;

: build build-reva bye ;


| If the script is compiled, start here:
::
	is-cross off
	os build-type !
	| do stuff now
	argc 1 >if get-params then 
	build
	; is ~sys.appstart

: save 
	bin/ " build" filename +place
	filename count makeexename
	(save) bye ;

save
