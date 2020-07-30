needs revagui/window
needs revagui/button
needs callbacks

with~ ~revagui


0 value w
0 value b
variable has-clicked

: mycallback callback ( object dataptr -- )
	has-clicked @ 0if 
		b z" Don't click me again!" setlabel 
		has-clicked on
	else
		." ARRGH!!!" cr bye
	then
	;

100 100 400 200 z" Hi there" window_xy to w
	w window_begin
	20 40 260 100 z" Click me!" button to b
	w window_end

b ' mycallback 1000 setcallback

w window_show run bye
