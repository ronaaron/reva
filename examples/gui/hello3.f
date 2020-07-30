needs revagui/window
needs revagui/button
needs revagui/enumerations
needs callbacks

with~ ~revagui

: mycallback callback ( object dataptr -- )
	0 cb-param
	dup get_userdata		| widget data
	0if 
		dup 1 set_userdata
		dup FL_RED setcolor
		dup z" Don't do that!" setlabel 
		| move the window a bit ...
		parent 
			dup getpos 50 + 50 _+ setpos
	else
		." ARRGH!!!" cr bye
	then
	;


: init ( -- w )
	100 100 400 200 z" Hello Two" window_xy 
		dup window_begin
		20 40 150 100 z" Click me!" button 
			['] mycallback 0 setcallback
		dup window_end
	;

: dostuff ( w -- )
	window_show run
	;

init dostuff bye
