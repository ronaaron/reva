needs asm/x86
needs testing

: assemble{ ( <asm> <}> -- addr)
    here  p: asm{ ;

: generating{ ( addr <bytes> <}> -- addr u addr')  
    here over - 
    here  p: inline{ ;

: test-as:  ( addr u addr' <name> -- )
    here over - cmp 0 =   
    p[ test: literal ; ]p ;


| --------------------------------------------------
assemble{ ecx  eax  bt } generating{ 0F A3 C8 }
test-as: Register/Register 

assemble{ 20 #  edx btc } generating{ 0F BA FA 14 } 
test-as: Register/Immediate

assemble{ -10 #  $1234 [esi]  btr } 
generating{ 0F BA B6 34 12 00 00 F6 }
test-as: Memory/Immediate

assemble{ edi  $12345678 #)  bt } 
generating{ 0F A3 3D 78 56 34 12 }
test-as: Memory(absolute)/Register

assemble{ 0 #  -20 [ebp] [edi] *4  bts } 
generating{ 0F BA 6C BD EC 00 } 
test-as: Memory(sib)/Immediate

| --------------------------------------------------

test
