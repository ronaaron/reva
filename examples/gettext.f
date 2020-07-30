
| test the gettext functions...

needs string/gettext

" gettext-test.po" set-po

: hi 
	_( hello world!)
	type_ ;

: there _( whatever, man) type_ ;

: main hi there  bye ;

' main is ~sys.appstart
" gettext" makeexename (save) bye
