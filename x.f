needs debugger
 needs asm/x86

: x inline{ 89 45 00 } ; 
: y asm{ EAX 0 [EBP] MOV } ; 

: x inline{ 01 45 00 } ;
: y asm{ EAX 0 [EBP] ADD } ;
0 [IF]
see x
see y
~disasm.postfix
see x
see y
[ELSE]
' x 6 dump
' y 6 dump
[THEN]

bye
