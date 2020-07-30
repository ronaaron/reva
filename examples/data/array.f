| Demonstrates the use of the data/array


needs data/array
needs random/simple

with~ ~data

variable arr	| holds the array we will allocate


: init
	| create an array of 100 entries, 4 bytes each:
	100 4 array  arr !
	| note: the array elements are all zeros initially
	;

: populate
	30 10 do
		rand temp !
		arr @ i temp array!
	loop
	;

: (show) drop @ .x true ;

: show ['] (show) arr @ iterate ;

: done
	arr @ destroy
	;

: go init populate show done ; 

go bye
