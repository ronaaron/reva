| Example of how to use the "doer", "make" and "undo" words

needs util/doers

| Just like a 'defer' word, but capable of 'make' and 'undo':
doer joe

| "make" sets the behavior of the doer to whatever follows:
make joe ." hi there" cr ;

joe

| and it works inside a colon-def as well!  but the code runs once in this case:
: j1
	make joe ." over here!" cr ;

." should still be old behavior: " joe

j1

." but now: " joe cr

make joe ." hi, joe" cr ;

." and now: " joe

:: ." yay!" cr ; >defer joe

." now: " joe

: d { ." are you sure?" cr } >defer joe ;

joe d joe

: j2 undo joe ;

." still : " joe
 j2

| undo joe
." should have reverted: "  cr joe cr
bye
