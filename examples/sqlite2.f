| --------------------------------------------------------------------
needs db/sqlite
with~ ~db

variable counter
0 value db
0 value sql1
0 value sql2
0 value sql3

: sqlok?
	sql_result @ dup 0if
		drop ." OK" cr
	else
		." SQL error: " . 
		db sql_errmsg type cr bye
	then
	;

: init
	." Opening/creating the database..." cr
	" test2.db" 2dup delete sql_open to db 
	sqlok?

	." Populating the database..." cr
	db sql_begin
	db " create table a ( b char, c char )" sql_exec 
	db " create table blobs ( a int, b blob )" sql_exec
	db " insert into a values ('one', 'first number')"  sql_exec 
	db " insert into a values ('two', 'second number')" sql_exec
	db " insert into a values ('two', 'second number again')" sql_exec
	db " insert into a values ('three', 'after two')"  sql_exec
	db " insert into a values ('four', 'two times two')"  sql_exec
	db sql_commit
	sqlok?
	;

: done
 sql1 sql_finalize
 sql2 sql_finalize
 sql3 sql_finalize
 db sql_close
 cr ." Done " cr
 sqlok?
 bye
 ;

: test1
	." Creating a prepared statement: " cr
	db " select c from a where b = :1 ;" 
		sql_prepare to sql1

	sqlok?
	;

: test2
	sql1 0;
	." Binding prepared statement with value = 'one'" cr
	1 " one" sql_bind_string
	sqlok?
	;

: one-row ."   ROW: ["  0 sql_pcol_text type '] emit cr true ;

: test3
	." Executing prepared and bound statement:" cr
	sql1 ['] one-row sql_pexec
	sqlok?
	;

: test4
	." Bind and prepare for value = 'two':" cr
	sql1 1 " two" sql_bind_string
	sqlok?
	." Executing bound statement:" cr
	sql1 ['] one-row sql_pexec
	sqlok?
	;

create theblob
    0 , 101 , 102 , 103 ,  -1 ,

: test5
	." Create second prepared statement:" cr
	db " insert into blobs values(1, :1);" sql_prepare to sql2 sqlok?
	." Binding the blob:" cr
	sql2 1 theblob 5 cells sql_bind_blob sqlok?
	." Running the statement:" cr
	sql2 0 sql_pexec sqlok?
	;


: blob-row
	." blob-row: " cr
	0 sql_pcol_blob sqlok?
	dump cr
	theblob 5 cells dump cr
	true
	;

: test6
	." Create third prepared statement:" cr
	db " select b from blobs where a=1;" sql_prepare to sql3 sqlok?
	." Retrieving the blob:" cr
	sql3 ['] blob-row sql_pexec sqlok?
	;

init
test1 test2 test3 test4
test5 test6
done
