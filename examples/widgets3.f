| OOP sort of widgets
| This time, we keep track of widget state and perform a different action each
| time the widget is invoked.  This is done without a lookup table, extra
| variables or "if" statements:

variable widget_count
: setxt ( a xt -- ) over cell+! ;
: button3
	." button phase three at " .x cr 
	;
: button2
	['] button3 setxt
	." button phase two, at " .x cr 
	;
: button-widget ( a -- ) 
	['] button2 setxt
	." initializing button, at address: " .x cr ;

: text-widget ( a -- ) ." is text at address: " .x cr ;

: widget: ( xt <name> -- )
	| compile time: create the widget, keep track of total:
	create 
		widget_count ++		| bump count for next one
		widget_count @ , 	| store count-so-far in this instance
		,					| store the XT which implements specific behavior

	| run time: print a message
	does>
		dup
		." Widget #" ? ." of " widget_count ? cr 
		dup cell+ @execute 
	;
| make a few instances of widgets:
' button-widget widget: first_widget
' button-widget widget: second_widget
' text-widget widget: third_widget

| run them
first_widget second_widget third_widget
first_widget second_widget first_widget
first_widget
bye
