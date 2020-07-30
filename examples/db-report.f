needs db/sqlite
needs db/report


with~ ~db

variable db

: create-db " reporttest.db" sql_open db !  ;
: close-db db @ sql_close ;
: initialize-reports ( db -- )
	dup
	quote *
	begin;
	insert into reports values (1, 'test', 'just a test report');
	insert into report_data values (
		1, 1, 'RH', ' " Report header line" println ');
	insert into report_data values (
		1, 2, 'PH', ' " Page header for page " print page# println ');
	insert into report_data values (
		1, 4, 'DL', ' 10 times " uninteresting detail line" println');
	insert into report_data values (
		1, 5, 'PF', ' " Page footer for page " print page# println ');
	insert into report_data values (
		1, 6, 'RF', ' " Report footer line" println ');
	commit;
* sql_exec

	dup	quote *
	report: joe-bob
	description: I can't say this is NOT a test
	RH " Hi there, dude!" println
	RH 1 sql: select x,y from a order by x;
	DL " hi" println 1 sql " x,y = (" print 1 col print " ," print 2 col print " )" println
	RF " this is the end of the line, bubba." println
	* init-report-from-string
	." defined report# " . cr
	
	quote *
	report: parameters
	description: This takes two parameters
	RH " Parameter 1 is " print 1 param$ println
	RH " Parameter 2 is " print 2 param# print#  0L println
	RH 1 sql: select x,y from a where x=:1 order by x;
	RH 2 sql: select :1 from a limit 1;

	DL  " int binding test:" println
	DL  1 2 param# 1 bind#
	DL  1 sql " x,y = (" print 1 col print " ," print 2 col print " )" println
	DL  " string binding test:" println
	DL  1 1 param$ 2 bind$
	DL  2 sql  1 col println
	RF " end-of-report" println
	* init-report-from-string
	." defined report# " . cr
	;
: initialize-db db @ dup quote *
create table a ( x , y );
create table b ( q , r );
insert into a values (1,2);
insert into a values (3,4);
insert into b values (1,'one');
insert into b values (1,'one-a');
insert into b values (3,'three');
* sql_exec 
	dup ~db.init-report-schema 
	initialize-reports
	;


: runreport 
	cr cr ." Report #" dup . cr cr
	db @ swap  ~db.run-report ;

: runreport$ ( db a n -- )
	cr cr ." Report " 2dup type cr cr
	run-report-by-name
	;

: main
	create-db
	initialize-db
	1 runreport
	db @ " joe-bob"  runreport$

	" hi there" 1 set-report-param$
	1 2 set-report-param#

	." the parameters are: " cr
	1 ~report.param$ type cr
	2 ~report.param# . cr

	db @ " parameters" runreport$
	close-db
	;

main bye
