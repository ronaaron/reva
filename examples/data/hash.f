| How to use 'data/hash'

needs data/hash

with~ ~hash

." trying  allot'ed hash:" cr
17 " table" (hash)


." putting some data in the hash table: " cr

" some data" " key1" table put
" more stuff"  " key2" table put
" mama" " mia" table put


." getting the item 'key2': "
	" key2" table get >payload type cr

." iterating over the entire table: " cr
: do-iter ( h -- )
	dup >key type ." : "
	>payload type cr ;

' do-iter table iter


." trying with allocated hash:" cr
23 memhash: table2

." putting some data in the hash table: " cr

" xyzzy"  " abc" table2 put
" raining cats" " dogs" table2 put
" what's the PIN?" " 123" table2 put


' do-iter table2 iter


bye
