| simple example of GUI console

needs ui/gui
needs ui/guiconsole

with~ ~ui

: quit callback  ." Goodbye, cruel world!" cr gui-close ; 

variable console?
: define-dialog ( -- dialoghandle )
	dialog[
		" show/hide Console" button[ { callback 
			console? @ not dup console? !
			gui-console
			} action ]w
		" close Console" button[ { callback 
			gui-console-close
			console? off
			} action ]w
		" Bye" button[ action: quit ]w
	]d " Hello, word!" title
	;

: main 
	define-dialog
	show
	gui-main-loop
	;

main bye
