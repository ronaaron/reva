needs date/sunrise
with~ ~floats
with~ ~date

: .02d ( n -- a n ) 2 '0 (p.r) type ;
: .time ( hh:mm --  ) 60 /mod .02d ': emit .02d  ;

| Maale Adummim:
31 46	>latitude
-35 18	>longitude
120		>timezone | only correct for 'winter time'.  otherwise, use '180'

." Sunrise and sunset for today in Maale Adummim:" cr

today rise-set
." Rise: " .time cr
." Set:  " .time cr

today dawn-dusk
." Dawn: " .time cr
." Dusk: " .time cr

bye
