| simple Hello World ...
| part 3

needs ui/gui

with~ ~ui

variable quitting

: quit callback quitting on ." Goodbye, cruel world!" cr gui-close ; 
: no-quit callback quitting off ." I'm alive, ALIVE!!" cr gui-close ;

: define-popup ( -- popuphandle )
	dialogs[
		hboxs[
			" Keep alive" button[ action: no-quit ]w
			spacer
			" Quit" button[ action: quit ]w
		]c
		spacer
	]d 
	" 150x50" size
	" Make your choice" title
	;

: quit? callback define-popup popup quitting @ if gui-close then ;
: define-dialog ( -- dialoghandle )
	dialogs[
		| we want the button in the middle of the dialog, so put it in a
		| vbox/hbox combo:
		vbox[
			hboxs[
				" Bye" button[ action: quit? ]w
			]c
		]c
	]d 
	" 150x150" size				| make the dialog 150x150 pixels, otherwise it
								| gets created "just big enough" to hold the contents
	" Press the button to quit" tip	| give the dialog a "tooltip"
	" Hello, word 3!" title
	;

: main 
	define-dialog
	show
	gui-main-loop
	;

main bye
