needs date/hebrew
~date ~priv


: print
	do
		i .
		i hebrew-calendar-elapsed-days . 
|		i days-in-hebrew-year . 
|		i hebrew-leap-year? . 
|		i short-kislev? .
|		i long-heshvan? .
		cr

	loop
	;

5801 5700 print bye
