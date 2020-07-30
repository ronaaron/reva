| using app library:
needs app/gui

with~ ~ui

::
	dialog[
		vbox[
		" Hello, world!" label[ ]w
		]w
	]dw show
	; is ~app.pre-main

:: 
	." Goodbye, cruel world!" cr
	; is ~app.post-main


save hello-gui
