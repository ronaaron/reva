| simple Body Mass Index calculator

variable height
variable weight

: hello cr ." BMI calculator 1.0" cr ;
: getheight
	cr
	." Please enter your height, in centimeters: "
	pad 10 accept
	dup if
		pad swap eval height !
	;then
	drop
	getheight
	;
: getweight
	cr
	." Please enter your weight in kilograms: "
	pad 10 accept
	dup if
		pad swap eval weight !
	;then
	drop
	getweight
	;

: showbmi
	cr
	." For a weight of " weight ? ." kg," 
	." and height of " height ? ." cm," 
	." the BMI is: "
		weight @
		100000 height @ dup * */ 
		10 /mod (.) type '. emit .
	cr
	;
hello getheight getweight showbmi bye
