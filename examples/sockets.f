needs net/sockets

variable sock
with~ ~sockets

: init
	" ronware.org" 80 connectsocket	|  -1 on failure, else a valid socket we can talk to
	sock ! ;

: ok
	sock @ 1+ 0if ." Couldn't open a socket." cr bye then
	." Got a valid socket: " sock @ . cr
	;

: +lplace-cr
	scratch +lplace
	crlf scratch +lplace ;

: getpage 
	scratch off
	" GET /ok.html HTTP/1.1" +lplace-cr
	" Host: ronware.org:80" +lplace-cr
	crlf scratch +lplace 
	sock @  scratch lcount 0 send ." send: " . cr
	sock @ scratch 4096 0  recv
	scratch swap type cr 
	;
	

init ok getpage sock @ closesocket bye
