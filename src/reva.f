'1 emit
: ! [ $18891e8b ,  $adad 2,  ;inline
' 'macro : macro  literal  default_class ! ;
' 'forth : forth  literal  default_class ! ;
: 2drop [ $8d04468b , $0876 2, ;inline
: parseln 10 parse ;
macro
: ( ') parse 2drop ;
( ========================= CORE WORDS ================== )
: 0; [ $0275c009 , $c3ad 2, ;inline 
: 0;drop [ $75adc009 , $c301 2, ;inline 
: drop ( a -- )   [ $768d068b , $04 1, ;inline 
forth
: xchg ( n a -- a^ ) [ $0e8b188b , $d8890889 , $04768d 3, ;
: (inline) parsews >single 0;drop 1, (inline) ;
: -- [ $ff 1, 8 1, $ad 1, ;inline 
macro
'2 emit
: | >in -- parseln 2drop ;
: inline{
   16 base xchg
    (inline)
    2drop base !  ;
forth
: dup ( a -- a a ) inline{ 8d 76 fc 89 06 } ;inline
: 1+ ( a -- a+1 ) inline{ 40 } ;inline | inc eax
: 1- ( a -- a-1 ) inline{ 48 } ;inline | dec eax
: _1+ ( a b -- a+1 b ) inline{ ff 06 } ;inline
: - inline{ 29 06 } drop ;inline
: + inline{ 01 06 } drop ;inline
: and inline{ 21 06 } drop ;inline
: or inline{ 09 06 } drop ;inline
: xor inline{ 31 06 } drop ;inline
: not inline{ 83 f8 01 19 c0 } ;inline  | cmp eax,1 ; sbb eax,eax
: invert inline{ f7 d0 } ;inline | not eax
: << inline{ 89 c1 ad d3 e0 } ;inline 
: >> inline{ 89 c1 ad d3 e8 } ;inline 
: +! inline{ 89 c3 ad 01 03 ad } ;inline
: @ inline{ 8b 00 } ;inline 
|	mov ebx, eax
|	mov eax, [esi]
|	mov [esi], ebx
: swap inline{ 89 c3 8b 06 89 1e } ;inline
: * inline{ f7 26 83 c6 04 } ;inline 
: ++ inline{ ff 00 ad } ;inline 
: cell+ inline{ 8d 40 04 } ;inline 
: cell+! cell+ ! ;
: cell+@ cell+ @ ;inline
: cell- inline{ 8d 40 fc } ;inline 
: cell-! cell- ! ;
: cell-@ cell- @ ;inline

: 2cell+ inline{ 8d 40 08 } ;inline 
: rot inline{ 50 8B 46 04 8B 1E 89 5E 04 8F 06 } ;
: -rot inline{ 50 8B 5E 04 8B 06 89 1E 8F 46 04 } ;
: c@ inline{ 0f b6 00 } ;inline | movzx eax, byte [eax]
: nip inline{ 8d 76 4 } ;inline | lea esi, [esi+4]
: r> dup inline{ 58 } ;inline | [ $58 1, ;
: r@ r> inline{ 50 } ;inline | [ $50 1, ;
: >r inline{ 50 ad } ;inline | [ $ad50 2, ;
: 00; inline{ 09 c0 75 01 c3 } ;inline | or eax, eax; jnz .done; ret; .done:
: true -1 ;
: false 0 ;
: between inline{ 89 c3 ad 89 c1 ad 93 40 29 c8 29 cb 29 c3 19 c0 } ;
: tuck inline{ 8D 76 FC 8B 5E 04 89 1E 89 46 04 } ;
: _nip ( a b c d -- a c d ) | like 'rot drop'
    inline{ 8B 1E 83 C6 04 89 1E } ; 
: c!  inline{ 8b 1e 88 18 8b 46 04 8d 76 08 } ; | mov ebx, [esi]; mov [eax], bl; drop2
: / inline{ 89 C3 AD 99 F7 FB } ;inline
: hex 16 : base! base ! ; : decimal 10 base! ; : binary 2 base! ; : octal 8 base! ;
: ((cmp)) [ $b8ad063b , 0 , ;inline | cmp eax, [esi] ; lodsd ; mov eax, 0 ....
: < ((cmp)) inline{ 7e 01 48 } ; | jle .1; dec eax
: > ((cmp)) inline{ 7d 01 48 } ; | cmp eax, [esi]; lodsd; mov eax, 0; jge .1; dec eax
: = ((cmp)) inline{ 75 01 48 } ;
: <> ((cmp)) inline{ 74 01 48 } ;
'3 emit
: compiling? state @ ;
: over dup inline{ 8b 46 04 } ;
: third inline{ 8D 76 FC 89 06 8B 46 08 } ; | same as "2 pick"
: here (here) @ ;
: off inline{ 31 db 89 18 }  drop ;
: on  inline{ 31 db 4b 89 18 } drop ;
: (.) 0 (.r) ;
: . (.) | then type_ ...
: type_ type : space 32 emit ;
: .r (.r) type_ ;
: cr 10 emit ;  : dblquote '" emit ;  : question '? emit ; 
: lparen '( emit ; : rparen ') emit ;
: ? @ . ;
| ==== OFFSET WORDS ====
: >xt cell+ ; 
: 0>00; inline{ 85 C0 75 07 8D 76 FC 89 06 5B C3 } ; 
: count 0>00; dup c@ _1+ ; | swap 1+ swap ;
: ctype count type ;
| mov ecx, eax;drop;mov ebx,eax;drop;imul ebx;idiv ecx
: allot (here) +! ;
: '' parsews find-dict ;
: xt 00; >xt @ ; | take dict and return 0 or xt
: find find-dict xt ;
: lastxt last @ >xt @ ;
: alias ( xt -- ) header last @ >xt ! ;
' literal alias literal,

' cell- alias >class
' 2cell+ alias >name
: @litcomp dup cell+@ literal, cell-@ compile ;
macro
: p: '' @litcomp  ;
: ['] ' p: literal ;
: [''] '' p: literal ;

| class words:
: notail ['] 'notail default_class ! ;
: mnotail ['] 'macront default_class ! ;
forth
: (if $063b 2, p: 2drop ; | cmp eax, [esi]; lodsd; lodsd
: if) 0 , here ;
: back compile here  5 -  ++ ;
'6 emit
mnotail
: then align here over - swap cell-!  ;
macro
: 0if $0fadc085 , $85 1, if) ; | test eax, eax; lodsd; jnz ...
: =if (if $850f 2, if) ;
: <>if (if $840f 2, if) ; 
: >if (if $8d0f 2, if) ; 
: <if (if $8e0f 2, if) ;
: if $0fadc085 , $84 1, if) ; | thanks, malcoln
: else 0 back here swap p: then ; 
: ;then p: ;; p: then ;


forth
'4 emit
variable classes
	'' 'forth classes link 
	'' 'macro classes link 
	'' 'defer classes link 
	'' 'notail classes link 
	'' 'inline classes link 
	'' 'value classes link 
	'' 'constant classes link 
	'' 'variable classes link 
	'' 'does classes link 
macro
: newclass last @ classes link ;
forth  
: class! ( a -- ) last @ cell-! ;
: pdoes 
	| r: code-after-does>
	| set the class of the current word to be "'does"
	['] 'does class!
	| set the offset of this word:
	r> lastxt cell-!
	;
: create parsews : (create) align 0 , (header) ['] 'variable class! ;
macro
: constant 
    create ,
    ['] 'constant class! ;
mnotail
: does> ['] pdoes compile 
	here
	last @ >name
	count + 1+ !
	4 dict +!
    ;
: super> ( <name> -- ) | compile call to "does" for <name>
	'' >name count + 1+ @
	compile
	;
variable (THROW:)
: THROW: ( <name> -- )
    (THROW:) -- 
    create (THROW:) @ , 
    does> @ throw
    ;

THROW: THROW_GENERIC
THROW: THROW_BADFUNC
THROW: THROW_BADLIB
THROW: THROW_NEEDS
THROW: THROW_ASM_REF
THROW: THROW_ASM_LOOPX

| ASSEMBLER
| NOTE:  The assembler is an adaptation of the FirmWorks assembler.
| Please read the 'LICENSE' file for the full text of their license
forth

| DO NOT MOVE 'REG'!  It marks the start of the assembler code, and we will
| rework the list to move it into the '~asm' context later on
: REG ( mod reg# -- ) 9 * swap &1000 * or p: constant ;
0 0 REG AL		0 1 REG CL		0 2 REG DL		0 3 REG BL
0 4 REG AH		0 5 REG CH		0 6 REG DH		0 7 REG BH
1 0 REG EAX		1 1 REG ECX		1 2 REG EDX		1 3 REG EBX
1 4 REG ESP		1 5 REG EBP		1 6 REG ESI		1 7 REG EDI
2 0 REG [EAX]	2 1 REG [ECX]	2 2 REG [EDX]	2 3 REG [EBX]
2 4 REG [ESP]	2 5 REG [EBP]	2 6 REG [ESI]	2 7 REG [EDI]
3 0 REG ES		3 1 REG CS		3 2 REG SS		3 3 REG DS 
3 4 REG FS		3 5 REG GS
4 0 REG #		4 1 REG #)		4 2 REG S#)

-1 constant [NOB]		| null base register

variable BASE-REG
variable INDEX-REG
variable SCALE-FACTOR

| The 10000 bit is carefully chosen to lie outside the fields used
| to identify the register type, so as not to confuse SPEC?
[ESP] &10000 or constant [SIB]	

: RESET-SIB
	[ESP] dup BASE-REG ! INDEX-REG !
	SCALE-FACTOR off ; RESET-SIB

| Scaled indexing address mode.  Examples:
|   1234 [ESI]  [EBP] *4
|      0 [ESP]  [EBP] *1
|   5678 [NOB]  [ESI] *2
: SCALE:  ( SCALE-FACTOR <name> -- )
   create ,
   does> ( disp BASE-REG INDEX-REG apf -- disp mr )
      @ SCALE-FACTOR ! INDEX-REG  ! BASE-REG ! [SIB] ;
&000 SCALE: *1	&100 SCALE: *2	&200 SCALE: *4	&300 SCALE: *8
| defines words which test for addressing modes
: MD  create &1000 * ,
	does> @ swap &7000 and = ;
| Test for modes:
0 MD R8?   1 MD R16?   2 MD MEM?   3 MD SEG?   4 MD #?	5 MD MM?

: SPEC?  ( n -- f ) &7000 and &5000 < not ;

| tests for any register mode
: REG?   ( n -- f )   &7000 and &2000 <  ;
| tests offsets size:
: SMALL?   ( n -- flag )   -&200 &177 between  ;
: BIG?     ( n -- flag )   SMALL? not  ;

| mask off all but low register field.
: RLOW   ( n1 -- n2 )    &7 and ;
| mask off all but middle register field.
: RMID   ( n1 -- n2 )   &70 and ;

| true for 16 or 32 bit, false for 8 bit.
true variable, SIZE  

| address/data size overrides:
variable ADDRESS-OV
variable DATA-OV

: 16BIT?  false ADDRESS-OV @ xor  ;

: ASM16, ( n -- ) dup $ff and 1, 8 >> $ff and 1, ;
: ASM32, ( n -- ) dup $ffff and ASM16, 16 >> ASM16, ;
: ADR,    ( n -- )  ADDRESS-OV @ | fall through
: (ASM) false xor if ASM16, else ASM32, then ;
: ASM,    ( n -- )  DATA-OV @    (ASM)  ;
: NORMAL   ( -- )   SIZE on RESET-SIB | fall through
: CLEAR-OV   ( -- )    DATA-OV  off ADDRESS-OV off ;
| OR two numbers and assemble.
: OP,    ( n op -- )   or 1,  ;
| assemble opcode with W field set for SIZE of register.
: WF,   ( op mr -- )   R16? 1 and OP,  ;
| assemble opcode with W field set for SIZE of data.
: SIZE,  ( op -- op' )   SIZE @ 1 and OP, ; | 1 size@& OP,  ;
|  assemble either 8 or 16 bits.
: ,/C,   ( n f -- )   if  ASM,  else  1,  then  ;
: MOD-RM,  ( mr RMID mod -- )  -rot RMID swap RLOW or OP,  ;
|  assemble register to register instruction.
: RR,    ( mr1 mr2 -- )   &300 MOD-RM,  ;
| Assemble mod-r/m byte and s-i-b byte if necessary
: SOP,  ( mr RMID mod -- )
	16BIT? 0if
		third  [SIB] =if			( [SIB] RMID mod )
			[ESP] -rot  MOD-RM,			( [SIB] ) | scaled index mode
			drop					( )
			BASE-REG @ INDEX-REG @ SCALE-FACTOR @ MOD-RM,   
		;then					( mr RMID mod )
		third  [ESP] =if			( mr RMID mod )
			MOD-RM,				( )	| disp[esp] uses sib
			[ESP] [ESP] 0 MOD-RM,			( )
		;then					( mr RMID mod )
	then						( mr RMID mod )
	MOD-RM,					( )	| not scaled index mode
;
| handles memory reference modes.  it takes a displacement,
| a mode/register, and a register, and encodes and assembles them.
| uses MEM, after packing the register SIZE into the opcode
: WMEM,   ( disp mem reg op -- )   over WF, 
: MEM,   ( disp mr RMID -- )
	| the absolute address mode is encoded in place of the
	| (nonexistent) "<no-displacement> [ebp]" mode.
	over #) =if
		5 16BIT?  if  1+ then
		swap 0 MOD-RM, drop  ADR,  
	;then  ( disp mr RMID )

	16BIT? 0if
		| special case for "0 [ebp]" ; use short 0 displacement
		| instead of [ebp] (there is no [ebp] addressing mode
		| because that encoding is used for 32-bit displacement.)
		third 0if
			over  [EBP] =if           ( disp mr RMID )
				&100 MOD-RM, 1,  
			;then                                         ( disp mr RMID )

			BASE-REG @ [EBP] =if           ( disp mr RMID )
				&100 MOD-RM, 
				5 INDEX-REG @ SCALE-FACTOR @ MOD-RM, 1,
			;then                                         ( disp mr RMID )
		then

		| special case for "disp32 [no-base-reg] [index-reg] *scale"
		over [SIB] =if                             ( disp mr RMID )
			|	 protected-only
			BASE-REG @ [NOB] =if                      ( disp mr RMID )
				0 MOD-RM,                              ( disp mr RMID )
				5 INDEX-REG 0 MOD-RM, | @ SCALE-FACTOR @ MOD-RM,          ( disp )
				r> ADR,                                   ( )
			;then                                      ( disp RMID mr )
		then                                         ( disp RMID mr )
	then

	third BIG?  if  &200 SOP, ADR,    ;then ( disp mr RMID ) | disp[reg] 
	third if  &100 SOP, 1,   ;then ( disp mr RMID ) | disp8[reg]
						0 SOP, drop               ( )              | [reg]
;
| assembles either a register to register or a register to
| or from memory mode.
: R/M,   ( mr reg -- ) over REG? if  RR,  else  MEM,  then  ;
| assembles either a register mode with SIZE field, or a
|  memory mode with SIZE from SIZE. Default is 16 (or 32) bit. Use BYTE
|  for 8 bit size.
: WR/SM,   ( r/m r op -- )   
	third dup REG?  if  
		WF, RR,  
	else  
		drop SIZE, MEM, 
	then  ;
| true if inter-segment jump, call, or return.
variable INTER
| sets far bit, clears flag.
: ?FAR   ( n1 -- n2 )   INTER @ if  &10 or  then  INTER off ;
: OP16?  ( -- flag )  false DATA-OV @ xor  ;
: PREFIX-0F  $0f 1,  ;

| OPCODE DEFINING WORDS:

| define one byte constant prefixes
: ASM0: create , does> @ 1,  ;
| define one byte constant instructions.
: ASM1: create , does> @ 1, NORMAL ;
| define ascii adjust instructions.
: ASM2:   create  8 << or , does> @ ASM16, NORMAL  ;
| define branch instructions, with one or two bytes of offset.
: ASM3:	| conditional branches
   ( op -- )	create  ,  
   ( dest -- )	
   does>
		@		( dest op )
		swap here 1+ 1+ - 			( op disp )
		dup SMALL?   if	( op disp8 )
			swap 1, 1,
		else				( op disp )
			PREFIX-0F  swap $10 + 1,
			4 OP16? if  1- 1- then  -	 ADR,
		then
		NORMAL ;
| define LDS, LEA, LES instructions.
: ASM4:   create  ,
	does>
		@  dup $b2 $b5 between  if PREFIX-0F then  
		1,  MEM, 
    NORMAL  ;
| define other instructions.
: ASM5:   create , does> PREFIX-0F  @ 1,  ;
| define multiply and divide instructions.
: ASM6:   create  ,  
	does> @ &366 WR/SM,  NORMAL  ;
| define increment/decrement instructions.
: ASM7:   create  ,
	does>
		@  over R16?
		if  &100 or swap RLOW OP,  
		else  &376 WR/SM,  
		then  
	NORMAL ;
| define shift/rotate instructions.

| *NOTE*  To allow both 'ax shl' and 'ax cl shl', if the register
| on top of the stack is cl, shift second register by cl. If not,
| shift top ( only) register by one.
| ??? if we do this sort of thing, we should keep track of stack depth.
| it is not hard; either sp@ or depth suffices.

| For 'ax 5 # shl' and '5 # ax shl'
| the immediate byte must be compiled after everything else.
: ASM8:     ( op -- )   create  ,
	does>
		@		( r/m cl op | r/m n # op | n # r/m op | r/m op )
		over #  =if			( r/m n # op )
		nip swap dup BIG? tuck >r >r	( r/m op BIG? )
		1 and &300 or WR/SM,    r> r>	( n BIG? )
		if    ASM,   else   1,  then
		;then		( r/m cl op | n # r/m op | r/m op )
		third # =if			( n # r/m op )
		_nip rot dup BIG? tuck >r >r	( r/m op BIG? )
		1 and &300 or WR/SM,    r> r>	( n BIG? )
		if    ASM,   else   1,  then
		;then		( r/m cl op | r/m op )
		over CL =if	( r/m cl op )
		nip &322	( r/m op op' )
		else		( r/m op )	| shift by 1 implicitly
		&320		( r/m op op' )
		then		( r/m op op' )
		WR/SM,  
      NORMAL  ;
| define calls and jumps.
|  notice that the first byte stored is E9 for jmp and E8 for call
|  so  C@ 1 AND  is 0 for call,  1 for jmp.
|  syntax for direct intersegment:   address segment #) FAR JMP
: ASM9:
   create  1, 1,    ( [ dst ] mode apf )
   does>
   over # =if                                 ( dst mode apf )
      nip c@ INTER @  if                        ( offset segment code )
         1 and  if  &352  else  &232  then  1, ( offset segment )
         swap ASM, ASM16,  INTER off            ( )
      else					( dst code )
         swap here 1+ 1+ -  swap                   ( rel-dst code )
         2dup 1 and swap BIG? 0 = and  if        ( rel-dst code )
            2 OP,  1,                        ( )
         else                                   ( rel-dst code )
	    1,  OP16? if
	       1- ASM16,
	    else
	       3 - ASM32,
	    then				
         then					( )
      then					( )
   else                                         ( mode apf )
		over S#) =if nip #) swap then
      &377 1, 1+ c@ ?FAR  R/M,
   then
   NORMAL  ;
| define pushes and pops.
: ASM10:  ( dst mr -- )
   create  1, 1, 1, 1, 1,        ( dst apf )
   does>
   over REG?  if                      ( dst apf )   | general register
      c@ swap RLOW OP,                ( )
   else                               ( dst apf )
      1+ over SEG?  if                ( dst apf' )  | segment register
         over FS < not if		      ( dst apf' )  | fs or gs
	    PREFIX-0F  3 + c@         ( dst opcode )
            swap GS =if  &10 or  then ( opcode' )
	    1,                     ( )
         else			      ( dst apf' )  | cs, ds, es, or ss
            c@ RLOW swap RMID OP,     ( )
         then
      else                            ( dst apf' )
         over # =if                 ( dst apf' )  | immediate
	    1+ 1+ c@                     ( val # opcode )
	    SIZE @  0if 2 or  then ( val # opcode' )
	    1,  drop ASM,          ( )
         else                         ( dst apf' )  | memory
            dup 1+ c@ 1,  c@ MEM,  ( )
         then
     then
   then
   NORMAL  ;
| define arithmetic and logical instructions.
: ASM11:  ( src dst -- )
   create  ,                           ( src dst apf )
   does>
   @ >r                                     ( src dst )  ( r: op )
   dup REG?  if                              ( src dst ) | dst is register
      over REG?  if                          ( src dst )
         r> over WF, swap RR,                ( )         | register -> register
      else                                   ( src dst )
         over dup MEM? swap #) = or  if      ( src dst )
            r> 2 or WMEM,                    ( src dst ) | memory -> register
         else                                ( src dst )
            nip  dup RLOW 0if
				r> 4 or over WF, R16? 
			else
               over BIG? over R16? 2dup and  ( immed dst BIG? R16? wbit )
              -rot 1 and swap invert over 0 <>
			        and 2 and or ( immed dst flag 0|1|3 )
               &200 OP,                       ( immed dst flag  )
               swap RLOW &300 or r> OP,   ( )
			then
			,/C,
         then
      then
   else                                      ( src disp dst )  | dst is memory
      rot dup REG?  if                       ( src disp dst )  | reg -> mem
         r> WMEM,                            ( )
      else                                   ( disp src disp dst ) | imm -> mem
         drop                                ( disp src disp )
         third BIG? dup invert 2 and &200 or
         SIZE, -rot r> MEM,
		SIZE @ and ,/C,
      then
   then
   NORMAL  ;
| BTx instructions
: ASM14:  ( r/imm8 r/m)
	create ,
	does> @ >r
	PREFIX-0F
	dup REG? if swap else rot then
	dup REG? if                             | BTx R/M, r 
		r> 1, R/M,
	else									| BTx R/M, imm8
		drop $ba 1, r> R/M, 1,
	then  
	NORMAL	;
| BSx, CMOVcc
: ASM15:  ( reg/mem reg )
	create  , does> @ PREFIX-0F 1, R/M, NORMAL ;
| SHLD, SHRD
: ASM12:   ( [ cl | imm ] reg r/m -- )
   create  ,  
   does> @  PREFIX-0F  here >r  1,  ( [ cl | imm ] reg r/m r: opadr )
   dup REG?  if  swap  else  rot  then               ( [ cl | imm ] r/m reg r: opadr )
   R/M,                                              ( [ cl | imm ] r: opadr )
   # =if  1, r> drop  else  r@ c@ 1+ r> c!  then ;
| define branch instructions that can only have one byte of offset.
| namely LOOPx instructions
: ASM13:	| conditional branches
   ( op -- )	create  ,  
   ( dest -- )	
   does>
	@		( dest op )
      swap here 1+ 1+ - 			( op disp )
      dup BIG? if THROW_ASM_LOOPX then
      swap 1, 1,
      NORMAL ;
| Encoding of special register moves:
| 0F c,
| 0x22 for normal->special direction, 0x20 for special->normal direction
| or with  0 for CRx, 1 for DRx, 4 for TRx
: SPECIAL-MOV  ( s d -- )
   PREFIX-0F
   dup SPEC?  if  $22  else  swap $20  then   ( norm-reg spec-reg opcode )
   over &7000 and
	&1000 / 5 -
	dup 2 = if drop 4 then
	| ( norm-reg spec-reg opcode modifier )
   OP,                     ( norm-reg spec-reg )
   RR, ;
| FAR  sets INTER true.  Usage:  FAR JMP,   FAR CALL,   FAR RET.
: FAR    ( -- )   INTER on  ;
macro
: BYTE   ( -- )   SIZE off ;
: DWORD SIZE on ;
: TEST   ( source dest -- )
   dup REG?  if
      over REG?  if  &204 over WF, swap RR,  ;then
      over dup MEM? swap #) = or  if   &204 WMEM,  ;then
      nip  dup RLOW 0if   &250 over WF,  R16? ,/C,  ;then  | imm -> acc
      &366 over WF,  dup RLOW &300 OP,  R16? ,/C,
   else                                               | *   -> mem
      rot dup REG?  if  &204 WMEM,  ;then          | reg -> mem
      drop  &366 SIZE,  0 MEM,  SIZE @ ,/C,   | imm -> mem
   then
   NORMAL  
;
: ESC   ( source ext-opcode -- )   RLOW $d8 OP, R/M,  ;
: SETIF  ( dest condition -- )  $0f 1,  $24 xor 1,  R/M,  ;
: INT   ( n -- )   $cd 1, 1,  ;
: +RET  ( n -- )   $c2 1, ASM16, ;
: XCHG   ( mr1 mr2 -- )
   dup REG?  if
      dup EAX =if
		drop RLOW $90 OP,
      else
         over EAX =if
            nip  RLOW $90 OP,
         else
            $86 WR/SM,
         then
      then
   else
      rot $86 WR/SM,
   then
   NORMAL  ;
| MOV  as usual, the move instruction is the most complicated.
|  It allows more addressing modes than any other, each of which
|  assembles something more or less unique.
: MOV   ( s d -- )
   | stack diagram at the decision level is ( src dst )
   dup SEG?  if  $8e 1, R/M,  ;then         ( s d )
   dup SPEC?  if  SPECIAL-MOV  ;then

   dup REG?  if                                     ( s d )  | *   -> reg
      over SPEC?  if  SPECIAL-MOV  ;then
      over #) = over RLOW 0 = and  if                ( s d )  | abs -> acc
         $a0 swap WF,   drop ADR,  ( s d )
      ;then

      over SEG?  if  swap $8c 1, RR,  ;then  ( s d )  | seg -> reg

      over # =if                                  ( s d )  | imm -> reg
	  | ." imm->reg mov" cr
         nip dup R16? swap RLOW
         over $8 and or $b0 OP, ,/C,
      ;then

      $8a over WF, R/M,
   else                                             ( s d d ) | *   -> mem
      rot dup SEG?  if  $8c 1, MEM,  ;then    ( s d d ) | seg -> mem

      dup # =if                                   ( s d d ) | imm -> mem
         drop $c6 SIZE, 0 MEM,  SIZE @ ,/C,  
      ;then

      over #) = over RLOW 0 = and   if               ( s d d ) | abs -> acc
         $a2 swap WF,  drop   ADR,  
      ;then

      $88 over WF, R/M,                              ( )       | reg -> mem
   then
   NORMAL ;
| Use "byte movsx" for the r8 form, "movsx" for the r16 form
: MOVSX  ( r/m r -- )  PREFIX-0F  $be SIZE,  R/M,  ;
: MOVZX  ( r/m r -- )  PREFIX-0F  $b6 SIZE,  R/M,  ;
| Most instructions are defined here. Those mnemonics in
| parenthetic comments are defined earlier or not at all.
: OUT  ( al | ax	dx | imm # -- )
   $e6  swap  # =if  ( al|ax imm op )
      rot WF, 1,      ( )
   else                  ( al|ax op )
      &10 or  swap WF,    ( )
   then
   NORMAL  ;  
: IN  ( dx | imm,#	al | ax -- )
   $e4  rot  # =if   ( imm al|ax op )
      swap WF, 1,     ( )
   else                  ( al|ax op )
      &10 or  swap WF, ( )
   then
   NORMAL  ;

: BOUND ( mem reg )
	$62  1, MEM, NORMAL ;

: BSWAP ( reg)
	PREFIX-0F RLOW  $c8 + 1, ;

: CMPXCHG ( reg r/m)
	PREFIX-0F
	dup  REG?  if  swap  else  rot  then
	dup  R16? SIZE ! 
	$b0  WR/SM, NORMAL ;
	
forth
: OP: ( -- )   DATA-OV on     $66 1,  ;
: AD: ( -- )   ADDRESS-OV  on $67 1,  ;

hex

36 ASM0: SS:		3e ASM0: DS:		26 ASM0: ES:		64 ASM0: FS:		65 ASM0: GS:
2e ASM0: CS:
f0 ASM0: LOCK		f2  ASM0: REPNZ   f3  ASM0: REP    

37 ASM1: AAA     3f  ASM1: AAS     f4  ASM1: HLT     9c  ASM1: PUSHF
98 ASM1: CWDE    98  ASM1: CBW
99 ASM1: CDQ     99  ASM1: CWD  
f8 ASM1: CLC     fc  ASM1: CLD     fa  ASM1: CLI
f5 ASM1: CMC     27  ASM1: DAA     2f  ASM1: DAS     
ce ASM1: INTO    cf  ASM1: IRET    9f  ASM1: LAHF    
90 ASM1: NOP     60  ASM1: PUSHA   9d  ASM1: POPF    61  ASM1: POPA    
9e ASM1: SAHF
f9 ASM1: STC     fd  ASM1: STD     fb  ASM1: STI     9b  ASM1: WAIT    
d7 ASM1: XLAT    ac  ASM1: LODSB   ad  ASM1: LODSD   aa  ASM1: STOSB
ab ASM1: STOSD   a4  ASM1: MOVSB   a5  ASM1: MOVSD
6c ASM1: INSB    6d  ASM1: INSD         
6e ASM1: OUTSB   6f  ASM1: OUTSD
a6 ASM1: CMPSB   a7  ASM1: CMPSD   
ae ASM1: SCASB    af  ASM1: SCASD         
c3 ASM1: RET
c9 ASM1: LEAVE	
cb ASM1: RETF
cc ASM1: INT3

 d5 #10 ASM2: AAD      d4 #10  ASM2: AAM     

 e3  ASM3: JCXZ    77  ASM3: JA      73  ASM3: JAE     72  ASM3: JB      
 76  ASM3: JBE     74  ASM3: JE      7f  ASM3: JG      7d  ASM3: JGE     
 7c  ASM3: JL      7e  ASM3: JLE     75  ASM3: JNE     71  ASM3: JNO     
 79  ASM3: JNS     70  ASM3: JO      7a  ASM3: JPE     7b  ASM3: JPO     
 78  ASM3: JS     

 c5  ASM4: LDS     8d  ASM4: LEA     c4  ASM4: LES     

 30  ASM6: DIV     38  ASM6: IDIV    28  ASM6: IMUL
 20  ASM6: MUL     18  ASM6: NEG	 10  ASM6: NOT     

 08  ASM7: DEC     00  ASM7: INC     

 10 ASM8: RCL     18 ASM8: RCR     00 ASM8: ROL      8 ASM8: ROR     
 38 ASM8: SAR     20 ASM8: SHL     28 ASM8: SHR     

10 e8 ASM9: CALL 20 e9 ASM9: JMP

 a1  58  8f 07 58 ASM10: POP     
 a0  68 0ff 36 50 ASM10: PUSH    

 10 ASM11: ADC     00 ASM11: ADD     20 ASM11: AND     38 ASM11: CMP     
 08 ASM11: OR      18 ASM11: SBB     28 ASM11: SUB     30 ASM11: XOR

 a3 ASM14: BT      0bb  ASM14: BTC     b3 ASM14: BTR     0ab ASM14: BTS
0bc ASM15: BSF     0bd  ASM15: BSR
 40 ASM15: CMOVO    41  ASM15: CMOVNO   
 42 ASM15: CMOVB    42  ASM15: CMOVC   42 ASM15: CMOVNAE
 43 ASM15: CMOVNB   43  ASM15: CMOVNC  43 ASM15: CMOVAE
 44 ASM15: CMOVZ    44  ASM15: CMOVE
 45 ASM15: CMOVNZ   45  ASM15: CMOVNE
 46 ASM15: CMOVBE   46  ASM15: CMOVNA
 47 ASM15: CMOVNBE  47  ASM15: CMOVA
 48 ASM15: CMOVS    49  ASM15: CMOVNS
 4a ASM15: CMOVP    4a  ASM15: CMOVPE
 4b ASM15: CMOVNP   4b  ASM15: CMOVPO
 4c ASM15: CMOVL    4c  ASM15: CMOVNGE
 4d ASM15: CMOVNL   4d  ASM15: CMOVGE
 4e ASM15: CMOVLE   4e  ASM15: CMOVNG
 4f ASM15: CMOVNLE  4f  ASM15: CMOVG


0ac ASM12: SHRD    0a4 ASM12: SHLD

 e2 ASM13: LOOP  e1 ASM13: LOOPE   e0 ASM13: LOOPNE  

	31 ASM5: RDTSC
	a2 ASM5: CPUID

: -ASM-END- ;

decimal

| /ASM

forth
'5 emit
: :: 0L (header) lastxt p: ] : noop ; 
: dup@+ dup @ swap cell+ ;
: defer 
    header ['] 'defer class!
    ['] noop ,
    ;
macro
| call prior value of the deferred word
: chain ( <name> -- ) ' @ compile ;
forth
s0 variable, (s0)
: max  [
    EAX EBX MOV
    LODSD
    EBX EAX CMP
    here 4 +  JG
    EBX EAX MOV
    ] ;
: min [
    EAX EBX MOV
    LODSD
    EBX EAX CMP
    here 4 +  JL
    EBX EAX MOV
    ] ;
: clamp ( m n -- ) min 0 max ;
: xchg2 ( a b -- ) | inline{ 89 C3 AD 8B 0B 8B 10 89 13 89 08 AD } ; 
    [
    EAX EBX MOV
    LODSD
    0 [EBX] ECX MOV
    0 [EAX] EDX MOV
    EDX 0 [EBX] MOV
    ECX 0 [EAX] MOV
    LODSD
    ] ;
: 3drop | inline{ 8b 46 08 8d 76 0c } ;inline
    [
    8 [ESI] EAX MOV
    12 [ESI] ESI LEA
    ] ;inline
: 0drop; | inline{ 09 c0 75 03 ad ad c3 } ;inline | or eax, eax; jnz .done; lodsd; lodsd; ret; .done:
    [
    EAX EAX OR
    here 4 + JNE
    LODSD
    LODSD
    ] ;inline
: aligned ( a -- a' ) | inline{ 83 c0 03 83 e0 fc } ;inline | add eax, 3; and eax, -4
    [
        3 # EAX ADD
        -4 # EAX AND
    ] ;inline
: spaces 0 max 0; 1- space spaces ;
: 2swap
    [
    EAX 4 [ESI] XCHG
    EBX 0 [ESI] XCHG
    EBX 8 [ESI] XCHG
    EBX 0 [ESI] XCHG
    ]
    ;
| mov ebx,eax; mov eax, [esi]; cdq; idiv ebx; mov [esi], edx
: mod / [ EDX EAX MOV ] ;
: _1- ( a b -- a-1 b ) [ 0 [ESI] DEC ]  ;inline
: _+ ( a b c -- a+c b ) [ EAX 4 [ESI] ADD LODSD ]  ;inline
: negate [ EAX NEG ] ;inline | neg eax
: @++ [ 
    EAX EBX MOV
    0 [EAX] EAX MOV
    0 [EBX] INC
    ] ; 
: _@ [
    0 [ESI] EBX MOV
    0 [EBX] EBX MOV
    EBX 0 [ESI] MOV
    ] ;inline 
: && | inline{ 89 C3 AD F7 DB 19 DB F7 D8 19 C0 21 D8 } ;
    [
    EAX EBX MOV
    LODSD
    EBX NEG
    EBX EBX SBB
    EAX NEG
    EAX EAX SBB
    EBX EAX AND
    ] ;
: || 
    [
    EAX EBX MOV
    LODSD
    EBX NEG
    EBX EBX SBB
    EAX NEG
    EAX EAX SBB
    EBX EAX OR
    ] ;
: cells [ 2 # EAX SHL ] ;inline 
: 2cell- [ -8 [EAX] EAX LEA ] ;inline
: 3cell+ [ 12 [EAX] EAX LEA ] ;inline 
: 4cell+ [ 16 [EAX] EAX LEA ] ;inline 
: pick  [ 0 [ESI] [EAX] *4 EAX MOV ] ;inline 
: rdrop [ EBX POP ] ;inline 
: abs  [
    CDQ
    EDX EAX XOR
    EDX EAX SUB
    ] ;inline
: @execute  [
    0 [EAX] EBX MOV
    LODSD
    EBX CALL
    ] ;inline
: execute  [
    EAX EBX MOV
    LODSD
    EBX CALL
    ] ;inline
: exec ( dict -- ) 
    [
    -4 [EAX] EBX LEA
    0 [EBX] EBX MOV
    4 [EAX] EAX MOV
    EBX JMP
    ] ;
: rp@ dup [ ESP EAX MOV ] ;inline  | get current ESP
: rpick [ 0 [ESP] [EAX] *4 EAX MOV ] ;inline 
: 2* [ 1 EAX SHL ] ;inline
: 2/ [ 1 EAX SHR ] ;inline
: /mod  [
    EAX EBX MOV
    0 [ESI] EAX MOV
    CDQ
    EBX IDIV
    EDX 0 [ESI] MOV
    ] ;
: fourth  | same as "3 pick"
    [
    -4 [ESI] ESI LEA
    EAX 0 [ESI] MOV
    12 [ESI] EAX MOV
    ] ;
: 2over [
    8 # ESI SUB
    EAX 4 [ESI] MOV
    16 [ESI] EBX MOV
    EBX 0 [ESI] MOV
    12 [ESI] EAX MOV
    ] ;
: */  | inline{ 89 c1 ad 89 c3 ad f7 eb f7 f9 } ;
    [
    EAX ECX MOV
    LODSD
    EAX EBX MOV
    LODSD
    EBX IMUL
    ECX IDIV
    ] ;


: bye 0 (bye) ;
: ?dup [ 
    EAX EAX TEST
    here 7 + JE
    ] dup ;
: depth (s0) @ [ ESI EAX SUB ] 2/ 2/ 1- ;
: rr> [ 
    -4 [ESI] ESI LEA
    EAX 0 [ESI] MOV
    ECX POP
    EBX POP
    EAX POP
    EBX PUSH
    ECX PUSH
    ] ;
 : >rr [
     EBX POP
     EAX PUSH
     EBX PUSH
     LODSD
     ] ;inline
defer key?
defer ekey
| ========================= CONDITIONALS ==================
: ahead $e9 1, 0 , here ;

variable oldstate
variable brace-level
macro
: {  ( -- xt )
    state @

    | remember the old state only for the outermost braces
    brace-level @ if
        brace-level ++
    else
        dup oldstate !
        1 brace-level !
        state on
    then

	if ahead then 
	here 
	;
: }	 ( xt -- xt ) 
	| seal off temp definition:
	$c3 1, 
    | decrease the brace level, 
    | restore the old state if zero:
    brace-level --
    brace-level @
    0if   oldstate state xchg2   then
	| if compiling, seal the jump and compile the 'here'
	| if interactive, just return the 'here'
	compiling?  if  p: ;then literal,  then
    ;
: {{ here p: { ;
: }} >r p: } execute r> here - allot ;
forth
: autovar: ( xt <name> -- )
    create 0 , ,
    does> dup @ 0if
            dup cell+ @execute over !
        then @ ;

: then> compiling? 0;drop r> compile ; | thanks malcoln
: ?literal compiling? 0;drop literal ; | thanks malcoln
: u< ((cmp)) [
    here 3 + JBE
    EAX DEC
    ] ;
: u> ((cmp)) [
    here 3 + JAE
    EAX DEC
    ] ;
: WIN os 0 = ;
: LIN os 1 = ;
: MAC os 2 = ;

| ========================= EXTRA ==================
: used dict @ d0 @ - here h0 @ - ;
: 2variable create 0 , 0 , ;
: 2@ dup cell+ @ _@ ;
: 2! tuck cell+ ! ! ;
: srcstr >in @ src @ over - ;
: ||| srcstr + >in !  ;
: (p.r) padchar @ >r padchar ! (.r) r> padchar ! ;
variable temp

| ========================= STRINGS ==================
: zero ( a n ) 0 fill ;
: blank ( a n ) 32 fill ;
| new version from colin:
: lcount    0>00;   [ $408dc389 , $fc768d04 , $038b0689 , ;
: lplace 2dup ! cell+ over zt swap move ;
: _dup [
    0 [ESI] EBX MOV
    4 # ESI SUB
    EBX 0 [ESI] MOV
    ] ;
: +lplace ( a n b -- )
	2dup +!			| a n b ( b[0] += n)
	lcount +		| a n b'
	over -
	swap move
	;
: c+lplace ( c s -- )
	tuck			| s c s
	lcount + 		| s c s'
	tuck c!			| s s'
	1+ 0 swap c!		| s
	++ ;
: asciiz, dup 1,
: z, here, 0 1, ;
: asciizl, dup , z, ; 
| place for temporary strings
variable (s^)
| place for compiled strings (loaded from revastr)
variable (compstr)
variable (compstrend)   | end of used compiled string space
1000000 variable, (compsize)
    | compile time:
    (compsize) @ allocate dup (compstr) ! (compstrend) !

: strallot ( n -- a )
    cell+ 1+
    | see if our allocate
    (compstrend) @ aligned      | address of string
    tuck +
    (compstrend) !  
    (compstr) @ -
    ;
    | n a'

| compile string 
: (")  ( a n -- ) 
    dup strallot | a n a'
    dup literal, (compstr) @ + lplace
    { (compstr) @ + lcount } compile ;

| put string into 'rotating' temp area
:: 2048 allocate  ; autovar: sbufs
:: sbufs free ['] sbufs off ; onexit
: "" 
	255 min 
	(s^) @++ 8 mod 256 * sbufs +
	dup >r place r> 
    count
	;
macro
: " '" parse/ compiling? if (") ;then "" ; | "
: ." p: " then> type ;

: z" p: " then> drop ; | "
forth
'7 emit

: c+place ( c cstr -- ) dup ++ count +  0 over c! 1- c! ;
    

| ========================= LOOPING ==================
forth
: i dup inline{ 8b 44 24 08 2b 44 24 04 } ; 
: j dup inline{ 8b 44 24 10 2b 44 24 0c } ;
align here $850f , $75 , $8f0f , $7f ,
: (while)
    cells literal + >r
    align here - 1- 1- 
    dup -125 <if
        r> @ 2, cell- , | long jump!
    ;then
    r> cell+@ 1, 1, | short jump!
    ;
: (do) align here 0 >rr ;
macro
: leave $e9 1, here >rr 0 , ;
: repeat align here ;
: again back ;
: while $c085 2,  | test eax, eax; lodsd
    p: drop
    0 (while) ;
| mov ebx, eax; lodsd; push eax; sub eax, ebx; push eax; lodsd ...
: do $50adc389 , $ad50d829 , (do) ; 
: 0do $ad5050 3, (do) ;
: ?do 
    0 >rr
    $50adc389 , $ad50d829 , | mov ebx, eax;lodsd;push eax;sub
    $8e0f 2, | jle dword later
    here >rr 0 ,
    align here
    ; 
: loop  $240cff 3, | dec [esp] 
    2 (while)
    $08c483 3,  | add esp, 8
    | resolve 'leave' forward references:
    repeat
        rr> 0;
        here over - 2cell- 1+ swap !
    again
    ;
: p[ repeat parsews 2dup " ]p" cmp 0if 2drop ;then find-dict @litcomp again ;
forth
| DO NOT MOVE any of the LOCALS words...
20 constant MAXREFS 
20 constant MAXLOCALS
MAXREFS MAXLOCALS * constant LOCALS#

create LOCALS LOCALS# cells allot

: RESET-LOCALS LOCALS LOCALS# cells zero ;
: IX>ROW ( n -- a ) MAXREFS cells * LOCALS + ;
: FIRST-EMPTY ( a -- a' )
	0 swap
	MAXREFS 0do cell+ dup @ 0if swap  leave then loop
	drop
	;
| add reference to this location:
: L ( n -- adr )
	IX>ROW dup @ swap				| adr row 
	| find empty location and save referencing address:
	dup MAXREFS 1- cells + @ if
		| no room left!
		THROW_ASM_REF
		drop
	;then
	FIRST-EMPTY here swap !
	dup 0if drop here then
	;

| resolve local address:
: L: ( n -- ) IX>ROW here swap !  ;

| this fixes-up the local references:
: RESOLVE-LOCALS
	| bounce through the locals:
	MAXLOCALS 0do
		i IX>ROW
		MAXREFS 1 do 
			| row
			dup i cells + @
			| row ref
			?dup if
				| row ref
				over @ 
				| row ref addr
				over - 1- 1- 
				| row ref offs 
				swap 1+ c! 
			then
		loop
		drop
	loop
    RESET-LOCALS
	;
: -LOCALS-END- ;
| ok, you can move these now ...

: \char [
    EAX EBX MOV
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    EAX ECX MOV
    0 L JCXZ 
    0 [ESI] EDI MOV
    ECX EDI ADD
    EDI DEC
1 L: ( next)
    BL 0 [EDI] CMP
    2 L JE
    EDI DEC
    1 L LOOP
    0 L JCXZ
2 L: ( match)
    BL 0 [EDI] CMP
    0 L JNE
    ECX EAX SUB
    EAX INC
    EDI 0 [ESI] MOV
    RET
0 L: ( bad )
    EAX EAX XOR
    EAX 0 [ESI] MOV
    RET
    RESOLVE-LOCALS
    ] ;
: _2dup [
    0 [ESI] ECX MOV
    4 [ESI] EDX MOV
    -8 [ESI] ESI LEA
    EDX 4 [ESI] MOV
    ECX 0 [ESI] MOV
    ] ;
: __dup [
    4 # ESI SUB
    4 [ESI] EBX MOV
    EBX 0 [ESI] MOV
    8 [ESI] EBX MOV
    EBX 4 [ESI] MOV
    ] ;
: ___dup __dup [
    12 [ESI] EBX MOV
    EBX 8 [ESI] MOV
    ] ;
: -chop ( a n c -- a1 n1 ) _2dup \char nip - ;
| ========================= DICT ==================
| variable findprev?
: findprev ( dict-to-find -- dict-to-find prev-dict ) 
    last repeat dup @ third =if ;then @ again ;

: dict? '' ?dup 0if 
    dblquote type dblquote 
    ."  is not a word" cr THROW_GENERIC 
    then ;
| redefine ' and ['] to throw as per Bob Armstrong's suggestion:
| : '' dict? ; | : ' xt? ;
: xt? dict? >xt @ ;
: !isa ( class-dict a n -- ) dblquote type dblquote ."  not class: " >name ctype cr THROW_GENERIC ;
: isa ( class-dict <name> -- xt-of-name | THROW )
    '' | class-dict dict-of-name
    ?dup 0if !isa then
    | class-dict dict-of-name
    2dup | class name class name
    >class @ swap >xt @ | class name name-class class
    <>if >name count !isa then
    nip >xt @ 
    ;


: hide ( <name> -- )
    dict?
    findprev | fall through ...
: (hide)  ( dict dict' -- )
    _@ ! ;

'8 emit
hide !isa
hide (do)
hide (THROW:)
| hide findprev?
| hide (execute)
| : then,> compiling? if literal, r> compile then ;
: then,> compiling? 0;drop literal, r> compile ;
: defer? [''] 'defer isa ;
macro
: is defer? then,> ! ; 
forth
: ERROR ( a' n' a n  -- ) cr ." ERROR: " type_ type cr ;
:: " unknown word: " ERROR srcstr 64 min type ." ..." 0 ; is word?

| ========================= PRIVATE STACK (used by contexts)
: stack: ( n -- )  
        create  here ,  cells allot ; 

: stack-size   ( stack -- nof-cells ) dup @ swap - 2/ 2/ ;
: stack-empty? ( stack -- flag )  dup @  =  ;
: stack-clear ( s -- ) dup ! ;

: push  ( x stack -- ) 4 over +! @ ! ; 
: pop    ( stack -- n ) 
		dup dup @ - 0;drop 
		dup @ @ 
        -4 rot +!  ;

: peek ( stack -- x ) @ @ ;
: peek-n ( n stack -- m )  @ swap cells - @ ;

: stack-iterate ( xt stack -- )
  dup stack-empty? if 2drop ;then

  dup stack-size 0do
    2dup i swap peek-n swap execute
  loop
  2drop
;

| ========================= CONTEXTS ==================
' find-dict @	 variable, oldfind 
' (header) @ dup variable, oldheader variable, newheader

| Create a list containing all contexts:
variable all-contexts

| Create the stack that contains the active contexts
| (TOS is the currently active context)
63 stack: contexts

variable xtdict
: xt>name  ( xt -- a n )
	xtdict off
    {
       @    | xt context 
	   {
			cell-
			2dup
			>xt @ 
			| xt dict xt xt1 
			=if
				| xt dict xt xt1
				xtdict !
				false
			then
	   } swap iterate 
	   xtdict @ not	| keep iterating if we did NOT find something
    } all-contexts iterate drop
	xtdict @ ?dup if >name count ;then 0L ;

: ctx>name 2cell+ @ >name count ;
: exit~
	| pop current context
    contexts pop 0; | context-to-deactivate

    contexts stack-empty? if contexts push ;then

    | save current last into that context
    last @ swap !

    | now restore the last of the newly active context
    contexts peek @ last !
	;

10 stack: saved-contexts
64 cells variable, CONTEXTS#
: push~
	CONTEXTS# @ allocate dup saved-contexts push
	contexts swap CONTEXTS# @ move
	;
: pop~
    exit~
	saved-contexts pop dup
	contexts CONTEXTS# @ move
	free
    contexts peek @ last !
	;
hide CONTEXTS#
: .contexts { @ dup ctx>name type_ } all-contexts iterate ;
: .~ { ctx>name type_ } contexts stack-iterate ;
: ''context
    contexts stack-empty? not
    if
      | save the current "last" into the current context
      last @  contexts peek !
    then

    | make the specified context the current one
    dup contexts push

    | set "last" appropriately
    dup @ last !

    | set 'header' appropriately
    4cell+ @ newheader !
    ;

: 'context then,> ''context ; 
: context: parsews

: (context) ( a n -- )
    find-dict 0if
        (create) 
            0 ,				| 00 this context's chain of words
            oldfind @ ,		| 04 'find-dict' for this context
            last @ ,        | 08 dictionary entry for this context
            $54585443 ,     | 0C context signature
            oldheader @ ,   | 10 '(header)' for this context

            lastxt all-contexts link
        does> 'context
    then
	;
context: ~
context: ~reva
context: ~sys
context: ~os
context: ~doubles
context: ~strings
context: ~util
context: ~io
context: ~priv
context: ~asm

: context?? ( xt -- flag ) 00; 3cell+ @ $54585443 = ;
: context? xt? dup context?? 0if ." not a context" THROW_GENERIC then ; 
: find-word ( a n context -- 0 | xt -1 ) dup 0if 3drop 0 ;then
  last @ >r
  dup @ last !
  | get the 'find' for this context, and execute it on the string
  dup cell+@ >r _2dup -rot r> execute
  | restore last
  r> last !
  | a n ctx a n 0 | a n ctx xt
  dup 0if 3drop 3drop 0 ;then >r 3drop r> -1 ;

| :: newheader @execute ; is (header) 
macro

: in~ ( <ctx> <word> -- )
    context?
    parsews rot find-word
    0if ." in~ failed " ;then
	| dict entry: do the appropriate thing
	dup >xt @ swap cell- @execute
	;

: with~ ( <ctx> -- ) context? contexts pop swap contexts push contexts push ;
: without~ contexts pop contexts pop drop contexts push ;

| transfer the word <word> into the context <ctx>
: to~ ( <ctx> <word> -- ) context?
    dict?	| ctx dict
: (to~) ( ctx dict -- )
    over contexts peek =if 2drop ;then
	findprev			| ctx dict dict'
	over >r
	| hide the original entry
	(hide) r>				| ctx dict
	| put this entry into the new context
	| get the 'prev' of the ctx and make it the next
	over @ over !
	| make the last the first:
	swap !
	;
: setfind~ ( xt <ctx> -- ) context? cell+!  ;
: setheader~ ( xt <ctx> -- ) context? 4cell+ ! ;

forth
'9 emit
: 3dup [
    0 [ESI] ECX MOV
    4 [ESI] EDX MOV
    -12 [ESI] ESI LEA
    ECX 0 [ESI] MOV
    EDX 4 [ESI] MOV
    EAX 8 [ESI] MOV
    ] ;
: 4dup [
    0 [ESI] EBX  MOV
    4 [ESI] ECX  MOV 
    8 [ESI] EDX  MOV 
    -16 [ESI] ESI  LEA 
    EBX  0 [ESI]   MOV
    ECX  4 [ESI]   MOV 
    EDX  8 [ESI]   MOV 
    EAX 12 [ESI]   MOV 
    ] ;
| print all contexts in which the word (a,n) can be found:
: xfind ( <name> -- )
	parsews
: (xfind)
	{
		@ 3dup
		find-word nip if ctx>name type_ then
		true
	} all-contexts iterate 2drop ;

to~ ~doubles >double
last @ ' ~ ! 
~

| reset to only the first context:
: (reset~) contexts stack-size 1- 0;drop exit~ (reset~) ;
' ~ variable, root
: reset~ (reset~) 
    contexts peek
    root @ 2cell+ <>if
        | some random context is on the stack.  make sure "~" is there instead
        root @ 'context
        p: without~
    then
    ; 

to~ ~priv root
to~ ~priv ''context
to~ ~priv (reset~)

macro
: only~ context? then,> contexts stack-clear contexts push ;
forth

: /char [
    EAX EBX MOV
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    EAX ECX MOV
    0 L JCXZ         | 0=bad
    0 [ESI] EDI MOV
1 L:    | next
    BL 0 [EDI] CMP
    2 L JE  | match
    EDI INC
    1 L LOOP
2 L: | match
    BL 0 [EDI] CMP
    0 L JNE
    0 L JCXZ
    ECX EAX MOV
    EDI 0 [ESI] MOV
    RET
0 L: | bad
    EAX EAX XOR
    EAX 0 [ESI] MOV

	RESOLVE-LOCALS
    ] ;
: chop ( a n c -- a1 n1 ) _2dup /char nip - ;
: /string ( a n m -- a1 n1 ) 
    [
    EAX EBX MOV
    LODSD
    EBX 0 [ESI] ADD
    EBX EAX SUB
    ] ;
: 2nip [
    EAX PUSH
    LODSD
    4 [ESI] ESI LEA
    EAX 0 [ESI] MOV
    EAX POP
    ] ;
: w!  [
    EAX EBX MOV
    LODSD
    OP: EAX 0 [EBX] MOV
    LODSD
    ] ;
: w@  [ 0 [EAX]  EAX MOVZX ] ;inline
: split  ( a n c -- a1 n1 a2 n2 true | a n false )
    _2dup /char 
: (split) ( a n a2 n2 -- a1 n1 a2 n2 )
    0; 1 /string
	2swap
	third - 1- true
	;
: rsplit ( a n c -- a1 n1 a2 n2 true | a n false )
	_2dup \char (split) ;
macro
: unloop [ EBX POP EBX POP ] ;inline 
: eleave [ EBX POP 1 # PUSH ] ;inline 
: skip ( n -- ) [ EAX 0 [ESP] SUB LODSD ] ;inline
: remains dup [ 0 [ESP] EAX MOV EAX DEC ] ;inline
: more ( n -- ) 1+ [ EAX 0 [ESP] MOV LODSD ] ;inline
forth
: _2nip ( a b c d -- a d ) [ 8 # ESI ADD ] ;inline
: later [
    EBX POP    ECX POP
    EBX PUSH   ECX PUSH
    ] ;
:: ( a n -- xt | a n 0 )
    | update "last" in the current context
    last @ contexts peek !
    contexts stack-size 0do
        2dup i contexts peek-n find-word
        if _2nip unloop ;then
    loop
    | did not find it; see if it's a dotted-context word?
    2dup '. split if 
        | a n a2 n2 a1 n1
        find dup if  | a n a2 n2 ctx
            dup context?? 0if
                drop
            else
                find-word if _2nip ;then 2dup
            then
        else | a n a2 n2 a1 n1 
            3drop 
        then
    then
    2drop
  0 ; is find-dict

| set the search order while building Reva:
reset~ ~reva ~priv ~sys ~os ~util ~io ~strings ~
| ========================= ENDOFCONTEXTS ==================
~asm

forth
variable save-state

macro
: }
	RESOLVE-LOCALS
	save-state @ state !
	exit~
    ;
forth
exit~
~priv ~ 
macro
: asm{ 
	['] ~asm ''context 
	state @ ~asm.save-state !
	state off
	;
forth
| ========================= ENDOFCONTEXTS ==================
| ========================= ENDOFCONTEXTS ==================
to~ ~strings split
to~ ~strings (split)
~priv 
8 stack: cases
: inrange? ( x low hi -- x flag ) __dup between ;
exit~ 
macro
| : endcase cases @ ?dup if p: then then ;
: endcase cases pop 0; p: then ;
: case ( -- ) 0 cases push ; 
: of ( n -- n |  )  p[ over =if drop ]p ;
: strof ( a n -- a n | ) p[ 2over cmp 0if 2drop ]p ;
: rangeof ( low high -- n | ) p[ inrange? if ]p ;
: endof ( -- ) 
	p: endcase
	ahead cases push
	p: then 
	;
forth

| ========================= VARIOUS ==================
create nul  0 , | "empty" NUL terminated string
: .1x $f and >digit emit ;
: .2x dup 4 >> .1x .1x ;
: .4x dup 8 >> .2x .2x ;
: .8x dup 16 >> .4x .4x ; 
: .x .8x space ;
: .s depth dup lparen (.) type rparen space 10 clamp 0; 
    dup 0do dup i - pick . loop drop ;
: rdepth rp0 @ rp@ - 2/ 2/ ;
: .rs rdepth 1+ dup lparen (.) type rparen space 10 clamp 0; 
    dup 0do remains 1+ 1+ rpick .x loop drop ;

~strings
: lplace> ( a n b -- a' )
	over >r dup >r lplace
	r> r> + cell+ 1+ ;

: search ( a1 n1 a2 n2 -- a3 n3 1 | 0 )
    asm{
    EAX EDX MOV     | EDX -> n2
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    EAX EDI MOV     | EDI -> a2
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    EAX ECX MOV     | ECX -> n1
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    | A1 -> EAX:ECX
    | A2 -> EDI:EDX
    EAX PUSH    ECX PUSH
    | 1L -> 'failed'
    1 L JCXZ
    EAX EAX OR
    1 L JE
    EDX EDX OR 
    1 L JE
    EDI EDI OR
    1 L JE
    | did not fail:
    | main loop, scan for possible match
    | EAX:ECX -> string to search in, move through until we fall off
( next)
2 L: 0 [EDI] BH MOV      
( findstart )
5 L: 0 [EAX] BL MOV     
    BH BL CMP
    3 L JE  | 3 L -> maybe match, check it out
    EAX INC
    5 L LOOP                | goto findstart
( failed )
1 L: EAX EAX XOR
    ECX POP ECX POP
    RET
( maybe)
3 L: 
    EDX ECX CMP
    1 L JB
    EDX EBP MOV
    EBP DEC
( maybe2)
6 L:
    0 [EDI] [EBP] *1 BH MOV
    0 [EAX] [EBP] *1 BH CMP
    7 L JNE | nomatch2
    EBP DEC
    6 L JNS
    | we matched!
    -4 [ESI] ESI LEA
    EAX 0 [ESI] MOV
    EAX POP
    0 [ESI] EAX SUB
    EBX POP
    EBX EAX ADD
    -4 [ESI] ESI LEA
    EAX 0 [ESI] MOV
( success )
    -1 # EAX MOV
    RET
( nomatch2 )
7 L: 
    EAX INC
    ECX DEC
    2 L # JMP ( next)
    } ;

: cmove> asm{
    EAX ECX MOV
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    EAX EDI MOV
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    EAX EDX MOV
    0 [ESI] EAX MOV
    4 [ESI] ESI LEA
    0 L JCXZ
    ECX EDX ADD
    ECX EDI ADD
    align
1 L:
    EDX DEC
    EDI DEC
    0 [EDX] BL MOV
    NOP
    BL 0 [EDI] MOV
    1 L LOOP
0 L:
    } ;

: bounds asm{
    0 [ESI] EBX MOV
    EAX 0 [ESI] ADD
    EBX EAX MOV
    } ;inline
exit~

forth

~priv
| implementation of 'words' :
variable wcnt
defer ((words))
2variable (w)
: (showword) dup 0if 2drop ;then type_ wcnt ++ ;
: words? 2dup (w) 2@ search _2nip 0;drop (showword) ;
exit~
' (showword) is ((words))
: words-prep
    parsews tuck (w) 2!  if ['] words? else ['] (showword) then is ((words))  ;
: words  words-prep
: (words) wcnt off 
    { cell- >name count ((words)) 1 }
    last iterate wcnt @ dup if cr . ." words" else drop then ;
: words~ 
    context?
: (words~)
    last @ >r
    @ last !
    (words)
    r> last !
    ;
to~ ~priv (words)
: xwords
    words-prep
	{ 
		@ dup
        (words~) 
        wcnt @ if
            ."  in " dup ctx>name type cr
        then
	} all-contexts iterate
	;

~util
: >>single >single 0if 2drop 0 ;then ;
: xt>size 
    dup 1000 $c3 /char 0if drop 4 ;then
    swap -
    ;
exit~

~strings
forth
'A emit
: isupper ( c -- f ) 'A 'Z between ;
: islower ( c -- f ) 'a 'z between ;
: lc ( c -- c' ) dup isupper if $20 or then ;
: uc ( c -- c' ) dup islower if $DF and then ;
macro
: quote ( <cr> --- a n ) 
    parsews drop c@ parse 
    compiling? if (") ;then | " (just for vim syntax highlighting)
    "" ;
exit~
~util
: alias: ( newname oldname -- )
    header | create new word
    ''      | get dict entry of next word
    ?dup 0if type ."  not found" cr THROW_GENERIC then
    last @   | dictptr lastptr
    2dup cell- swap cell-@ swap !  | set class of new word to that of old word
    >xt swap >xt @ swap !           | set XT of new word to that of old word
    ;
: prior last @ dup @ last ! dict? | orig-last dict 
  @litcomp | implementation of p:
  last !  ;
exit~
macro
: value 
    create ,
    ['] 'value class! ;
forth
: [DEFINED] '' if true ;then 2drop false ;
~priv
: (value) [''] 'value isa then,>  ;
exit~
~ 

| macro : ['] ' p: literal ;
| forth
: 2constant
    create swap , ,
    does> 2@ 
    ;
macro
: to (value) then,> ! ;
: +to (value) then,> +! ;
forth
| implementation of 'dump' :
~priv
0 value dump$
: dumpasc
    dump$ count dup 0if 2drop else
        16 over - 3 * spaces type
    then cr dump$ off ;
: ?nl dup 0; 16 mod not 0; 
    drop over dumpasc .x ;
: >printable dup 32 127 between not 0; 2drop '. ;
exit~
~util
: dump 0; dump$ off 
    over .x 0do | iterate for each line:
        i ?nl drop dup c@ dup >printable dump$ c+place .2x space 1+
    loop drop dumpasc ;
exit~
0 value scratch
0 value pad

| these are all called with a stack: a n x
| where 'a' is the buffer to put the char in
|       'n' is the buffer's max size
|       'x' is the number of characters in it
|   and 'c' is the current character (for the default)
~io
| hex ' (p.r) $36 + @ . decimal 
: backspace
    dup | a n x x
    if
        8 emit space 8 emit 1-
    then
    true   | a n (0|x-1) true
    ;
: accept ( r n -- n2 )
    0 repeat 
    ekey ( dup accept? ) 
        case
            127 of backspace endof
            8 of backspace endof
            10 13 rangeof drop false endof
            27 of drop 0L endof
                dup emit | show the key
                | a n x c
                | >r rot dup >r -rot dup  | a n x x  r: c 
                | r> + r> swap            | a n x c (a+x)
                | c!                      | a n x
                fourth third + c!
                1+
                2dup -  | =0 (false) if we shall not continue reading characters...
        endcase
    while _2nip ;
| hex ' (p.r) $36 + @ . decimal 
hide backspace
exit~
hide xt
hide words-prep
defer help
defer help/
context: ~help 
~help
defer nohelp
defer showhelp
~priv
: help! " needs helper" eval ;
:: help! help/ ; is help/
:: help! help ; is help
exit~
exit~

 to~ ~sys defer?
macro
: defer: p: defer here lastxt ! p: ] ;

'B emit
forth
to~ ~priv ((cmp))

~util
defer: disassemble dump ;

~priv
defer: (see)
    find ?dup 0if type question ;then
    64 disassemble cr ;
exit~
: see parsews (see) ;
exit~ 

| ========================= PREPROCESSOR ==================
~priv
variable if-nesting		| [IF] increases nesting, [THEN] decreases it
20 stack: if-flag
: (then) if-nesting -- if-flag pop drop ;
: eat ( M -- )
	parsews
	case
		" [IF]" strof if-nesting ++ endof
		" [THEN]" strof if-nesting @ over (then) =if rdrop drop ;then endof
		" [ELSE]" strof if-nesting @ over =if if-flag peek rdrop 2drop ;then endof
		" |" strof parseln 2drop endof
		" (" strof ') parse 2drop endof
		2drop
	endcase
	eat ;
exit~
forth
0 value testing
macro
: [THEN] (then) ;
: [ELSE]
	if-flag peek
	0if if-nesting @ eat then ;
: [IF] ( n -- )
	if-nesting ++
	dup not if-flag push	| save flag for [ELSE]
	0if if-nesting @ eat drop then ;
: [IFTEST] p: testing p: [IF] ;
forth
: bswap	asm{ EAX BSWAP } ;inline
: sm/rem asm{
    EAX EBX MOV
    LODSD
    EAX EDX MOV
    LODSD
    EBX IDIV
    EAX EDX XCHG
    -4 [ESI] ESI LEA
    EAX 0 [ESI] MOV
    EDX EAX MOV
    } ;

| ========================= FFI LAYER ==================
~priv
variable (cur-lib)
variable last-lib
variable last-func

: dolib
    | make us the current-library:
    dup (cur-lib) !
    dup @ 0if dup cell+ count (lib) over !  then
    @ | provide our 'handle'
    ;
exit~
: lib create 
        0 ,                 | +00 this is the handle of the library
        asciiz,             | +04 store cstr name of library
        lastxt
		dup (cur-lib) !      | make us the current-library to use
		last-lib link	    | link us into the chain of libs
    does> dolib
    ;

~priv
: (func-create)
		parsews 2dup (create) rot
        0 ,                 | +00 function pointer
        ,                   | +04 number of parameters
        (cur-lib) @  ,      | +08 library (xt of library)
        asciiz,             | +0C zt string name of function
		lastxt last-func link
        ;

: (func-data-does)  ( -- ptr )
        dup @ 0if
            dup dup             | self self self
            3cell+ count        | self self fnamea n
            rot 2cell+ @ dolib    | self a n lib
            (func)              | self handle
            over !              | self
        then
        dup @ 0if 
            3cell+ count 
            " could not load" ERROR
            THROW_BADFUNC 
        then
        ;
exit~ 
: func: ( n <name> -- )
    (func-create)  
    does> (func-data-does) 
	2@ (call) 
    ;
: vfunc: ( n <name> -- )
    (func-create)  
    does> super> func: drop
    ;

: cfunc: ( <name> -- )
    0 (func-create)
  does>
	(func-data-does)  | ensure that the proc address is initialized
	@ swap            | arg1 arg2 ... argn proc-address n
	(call)
;

: data: ( <name> -- )
    0 (func-create)
    does> (func-data-does) @ @ ;

~priv
: .libfunc  @ dup @ .x space dup xt>name type_ ;
exit~
: .libs
    ." handle   word  libname" cr
	{	
		.libfunc
		cell+ ctype cr
		true
	} last-lib iterate
    ;


: .funcs 
    ." handle   word  funcname libname" cr
	{	
		.libfunc
		dup 3cell+ ctype space
		2cell+ @ cell+ ctype cr
		true
	} last-func iterate
    ;

| Renames the last word to the new name:
: as ( <name> -- )
	| get pointer to last name entry:
	last @ >name >r
	| get new name to use instead, and save it:
	parsews tuck r@ place
	| adjust dictionary pointer:
	r> + 1+ aligned dict !
    ; 

: empty { @ off true } swap iterate ;
:: | clean up libraries
    last-func empty
    last-lib empty
	; onexit

| ========================= OS LAYER ==================
| os-specific words:
'C emit
: sp asm{
    4 # ESI SUB
    EAX 0 [ESI] MOV
    ESI EAX MOV
    } ;
~os
LIN [IF]
    
    " libc.so.6" lib libc
    data: errno
    : osname " Linux" ; 
    : getpid 0 20 syscall ;
    ~priv
    $a variable, line-end
    exit~
    : linefeed line-end 1 ;
    ~priv
    : ioctl ( p1 p2 ... pN N -- result ) 54 syscall ;
    | TODO: make dynamic
    create in_termios 20 cells allot
    : non-canonical 
        | save terminal state
        in_termios $5401 0 3 ioctl drop
        in_termios 12 + @ >r
        | set terminal state:
        &100 in_termios 12 + !  
        in_termios $5403 0 3 ioctl drop
        r> in_termios 12 + !  
        ;
    : restore-canonical in_termios $5403 0 3 ioctl drop ;

    ::
        non-canonical
        3 sp $541b 0  3 ioctl drop
        restore-canonical
    ; is key?
    : ((ekey)) non-canonical key restore-canonical ;
    : (ekey) key? 0;drop 8 << ((ekey)) + (ekey) ;
    :: ((ekey)) (ekey) ; is ekey

    1 func: localtime
    :: 0 1 13 syscall here ! here localtime 
        dup@+ dup@+ dup @ 
        swap cell+ dup @ 
        swap cell+ dup @ 1+ 
        swap cell+@ 1900 + ;
    exit~ 
    ~
    alias time&date
    : ms 1000 /mod here !  1000000 * here cell+!
        0 here 2 162 syscall drop ;
    : ms@ 0 here 2 78 syscall drop here @ 1000000 * here cell+@ + 1000 / ;
    : makeexename ;
    exit~
[THEN]
MAC [IF]
    " libc.dylib" lib libc


    data: errno
    : osname " Mac" ; 
    : getpid 0 20 syscall ; | ok
    ~priv
    $a variable, line-end
    exit~
    : linefeed line-end 1 ;
    ~priv
    cfunc: ioctl
    2 func: tcgetattr   | stdin, &term
    3 func: tcsetattr   | stdin, tcasnow, &term 
    | Mac TODO: Determine Mac 'termios' structure
    | 5401 = TCGETS
    | 5403 = TCSETSW
    | 541b = FIONREAD
    |
    2 func: tcgetattr
    3 func: tcsetattr
    create in_termios 20 cells allot | termios.h
    : non-canonical 
        | save terminal state
        stdin in_termios tcgetattr drop
        in_termios 12 + @ >r  | TODO
        | set terminal state:
        $108 invert  r@ and in_termios 12 + !

        stdin 0 in_termios tcsetattr drop

        r> in_termios 12 + !  
        ;
    : restore-canonical 
        in_termios 12 + dup >r @
        $108 or r> !
        stdin 0 in_termios  tcsetattr drop ;


    variable (key?)
    $4004667f constant FIONREAD

    ::
        non-canonical
        stdin FIONREAD (key?)  3 ioctl drop
        restore-canonical
        (key?) @
    ; is key?
    : ((ekey)) non-canonical key restore-canonical ; 
    : (ekey) key? 0;drop 8 << ((ekey)) + (ekey) ;
    :: ((ekey)) (ekey) ; is ekey

    1 func: localtime
    2 func: gettimeofday

    : (tod) here 0 gettimeofday drop here  ;
    :: (tod) localtime 
        dup@+ dup@+ dup @ 
        swap cell+ dup @ 
        swap cell+ dup @ 1+ 
        swap cell+@ 1900 + ;
    exit~ 
    ~
    alias time&date

    ~priv
    1 func: usleep
    exit~
    : ms 1000 * usleep drop ;
    : ms@ (tod) @ 1000000 * here cell+@ + 1000 / ;
    : makeexename ;
    exit~
[THEN]
WIN [IF]
    ~priv
    $a0d variable, line-end
    exit~
    : linefeed line-end 2 ;
    : osname " Windows" ; 
    " user32" lib u32
    " gdi32" lib g32 
    " kernel32" lib k32
    ~priv
    1 vfunc: GetLocalTime
    1 vfunc: Sleep
    0 func: GetTickCount
    0 func: GetCurrentProcessId 
    2 func: GetConsoleMode
    2 func: SetConsoleMode
    4 func: PeekConsoleInputA
    4 func: ReadConsoleInputA 
    0 func: GetLastError
    2 func: WaitForSingleObject
    ~os
    : errno GetLastError ;
    exit~
    variable (conmode)
    : raw ( -- ) stdin here GetConsoleMode drop here @ 
        (conmode) !
        stdin 0 SetConsoleMode drop ;
    : cooked ( -- ) stdin (conmode) @ SetConsoleMode drop ;

    :: stdin here 1 temp PeekConsoleInputA drop
        temp @ dup if
            drop here @ 1 and not not
        then
        ; is key?
    : shiftmod ( n -- mask )
        | 3 -> alt  0c -> ctrl  10 -> shift
        | 000sccaa --> 00000sca --> 0sca00
        dup >r 3 and if $100 else 0 then
        r@ $c and if $200 else 0 then
        r> $10 and if $400 else 0 then 
        or or 
        ;
    : (ekey) 
        raw 
        repeat key? not while

        |    stdin here 1 temp ReadConsoleInputA drop
        |    here @ 1 <> | cell+ @ not
        | while
        stdin here 1 temp ReadConsoleInputA drop
        stdin here 1 temp ReadConsoleInputA drop

        here 3cell+ 1+ 1+ w@ ?dup 0if
            here 2cell+ 1+ 1+ w@ 
            here 4cell+ @ | controlkey
            shiftmod or
        then
        cooked
        ;
    :: (ekey) ; is ekey

    ~os
    : getpid GetCurrentProcessId ;
    exit~
    : exe " .exe" ;
    ~
    : ms@ GetTickCount ;
    : ms  Sleep ;
    : time&date here dup GetLocalTime 
        dup 3cell+ w@ swap
        dup 2cell+ 1+ 1+ w@ swap
        dup 2cell+ w@ swap
        dup cell+ 1+ 1+ w@ swap
        dup 1+ 1+ w@ swap
        w@ ;
    : makeexename ( a n -- a' n' )
        2dup here lplace exe here +lplace
        '. split _2nip if
            exe 1 /string cmpi 0if
                -4 here +!
            then
        then
        here lcount
        ;
    exit~
    exit~ 
[THEN]

| ========================= ENVIRONMENT ==================
~priv
    32767 constant #env-var-buffer 
    0 value env-var-buffer
exit~
LIN [IF]
    ~os
    ~priv
    1 func: getenv as os_getenv
    1 func: putenv
    exit~
    exit~
    ~util
    : getenv zt os_getenv zcount ;
    : setenv ( a1 n1 a2 n2  -- )  |  variable, value
        2swap env-var-buffer lplace 
        '= env-var-buffer c+lplace 
        env-var-buffer +lplace | buffer: variable=value
        env-var-buffer lcount zt putenv drop
        ;
    exit~
[THEN]
MAC [IF]
    ~os
    ~priv
    1 func: getenv as os_getenv
    1 func: putenv
    exit~
    exit~
    ~util
    : getenv zt os_getenv zcount ;
    : setenv ( a1 n1 a2 n2  -- )  |  variable, value
        2swap env-var-buffer lplace 
        '= env-var-buffer c+lplace 
        env-var-buffer +lplace | buffer: variable=value
        env-var-buffer lcount zt putenv drop
        ;
    exit~
[THEN]
WIN [IF]
    ~priv
    3 func: GetEnvironmentVariableA
    2 func: SetEnvironmentVariableA
    exit~
    ~util
    : getenv ( a n -- a n ) zt env-var-buffer #env-var-buffer
        GetEnvironmentVariableA env-var-buffer swap ;
    : setenv ( a1 n1 a2 n2 -- ) 
        2swap zt -rot zt        | z1 z2
        SetEnvironmentVariableA drop
        ;
    exit~
[THEN]
exit~

'D emit
| ========================= FILEIO ==================
| file i/o words:
~os
~priv
0 value dirbuf 
exit~
LIN [IF]
    ~
    : pathsep '/ ;
    exit~
    ~os
    : chdir ( a n -- ) zt 1 12 syscall ioerr ! ; | 12
    : getcwd ( -- a n ) 255 dirbuf 2 183 syscall 1- dirbuf swap ; | 183 buf size --> buf
    exit~
    ~io
    : (seek) ( whence offset handle ) 3 19 syscall ;
    : rename zt -rot zt 3 38 syscall ioerr ! ;
    : delete  ( a n -- ior ) zt 1 10 syscall ioerr ! ;
    
    ~priv
    : (stat) ( a n -- x ) zt here swap 2 106 syscall ioerr ! ;
    exit~
    : stat ( a n -- x ) (stat) here 2cell+ @ ;
    : mtime ( a n -- x ) (stat) here 12 cells  + @ ;
    exit~
[THEN]
MAC [IF]
    ~
    : pathsep '/ ;
    exit~
    ~os
    ~priv
    4 func: lseek 
    2 func: rename as _rename
    1 func: unlink 
    1 func: chdir as _chdir
    2 func: getcwd as _getcwd
    exit~
    : chdir ( a n -- ) zt _chdir ioerr ! ; | 12
    : getcwd ( -- a n ) dirbuf 255 _getcwd zcount ; | 183 buf size --> buf
    exit~
    ~io


    : (seek) ( whence offset des ) | on Mac: des offset whence
        -rot 0 rot lseek ;
    : rename zt -rot zt swap _rename ioerr ! ;
    : delete  ( a n -- ior ) zt unlink ioerr ! ;

    ~priv
    2 func: stat as _stat
    : (stat) ( a n -- x ) zt here _stat ioerr ! here ;
    exit~
    : stat ( a n -- x ) (stat) ioerr @ if drop 0 ;then cr 8 + @ ;
    : mtime ( a n -- x ) (stat) 32  + @ ;
    exit~
[THEN]
WIN [IF]
    ~
    : pathsep '\ ;
    exit~
    k32 drop
    ~priv
    4 func: SetFilePointer
    2 func: MoveFileA as MoveFile
    1 func: DeleteFileA as DeleteFile
    1 func: GetFileAttributesA as GetFileAttributes
    4 func: GetFileTime
    2 func: GetCurrentDirectoryA
    1 func: SetCurrentDirectoryA
    1 func: CloseHandle
    exit~
    ~os
    : chdir ( a n -- ) zt SetCurrentDirectoryA ioerr ! ;
    : getcwd ( -- a n ) 255 dirbuf GetCurrentDirectoryA dirbuf swap ;
    exit~
    | stat:
    ~io
    : stat zt GetFileAttributes ;
    | delete:
    : delete zt DeleteFile not ioerr ! ;
    | rename:
    : rename zt -rot zt swap MoveFile not ioerr ! ;
    : mtime open/r ioerr @ if drop -1 ;then
        >r | fh
        r@ 0 0 here GetFileTime if
            here 2@ | FILETIME>unixtime
            27111902 - swap -717324288 - swap
            10000000 sm/rem nip
        else
            -1
        then
        r> close ;

    : (seek) ( whence offset handle ) 
        -rot 0 rot
        SetFilePointer ( handle off offhigh whence )
        ;
    exit~
[THEN]
exit~
to~ ~os hinst
to~ ~os syscall
' | dup alias #!  alias @rem

: appdir appname zcount pathsep -chop 1+ ;
: helpdir appdir 1- pathsep -chop 1+ ;
: libdir helpdir 1-
    pathsep -chop | new layout, lib is one above, not at same level as 'bin'
    1+ scratch place " lib" scratch +place pathsep
    scratch c+place scratch count ; 
: seek ( offs h -- newoffs ) >r 0 swap r> (seek) drop ;
: tell ( fh -- offs ) 1 0 rot (seek) ;

| ========================= NEEDS ==================
~priv
: libname ( a n la ln -- a1 n1 )
    dup if here place here +place here count ;then
    2drop ;

context: ~needs

: (include?) ( a n la ln -- err?) 
    libname (include) ioerr @  ;

: (includelib) ( a n -- err?)
    2dup " "                   (include?)  if
    2dup " REVAUSERLIB" getenv (include?)  if
    libdir                     (include?)  
    ;then then
    2drop 0  ;
        
~
: needs parsews 
: (needs)
    2dup ['] ~needs find-word if 3drop ;then
    2dup (includelib)
    if
        " could not load library: " ERROR
        THROW_NEEDS 
    else
        push~ ~needs  (create) p: ; pop~
    then  ; 

: .needs  ['] ~priv.~needs (words~) ;
exit~

'E emit
exit~
: nolib ( a n -- ) ." There is no " type_ ." library for " osname type cr bye ;
: .classes { @ >name ctype space true } classes iterate ;
to~ ~priv classes

| ========================= CONTEXT FIXUPS ===============
to~ ~strings place to~ ~strings +place to~ ~strings c+place
to~ ~strings lplace to~ ~strings +lplace to~ ~strings c+lplace to~ ~strings count
to~ ~strings lcount to~ ~strings (") to~ ~strings "" to~ ~strings /char to~ ~strings \char 
to~ ~strings chop to~ ~strings -chop to~ ~strings cmp to~ ~strings cmpi 
to~ ~strings zcount to~ ~strings zt to~ ~strings z"
to~ ~io creat to~ ~io close to~ ~io open/r to~ ~io open/rw to~ ~io read to~ ~io write
to~ ~io fsize to~ ~io ioerr to~ ~io seek to~ ~io tell
to~ ~util >lz to~ ~util lz> to~ ~util lzmax to~ ~util fnvhash  
to~ ~util findprev
to~ ~util asciiz, to~ ~util asciizl, to~ ~util z, to~ ~util used to~ ~util depth
to~ ~io spaces to~ ~util later
to~ ~sys (to~) to~ ~sys then,>  to~ ~sys (while)
to~ ~sys (s^) to~ ~sys srcstr
to~ ~strings /string 
to~ ~sys ?literal to~ ~sys then> to~ ~sys compiling? to~ ~sys (if to~ ~sys if)
to~ ~io ekey to~ ~io key? to~ ~io cr
to~ ~sys (s0) to~ ~sys pdoes
to~ ~util >name to~ ~util >xt to~ ~util >class
to~ ~io type_ to~ ~io space to~ ~io type
to~ ~util rpick to~ ~util rp@  to~ ~util 4cell+ to~ ~util 3cell+
to~ ~util 2cell+ to~ ~util 2cell- to~ ~util 3drop to~ ~util 0drop;
to~ ~sys (here) to~ ~sys dict to~ ~sys word?
to~ ~util slurp to~ ~util iterate to~ ~util link to~ ~util (save)
to~ ~util appname to~ ~util (include) to~ ~util include
to~ ~util >digit to~ ~util digit> to~ ~util >single
to~ ~sys find-dict to~ ~sys src to~ ~sys tp to~ ~sys tib to~ ~sys >in to~ ~sys (bye)
to~ ~sys (func) to~ ~sys (call) to~ ~sys (-lib) to~ ~sys (lib)
to~ ~io emit to~ ~io key
to~ ~util here, to~ ~util parse/ to~ ~util os
to~ ~util argc to~ ~util (argv)
to~ ~sys onstartup to~ ~sys onexit
to~ ~sys rp0 
to~ ~sys h0 to~ ~sys d0 to~ ~sys s0
to~ ~sys default_class  to~ ~sys cold
to~ ~sys find-word
to~ ~util stack-iterate to~ ~util peek-n to~ ~util peek to~ ~util pop
to~ ~util push to~ ~util stack-empty?  to~ ~util stack-size to~ ~util stack:
to~ ~sys xt? to~ ~sys isa to~ ~sys context? 
to~ ~priv all-contexts
to~ ~priv xtdict

to~ ~priv contexts hide oldfind
to~ ~priv saved-contexts
hide dup@+

: reva reset~ ~reva ~os ~util ~io ~strings ~ ; reva
| ========================= REVA STARTUP ==================
~priv
with~ ~sys
| buffer allocations:
| Note: all these scratch buffers are just one allocated buffer, split up in
| chunks.  Presumably this is a bit more efficient than having multiple
| allocated buffers.  Certainly it is faster (but who would notice?)
:: 
    | load strings
    getextra 
        swap over | n a n
        100000 + resize
        tuck +
        (compstrend) ! (compstr) !

    [ 16384 18 +  #env-var-buffer + 256 + 1024 + ] literal allocate 
    dup to scratch
    16384 + dup to env-var-buffer
    #env-var-buffer + dup to dirbuf
    256 + dup to pad
    1024 + to dump$
    ; onstartup

without~
exit~
: argv2 swap 0; 1- swap zcount + 1+ argv2 ;
: argv argc 1- clamp (argv) argv2 zcount ;
hide argv2
hide @litcomp
to~ ~priv sbufs


forth
~reva
: revaver " 2011.2" ;
| convert 'revaver' to 'revaver#' automagically:
    revaver '. split drop
        eval 100 * -rot eval +
    constant revaver#
    reset

: .ver " Reva " type  revaver type_ osname type ;
: revalang " REVALANG" getenv ;
~priv
defer: caught cr ." Caught: " . cr true ;
: catchme ( xt -- ) catch 0; caught if ~sys.src off then ;
: ((hi)) ( i c -- m )
    1 -rot
    case
        'n of 1+ argv (needs) endof
        'e of 1+ argv eval endof
        'd of drop " debugger" (needs) 1- endof
        'a of drop " needs ansi ~ans" eval  1- endof
        'c of 1+ argv chdir endof
        't of drop true to testing "  needs testing " eval 1- endof
        'v of .ver linefeed type bye endof
        'h of " help cmdline" eval bye endof
        3drop argc
    endcase
    ;
: (hi)  ( argc a n -- m ) over c@ '- =if drop 1+ c@ ((hi)) ;then (include) drop 0 ;
~
defer deinit-console
exit~
: exception-reset reset p: [ ['] interp catchme emit exception-reset ;
:: cr ." Break" ; is ctrl-c
::  deinit-console ." Exception: " .x ." at: " .x cr bye ; is exception
: hello 
    argc 1 do 
        i dup argv (hi) skip 
    loop 
    testing if " test bye" eval then
    ;
| make appstart  
::
    argc 1- 0if .ver cr else ['] hello catchme dup then 
    | main interpreter loop:
    exception-reset ; is appstart
| make prompt  cr ." ok> " ;
:: cr ." ok> " ; is prompt
: sorry cr ." No more " type ." space! Sorry." cr bye ;
| make heapgone " code" sorry ;
| make dictgone " dict" sorry ;
 ::  " code" sorry ; is heapgone
 :: " dict" sorry ; is dictgone
to~ ~reva caught
exit~ 
exit~
to~ ~sys appstart to~ ~sys interp to~ ~sys prompt
to~ ~sys state
to~ ~sys dict?
to~ ~util alias
| to~ ~priv help!
to~ ~priv oldstate
to~ ~priv newheader
to~ ~priv oldheader
~strings
to~ ~priv (split)
exit~

| move all the ASSEMBLER words into ~asm
'' REG '' -ASM-END- @ '' ~asm.save-state !
dup @ '' -ASM-END- 
! off
| now chain the locals stuff:
'' MAXREFS dup @
'' -LOCALS-END- dup @ 
-rot !
'' ~asm.REG ! off
 hide -ASM-END-
 hide -LOCALS-END-

2variable revaused 
: .used
    revaused 2@ used  
    rot - . ." code, "
    swap - . ." dict" cr
    ;
: save parsews : (save) 
    | save out strings
    (compstr) @ (compstrend) @ over - setextra
    deinit-console    
    ." Saving: " 2dup type cr
    ." Uses: " .used
    ." Libraries: " cr .libs
    prior (save) ;
 to~ ~util save
 to~ ~util (save)
used revaused 2!
hide (compstrend)
hide (compstr)
hide  strallot
hide brace-level
| Generate the Reva executable:
'F emit cr
 appdir here 1000 + place " reva"
 makeexename  here  1000 + +place here 1000 + count 
 (save) bye

| vim: et ts=4 nospell :
