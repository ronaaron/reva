needs os/console

create color-constants
'' black   ,
'' red     ,
'' green   ,
'' blue    ,
'' yellow  ,
'' magenta ,
'' cyan    ,
'' white   ,


: hue  ( n -- n1 ) 
    cells color-constants + @ exec ;

: name   ( n -- a # )
    cells color-constants + @ >name count ;

: adjust ( fg bg -- fg bg' ) | to avoid printing 
                             | background color on itself
    2dup = xor white and ;

: foregrounds
    normal ." Foreground colors:" 
    8 0do 
	i hue black adjust color
	space i name type space 
    loop 
    normal cr ;

: backgrounds
    normal ." Background colors:"
    8 0do 
	space
	i hue white adjust swap color
	i name type 
	normal space
    loop 
    cr ;
    
: n.   '0 + emit ;

: ncr   normal cr ;

: color-table
    ncr ." Full color table. The order of colors may vary depending on the library:" 
    cr
    8 0do
	8 0do
	    i j color 
	    space i n.
	    j n. space
	loop 
	ncr
    loop ;


: attributes
    ncr 
    ." Attributes. Results may vary dramatically depending on the terminal:" cr
    blink ." This is 'blinking' text." ncr
    bright ." This text is 'bright'."         ncr
    concealed ." This text is 'concealed'."   ncr
    bold  ." This text is 'bold'."            ncr
    underscore ." This text is 'underlined'." ncr 
    reverse ." This text is 'reversed'."      ncr ;

: test 
    foregrounds
    backgrounds
    color-table 
    attributes ;

test
cr cr ." Press any key to exit."
ekey drop bye
