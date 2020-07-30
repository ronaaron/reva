needs util/disasm
needs string/trim
needs string/misc
needs asm/x86
needs testing

needs string-util.f
needs output-to-string.f
needs nasm.f

variable details
details off

variable suppress-dword
suppress-dword on

strnew: disassembled
disassembled to sbuf

with~ ~disasm
-1 to prefix-operands-column
-1 to instruction-width
-1 to postfix-mnemonic-column

   

| disassemble a single instruction at `addr` 
| return the result as a string `addr1 u`
: dis-op ( addr -- addr1 u)
    clear-args
    $10 base xchg 
    swap pc !   
    { dis-body  .instruction  } >sbuf 
    base!
    sbuf count ;

without~

with~ ~sys
: asm  ( a n dst -- dst n' )
    $10 base xchg >r
    dup >r (here) xchg >r
    { push~ ~asm eval pop~ } catch
    r> (here) xchg
    r> tuck - 
    r> base! 
    rot throw  ;

without~

: prepare ( addr u -- addr u')
    trim  compact-whitespace ;

defer .details
defer assemble

| assemble an instruction from the string `addr2 u2`
| store the result at `scratch`
| disassemble it back and compare the result against
| the expected string `addr1 u1`
: test-dis  ( addr1 u1 addr2 u2 -- )
    scratch assemble
    0if  3drop 0  ;then
    dis-op prepare
    4dup
    cmp  0if 
	2drop 2drop true
    else
	.details    false
    then
;


strnew: expected
defer >expected

: (prefix>expected) ( addr u -- addr' u')
    >r expected r@ move
    expected r>
    prepare
    " tword"  " tbyte"    replace
    " 0x"     " "         replace
    '$ remove
    suppress-dword @ 0;drop
    " dword " " "         replace
;

: (postfix>expected)  
    >r expected r@ move
    expected r>
    prepare ;

: test-1 ( addr1 u1)
  2dup >expected 2swap test-dis ;
    

: str,  ( cadrr)
    count swap literal, literal, ;

with~ ~test

:: talk
   details @ 0if  2drop 2drop  ;then
   cr
   ."     Got:      '" type ." '"  cr
   ."     Expected: '" type ." '"  cr
   mute ; is .details

: make-test ( addr u -- true|false )
	here -rot
	(test)
	str,
	p[ ] test-1 ; ]p ;

| see disasm-test.f for usage
: t:  
    10 parse trim    make-test ;

: t{
    repeat 
	parsews 
	2dup " }" cmp 0if 2drop ;then
	make-test
    again ;

: t/
    here 
    '/ parse trim 
    (test)
    10 parse trim 
    (") | "
    str,
    p[ ] test-dis ; ]p
;
without~
: test-prefix
    ['] nasm is assemble
    ['] (prefix>expected) is >expected 
    ~disasm.prefix
    ;

: test-postfix
    ['] asm is assemble
    ['] (postfix>expected) is >expected 
    ~disasm.postfix
    ;

test-prefix
