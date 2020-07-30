| OOP sort of widgets
variable widget_count
: button-widget ( a -- ) ." is a button, at address: " .x cr ;
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
first_widget second_widget third_widget bye
