| This program calculates "halachic times".  
| See "http://www.chabad.org/calendar/location.htm" for more information about
| just what that means.

needs string/trim
needs date/hebrew
needs date/sedra
needs date/sunrise
needs date/parse

~date ~floats ~sys ~

context: ~zmanim ~zmanim

-7.0 fconstant DUSK
-8.5 fconstant DAWN	
0 constant TZ_NONE
1 constant TZ_USA
2 constant TZ_ISRAEL
3 constant TZ_EU
24 60 * constant 12AM

: .02d ( n -- a n ) 2 '0 (p.r) type ;
: .time ( hh:mm --  ) 
	dup dup 
	0 < swap
	12AM > or
	if ." --:-- " drop ;then
	60 /mod .02d ': emit .02d  space ;

variable current-location
variable tz-type
variable quiet
variable all-locations
variable texmode

fvariable (dawn)
fvariable (dusk)

: dawn-degrees (dawn) f! ;
: dusk-degrees (dusk) f! ;

create location-name 256 allot

: location: ( <name> )
	parseln trim (create)
		here current-location !
		0 , 0 ,	| longitude
		0 , 0 , | latitude
		0 , 0 , | tz, tz-type
		last @ dup >name ,
		all-locations link | start-of-list !
	does>
		dup current-location !
		| set longitude:
		dup 2@ >longitude
		| set latitude:
		2cell+ dup 2@ >latitude
		| set timezone
		2cell+ dup @ >timezone
		dup cell+ @ dup tz-type !  TZ_ISRAEL = in-israel
		2cell+ @ count location-name place
	;
: longitude ( deg mm -- ) current-location @ 2! ;
: latitude ( deg mm -- )  current-location @ 2cell+ 2! ;
: timezone ( type offset -- ) swap current-location @ 4cell+ 2! ;

variable printed-one
: .locations
	printed-one off
	{
		printed-one @ if '; emit space then
		@ >name ctype 
		printed-one on

		true
	} all-locations iterate 
	;
: find-location ( a n -- )
	find-dict dup 0if
		drop
		quiet @ if eval else type_ ." is an unknown location!  Try one of:" cr .locations cr then
	;then
	exec
	;
: default-location: ( <name> -- )
	parseln trim find-location ;
4 variable, weeks-to-print
: print-weeks ( n -- ) weeks-to-print ! ;
variable start-date

| Time-zone corrections for daylight savings:
: tz-usa start-date @ dst? if 60 + then ;
: tz-israel start-date @ israel-dst? if 60 + then ;
: tz-eu start-date @ eu-dst? if 60 + then ;
variable force-dst
: dst-on force-dst on ;

| This is a dispatch-table.  The 'tz-type' indexes into it to select
| the correct adjustment for DST (based on the location's information)
create tz-correct
	' noop ,
	' tz-usa ,
	' tz-israel ,
	' tz-eu ,
: do-tz-correct 
	dup -1 - 0;drop
	force-dst @ if 60 + ;then tz-type @ cells tz-correct + @execute ;

| Assumes location has been set already
variable set 
variable rise
variable dusk
variable dawn
variable shaah
variable hatsot
variable sedra?
variable hebdate?
variable midnight?
variable shaah?
: shaot ( x n -- y ) shaah @ 12 */ + ;
: -v cr ." zemanim 2.10" cr ;
: -t texmode on ;
: -h -v cr quote =
This program display halachic times.  It can take its  options from the file
"zemanim.ini" located in the same place as the program itself, or from the
command-line.  See the zemanim.ini which was distributed with the program for
all the details.  In short, command line options are:

* -h    display this help
* -v    show the version number of the program
* -l    print the list of locations known to this program
* -t    print the list in a format suitable for input to TeX
* place use 'place' as the location for which to generate times
* date  calculate starting on that date.  Format is 'mm/dd/yyyy' or 'mm/yyyy'
* dst-on force daylight-savings-time to be on
* no-sedra do not print the weekly sedra
* no-shaah do not print halachic hour length
* no-midnight do not print halachic midnight
* number print 'number' weeks of data
= type cr bye ;
: -l cr ." Locations currently known:" cr 
	.locations cr bye ;
: notime ." No sunrise/sunset calculated for this time and place" fdrop ;
: tex& texmode @ if '& emit then  ;
: calculate-zemanim
	| how many minutes is a temporary hour?
	set @ rise @ - 	shaah !
	| if there are less than 5 minutes, assume we can't give zemanim:
	shaah @ 5 <if
		notime
	;then

	| when is midnight?
	set @ 12AM over -		| minutes from sunset until midnight
	start-date @ 1+ fixed>gregorian rise-set nip  | minutes from midnight until sunrise
	| half the difference added to set is midnight:
	+ 2/ + 1440 mod hatsot !

	| dawn
	dawn @ .time
	| rise
	tex&
	rise @  .time
	| shema is end of 3 hours
	tex&
	rise @ 3 shaot  .time
	| tefilah is end of 4 hours
	tex&
	rise @ 4 shaot  .time

	| minHa gedola = 6.5 hrs
	tex&
	rise @ 6 shaot shaah @ 24 / + .time
	| minHa ketana = 9.5 hrs
	tex&
	rise @ 9 shaot shaah @ 24 / + .time
	| plag haminHa = 10.75 hrs
	tex&
	rise @ 10 shaot shaah @ 3 48 */ + .time

	| set 
	tex&
	set @ .time
	| night 
	tex&
	dusk @ .time
	| midnight
	midnight? @ if tex& hatsot @ .time then
	| shaah
	shaah? @ if tex& shaah @ 12 / .time  then
	| sedra
	sedra? @ if tex& start-date @ sedra type then
	| hebrew date
	hebdate? @ if 
		tex&
		space '( emit
		start-date @ fixed>hebrew .hebrew 
		') emit
		then
	texmode @ if ." \\cr" then
	;

: no-sedra sedra? off ;
: no-midnight midnight? off ;
: no-shaah shaah? off ;
: hebdate hebdate? on ;

: zemanim ( -- )
	texmode @ if quote !
	\input libertine
	\input liberation-mono
	\liberationmono12
!
	type then
	texmode @ if ." \\centerline{" then
	." Halachic times for " location-name ctype ': emit
	texmode @ if ." }" then
	cr
	texmode @ if 
	quote !
	\tt\halign{#\hfil & \hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\hfil#\hfil &\kern-1cm{\libertine10 #}\hfill\cr
	! type

		." &dawn&sunup&shema&tfila&m:ged&m:qet&m:plg&sundn&night"
		midnight? @ if ." &midnt" then
		shaah? @ if ." &shaah" then
		sedra? @ if ." &" then
		." \\cr"
	else
		."             dawn  sunup shema tfila m:ged m:qet m:plg sundn night"
		midnight? @ if ."  midnt" then
		shaah? @ if ."  shaah" then
		sedra? @ if ."  sedra" then
	then
	cr
	weeks-to-print @ 0do
		start-date @ fixed>gregorian

		3dup .date space
			texmode @ if '& emit then
		| dawn
		3dup (dawn) f@ false ~sunrise.sun-rise-set do-tz-correct dawn ! drop 
		| dusk
		3dup (dusk) f@ false  ~sunrise.sun-rise-set drop do-tz-correct dusk !
		 rise-set  
		| is there both rise and set?
		2dup -1 = swap -1 = or if
			notime
		else
			do-tz-correct rise ! do-tz-correct set !
			calculate-zemanim
		then
		cr
		| adjust next date:
		start-date @ Fri weekday-after start-date !
	loop
	;
exit~

~zmanim

| This is the list of locations we already know about internally:
| The list is in reverse-alphabetical order, simply so it displays in the
| correct order (each 'location' is a Reva word)
location: Washington DC
	77 0 longitude
	38 55 latitude
	TZ_USA -300 timezone
location: Vancouver
	123 7 longitude
	49 16 latitude
	TZ_USA -480 timezone
location: Tverya
	-35 31 longitude
	32 48 latitude
	TZ_ISRAEL 120 timezone
location: Tsefat
	-35 30 longitude
	32 58 latitude
	TZ_ISRAEL 120 timezone
location: Toronto
	79 24 longitude
	43 38 latitude
	TZ_USA -300 timezone
location: Tel Aviv
	-34 46 longitude
	32 5 latitude
	TZ_ISRAEL 120 timezone
location: Seattle
	122 20 longitude
	47 36 latitude
	TZ_USA -480 timezone
location: San Francisco
	122 25 longitude
	37 47 latitude
	TZ_USA -480 timezone
location: Saint Louis
	90 12 longitude
	38 38 latitude
	TZ_USA -360 timezone
location: Raanana
	-34 52 longitude
	32 11 latitude
	TZ_ISRAEL 120 timezone
location: Pittsburgh
	80 0 longitude
	40 26 latitude
	TZ_USA -300 timezone
location: Phoenix
	112 4 longitude
	33 27 latitude
	TZ_USA -420 timezone
location: Philadelphia
	75 10 longitude
	39 57 latitude
	TZ_USA -300 timezone
location: Orlando
	81 22 longitude
	28 32 latitude
	TZ_USA -300 timezone
location: Omaha
	95 56 longitude
	41 16 latitude
	TZ_USA -420 timezone
location: New York
	74 1 longitude
	40 43 latitude
	TZ_USA -300 timezone
location: Netanya
	-34 51 longitude
	32 19 latitude
	TZ_ISRAEL 120 timezone
location: Mexico City
	99 9 longitude
	19 24 latitude
	TZ_NONE -360 timezone
location: Miami
	80 12 longitude
	25 46 latitude
	TZ_USA -300 timezone
location: Maale Adummim 
	-35 18	longitude
	31 46	latitude
	TZ_ISRAEL 120	timezone
location: Los Angeles
	118 15 longitude
	34 4 latitude
	TZ_USA -480 timezone
location: London
	0 10 longitude
	51 30 latitude
	TZ_EU 0 timezone
location: Kirkland, WA
	122 12 longitude
	47 40 latitude
	TZ_USA -480 timezone
location: Johannesburg
	-26 12 longitude
	-28 3 latitude
	TZ_NONE 60 timezone
location: Jerusalem
	-35 14 longitude
	31 47 latitude
	TZ_ISRAEL 120 timezone
location: Houston
	95 22 longitude
	29 46 latitude
	TZ_USA -360 timezone
location: Hawaii
	155 30 longitude
	19 30 latitude
	TZ_USA -600 timezone
location: Haifa
	-34 59 longitude
	32 49 latitude
	TZ_ISRAEL 120 timezone
location: Gibraltar
	5 0 longitude
	36 0 latitude
	TZ_EU 0 timezone
location: Eilat
	-34 57 longitude
	29 33 latitude
	TZ_ISRAEL 120 timezone
location: Detroit
	83 2 longitude
	42 20 latitude
	TZ_USA -300 timezone
location: Denver
	104 59 longitude
	39 44 latitude
	TZ_USA -420 timezone
location: Dallas
	96 48 longitude
	32 47 latitude
	TZ_USA -360 timezone
location: Cleveland
	81 41 longitude
	41 30 latitude
	TZ_USA -300 timezone
location: Cincinnati
	84 31 longitude
	39 6 latitude
	TZ_USA -300 timezone
location: Chicago
	87 45 longitude
	41 50 latitude
	TZ_USA -360 timezone
location: Buffalo
	78 52 longitude
	42 53 latitude
	TZ_USA -300 timezone
location: Buenos Aires
	-34 37 longitude
	58 24  latitude
	TZ_NONE -180 timezone
location: Boston
	71 4 longitude
	42 20 latitude
	TZ_USA -300 timezone
location: Bogota
	74 5 longitude
	4 36 latitude
	TZ_NONE -300 timezone
location: Bnei Brak
	-34 50 longitude
	32 5 latitude
	TZ_ISRAEL 120 timezone
location: Berlin
	-13 24 longitude 
	52 31  latitude
	TZ_EU 60 timezone
location: Bellevue, WA
	122 8 longitude
	47 37 latitude
	TZ_USA -480 timezone
location: Beer Sheva
	-34 48 longitude
	31 15 latitude
	TZ_ISRAEL 120 timezone
location: Baltimore
	76 36 longitude
	39 17 latitude
	TZ_USA -300 timezone
location: Austin
	97 45 longitude 
	30 16 latitude
	TZ_USA -360 timezone
location: Atlanta 
	84 23 longitude
	33 45 latitude 
	TZ_USA -300 timezone
location: Ashdod
	-34 38 longitude
	31 48 latitude
	TZ_ISRAEL 120 timezone
location: Afula
	-35 17 longitude
	32 37 latitude
	TZ_ISRAEL 120 timezone

macro
: # parseln 2drop ;
forth
exit~
with~ ~zmanim

| I live here, so it's the default :) 
default-location: Maale Adummim

: load-settings
	reva ~zmanim
	appdir pad place
	" zemanim.ini" pad +place
	pad count (include)
	reva
	;

: do-command-line
	reva ~zmanim
	argc 2 <if ;then
	quiet on
	argc 1 do
		0 
		i argv find-location 
		dup if weeks-to-print ! then
		drop
	loop
	;
: main
	texmode off
	quiet off
	sedra? on
	midnight? on
	shaah? on
	hebdate? off
	DAWN dawn-degrees 
	DUSK dusk-degrees

	today>fixed start-date !
	load-settings
	| process command-line if any:
	do-command-line
	| generate the zemanim: 
	zemanim
	texmode @ if
		." } \\bye"
	then
	bye
	;

| trap invalid words, and see if we can make sense of them:
:: ( a n -- a n 0 | xt 1 | n 2 | n m 3 | 4 )
	parsedate if start-date ! 4 ;then
	chain word?
	; is word?
| generate a standalone app:
' main is ~sys.appstart
" zemanim" makeexename (save) bye
