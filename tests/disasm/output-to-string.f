pad value sbuf

| Execute xt with the output redirected to sbuf
: >sbuf  ( xt)
    ['] emit @ >r
    ['] type @ >r
    sbuf off
    { sbuf c+place } is emit
    { sbuf  +place } is type

    catch

    r> is type   
    r> is emit 
    
    throw ;
