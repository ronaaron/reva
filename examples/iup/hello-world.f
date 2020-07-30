| simple Hello World ...

needs ui/gui

with~ ~ui

: quit callback  ." Goodbye, cruel world!" cr gui-close ; 

: define-dialog ( -- dialoghandle )
	dialog[
		" Bye" button[ action: quit ]w
	]d " Hello, word!" title
	;

: main 
	define-dialog
	show
	gui-main-loop
	;

main bye
