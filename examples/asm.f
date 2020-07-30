| example of how to use the asm{ word

: tstasm
    cr ." TOS is: " dup .   | normal forth words
    | The "asm{" word temporarily sets the "~asm" to the top of the context
	| stack, and interprets everything up to the next "}" character
	| Do realize that Reva is in *interpret* mode, so that the asm opcode 
	| words work the same if used outside a colon-definition
    asm{
	1000 # EAX ADD  | regular Reva comments are allowed
	EAX INC 
	EAX INC
    }

    cr ." Now it is: " . | more normal forth
    ;

10 tstasm bye
