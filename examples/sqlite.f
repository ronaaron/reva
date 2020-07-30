| --------------------------------------------------------------------
| test code:
| --------------------------------------------------------------------
needs db/sqlite
with~ ~db
context: ~test
~test
variable counter
value db

: sqlok?
	sql_result @ dup dup 0 = swap 4 = or if
		drop ." OK" cr
	else
		." SQL error: " .  
		db sql_errmsg type cr bye
		bye
	then
	;

: init
	." Opening/creating the database..." cr
	" test.db" 2dup delete sql_open to db 
	sqlok?

	." Populating the database..." cr
	db sql_begin
	db " create table a ( b char, c char )" sql_exec 
	db " insert into a values ('one', 'first number')"  sql_exec 
	db " insert into a values ('two', 'second number')" sql_exec
	db " insert into a values ('two', 'second number again')" sql_exec
	db " insert into a values ('three', 'after two')"  sql_exec
	db " insert into a values ('four', 'two times two')"  sql_exec
	db sql_commit
	sqlok?
	;

: newcb2 0 sql_getcol# '( emit . ." rows) " false ;

: newcb  ( n -- flag )
	dup .  ." columns: "
		0 do
			i sql_getcol$ type_
			db " select count() from a" ['] newcb2 sql_fetch drop
		loop
		cr
	false | means continue!
	;

: test1
	." BEGIN TEST 1" cr
	db " select b, c from a" ['] newcb sql_fetch
	." processed " . ."  rows" cr
	sqlok?


	." sql_fetch$: "
	db " select b, c from a" sql_fetch$ type cr
	." END TEST 1" cr
	sqlok?
	;

: inner
	." inner: " 0 sql_getcol$ type cr
	false
	;
: test2
	." BEGIN TEST 2" cr
	db " select distinct b from a" 
	{
		" select c from a where b='"    scratch place
		." outer: " 0 sql_getcol$ type cr
		0 sql_getcol$ scratch +place
		" '" scratch +place
		
		db scratch count 
		{
			." inner: " 0 sql_getcol$ type cr
				false
		}
		sql_fetch . ." processed in inner loop" cr
		false
	} sql_fetch . ." processed in outer loop" cr
	." END TEST 2" cr
	sqlok?
	;
: done
 db sql_close
 cr ." Done " cr
	sqlok?
 bye
 ;



init
test1
test2
done

