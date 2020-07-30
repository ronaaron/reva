needs revagui/window
needs revagui/button
needs revagui/enumerations
needs revagui/textdisplay
needs revagui/textbuffer
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
		200 100 200 50 z" some text" text_display 
			text_buffer dup 
			quote *
line 1
line 2
line 4
line 8
line 16
line 32
*			zt tb_settext
			td_setbuffer

		20 40 150 100 z" Click me!" button 
			['] mycallback 0 setcallback
		dup window_end
	;

: dostuff ( w -- )
	window_show run
	;

init dostuff bye
