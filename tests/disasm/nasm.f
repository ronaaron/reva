| lib/fasm, altered to assemble from a string to a string

push~
~os ~io ~util ~strings
needs os/shell
~
| pass the text at `addr u` to nasm
| store the result at `dst`
: nasm ( addr u dst -- dst u' )
    | create temp.asm file and write out the assembler code
    -rot 
    " temp.asm" creat >r 
	" bits 32" r@ write
	linefeed r@ write | lf
	| write out the code:
	r@ write
	| close temp.asm
	r> close      

    " temp.bin" delete  | ensure there is no old temp.bin lying around

    " nasm -Ox -f bin -o temp.bin temp.asm>temp.err" shell shell_code @
	if 
		." Assembly failed during compilation of "
		last @ >name ctype ': emit cr
		" temp.err" slurp 2dup type cr drop free
		dup off 
	else
		| open temp.bin:
		" temp.bin" slurp
		swap >r
		2dup
		r@ -rot move
		r> free
	then

    | delete the temp files
    " temp.asm" delete
    " temp.bin" delete
    " temp.err" delete
    ;

forth
pop~
