needs data/parray

with~ ~parray

10 parray: arr

10 1 arr put
20 2 arr put
30 3 arr put

: fillup
	7 0do
		i 10 * i arr put
	loop ;

: do.iter 
	." iterating:" cr
	{ . cr } arr iter ;

: do.extend
	." extend array:" 
	2000 20 arr put 
	20 arr get 2000 = . cr ;

fillup do.iter
do.extend
