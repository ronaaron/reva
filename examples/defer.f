| Example of how to use the "defer", "defer:", "@", "chain" and "is" words.


| Plain defer word, doesn't do anything interesting:

defer a
| make sure it does nothing:
a
| Assign some new behavior to it:
:: ." hi, this is 'a'" cr ;  is a
| make sure it does something:
a

| we'll assign this behavior inside another word:
: a2  ." and now, we do something else" cr ; 
: change-a ['] a2 is a ;
| 'a' has not changed yet:
a
| but now it will be:
change-a a

| The 'defer:' word is basically the same as a 'defer' and 'is' together:
defer:  b  ." this is 'b'" cr ;
b
| and it is otherwise exactly  the same as a regular defer
' a2 is b
b

| the "defer@" word retrieves the XT to which the "defer" points, given the XT
| of the defer word:
' b @execute

| "chain" lets us "chain onto" the old behavior of a "defer":
: a3
	." Some new behavior... " 
	chain a ;
' a3 is a
a

| we can even do some tricks to emulate the 'undo' behavior without using 'doer' words:
:: ." old" cr ; is a
: c1 ." new" cr ;
| this word changes 'a' to do 'c1'; then when its caller returns, it changes the
| behavior back to whatever it was.  Of course, both the caller and the deferred word
| must not munge the stack, or Bad Things will happen!
: c 
	['] a @	| get old XT
	['] c1 is a		| set new behavior
	later			| wait for caller to return
	is a			| reset to old XT
	;

: c2 a c a ;
c2
a

bye
