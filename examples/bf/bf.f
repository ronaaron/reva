| Primitive Brainf*ck compiler
| See: http://en.wikipedia.org/wiki/Brainfuck
|
| Commands are:
|   >   increment pointer (move right)
|   <   decrement pointer (move left)
|   +   increment byte at pointer
|   -   decrement byte at pointer
|   .   output value of byte at pointer
|   ,   accept one byte of input, store at pointer
|   [	jump fwd to command after corresponding ], if byte at pointer is zero
|   ]   jump back to command after corresponding [, if byte at pointer is  non-zero

context: ~bf    
~bf

30000 constant size
create mem   size allot       | classic bf buffer size
| No variable for the pointer -- I'll keep it TOS

| Let's have fun with different wordclasses
: >   1+ ;inline
: <   1- ;inline
: +   asm{ 0 [EAX] BYTE INC } ;inline  
: -   asm{ 0 [EAX] BYTE DEC } ;inline  
: .   dup c@ emit ;
: ,   key over c! ;
: jmp?  ( ptr -- ptr b) dup c@ ;
macro
| : [ p[ jmp? if repeat  ]p ;
| : ] p[ jmp? while then ]p ; 
: [   p[ repeat jmp? if ]p ;
: ]   swap p[ again then ]p ; | a piece of insanity :)


forth

exit~ 

| Finds and executes a word correspondig to the character pointed
| by TOS.
| When called in the compilation state it will apply that word's 
| compilation semantics.
: bf-compile ( a -- )
    1   ['] ~bf   ~sys.find-word if exec then ;

| Compiles a string of brainf*ck into an anonymous definition 
| and executes it
: bf ( a n -- )
    | VM initialisation :)
    ~bf.mem dup   ~bf.size zero   -rot  

    p: {{  ( buf a n x x) 2swap    | {{ places two tokens on the stack
	bounds do   i bf-compile   loop 
    p: }} 

    drop ;


| All examples are taken from http://esoteric.sange.fi/brainfuck/

| "666"  with some noise added.
: beast    " >+++++++++ (*[<++++++>-]*) /<...>/++++++++++." bf ;

| Hello, world!
: hello
    quote /
    >+++++++++[<++++++++>-]<.>+++++++[<++++>-]
    <+.+++++++..+++.[-]>++++++++[<++++>-]
    <.#>+++++++++++[<+++++>-]<.>++++++++
    [<+++>-]<.+++.------.--------.[-]>++++++++[
    <++++>-]<+.[-]++++++++++.
    / bf ;

| Of the 3 interpreters here this one is the only one 
| that can handle this:
: primes
    " prime.b" slurp
    ?dup 0if 
	." Can't slurp prime.b!" cr 
	drop 
    else
	over swap  
	bf
	free
    then ;
