| simple Hello World ...
| part 2

needs ui/gui

with~ ~ui

: quit callback  ." Goodbye, cruel world!" cr gui-close ; 

: define-dialog ( -- dialoghandle )
	dialogs[
		| we want the button in the middle of the dialog, so put it in a
		| vbox/hbox combo:
		vbox[
			hboxs[
				" Bye" button[ action: quit ]w
			]c
		]c
	]d 
	" 150x150" size				| make the dialog 150x150 pixels, otherwise it
								| gets created "just big enough" to hold the contents
	" Press the button to quit" tip	| give the dialog a "tooltip"
	" Hello, word 2!" title
	;

: main 
	define-dialog
	show
	gui-main-loop
	;

main bye
