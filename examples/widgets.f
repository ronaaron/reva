variable widget_count
: widget: ( <name> -- )
	| compile time: create the widget, keep track of total:
	create 
		widget_count ++		| bump count for next one
		widget_count @ , 	| store count-so-far in this instance

	| run time: print a message
	does>
		." Widget #" ? ." of " widget_count ? cr 
	;
| make a few instances of widgets:
widget: first_widget
widget: second_widget
widget: third_widget


| run them
first_widget second_widget third_widget bye
