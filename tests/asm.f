| execute with "reva -t tests/asm.f"

needs testing

." Testing assembler" cr

test: bug #389 (a075d4e8e1)
	depth >r
	asm{ 1 L: }
	depth r> - 0 = 
	;

| this is the correct code:
 : xyz inline{ 8D 7C 05 00 } ; 
 : xyz2 asm{ 0 [EBP] [EAX] *1  EDI LEA } ;
0 test2: 38fdbf6bdd  base+index assembly
 	['] xyz 5
 	['] xyz2 5 cmp 
 	;

: ebp+eax+1 inline{ 8D 7C 05 01 } ;
: asm/ebp+eax+1 asm{ 1 [EBP] [EAX] *1 EDI LEA } ;
0 test2: ebp+eax+1
 	['] ebp+eax+1 5
 	['] asm/ebp+eax+1 5 cmp 
 	;

: esi+4*eax+20 inline{ 8B 4C 86 14 } ; 
: asm/esi+4*eax+20 asm{ 20 [ESI] [EAX] *4 ECX MOV } ; 
0 test2: esi+4*eax+20
 	['] esi+4*eax+20 5
 	['] asm/esi+4*eax+20 5 cmp 
 	;
: bt-eax-ecx inline{ 0F A3 C8 } ;
: asm/bt-eax-ecx asm{ ECX EAX BT } ;
0 test2: bt-eax-ecx
 	['] bt-eax-ecx 4
 	['] asm/bt-eax-ecx 4
	cmp 
 	;
: btr inline{ 0F BA B6 34 12 00 00 F6 } ;
: asm/btr asm{ -10 #  $1234 [ESI]  BTR }  ;
0 test2: btr
 	['] btr 9
 	['] asm/btr 9
	cmp 
 	;

: mov1 inline{ 8B C5 } ; 
: asm/mov1 asm{ EBP EAX MOV } ; 
0 test2: mov1
 	['] mov1 3
 	['] asm/mov1 3
	cmp 
 	;
: mov2 inline{ 8B ED } ; 
: asm/mov2 asm{ EBP EBP MOV } ; 
0 test2: mov2
 	['] mov2 3
 	['] asm/mov2 3
	cmp 
 	;
: mov3 inline{ 8B 45 00 } ; 
: asm/mov3 asm{ 0 [EBP] EAX MOV } ; 
0 test2: mov3
 	['] mov3 4
 	['] asm/mov3 4
	cmp 
 	;
: mov4 inline{ 8B 4D 00 } ; 
: asm/mov4 asm{ 0 [EBP] ECX MOV } ; 
0 test2: mov4
 	['] mov4 4
 	['] asm/mov4 4
	cmp 
 	;

: mov5 inline{ C7 46 04 7B 00 00 00 } ; 
: asm/mov5 asm{ 123 # 4 [ESI]  MOV } ; 
0 test2: mov5
 	['] mov5 8
 	['] asm/mov5 8
	cmp 
 	;
: mov6 inline{ C7 04 86 7B 00 00 00 } ; 
: asm/mov6 asm{ 123 # 0 [ESI] [EAX] *4 MOV } ; 
0 test2: mov6
 	['] mov6 8
 	['] asm/mov6 8
	cmp 
 	;
: mov3a inline{ 89 45 00 } ; 
: asm/mov3a asm{ EAX 0 [EBP] MOV } ; 
0 test2: mov3a
 	['] mov3a 4
 	['] asm/mov3a 4
	cmp 
 	;

: mov5a inline{ 8B 46 04 } ; 
: asm/mov5a asm{ 0 4 [ESI] EAX MOV } ;
0 test2: mov5a
 	['] mov5a 4
 	['] asm/mov5a 4
	cmp 
 	;


: mov6 inline{ 8B 45 01 } ; 
: asm/mov6 asm{ 1 [EBP] EAX MOV } ; 
0 test2: mov6
 	['] mov6 4
 	['] asm/mov6 4
	cmp ;

: add1 inline{ 01 45 00 } ;
: asm/add1 asm{ EAX 0 [EBP] ADD } ;
0 test2: add1
 	['] add1 4
 	['] asm/add1 4
	cmp ;

: add2 inline{ 03 45 00 } ;
: asm/add2 asm{ 0 [EBP] EAX ADD } ;
0 test2: add2
 	['] add2 4
 	['] asm/add2 4
	cmp ;

: je inline{ 85 C0 74 01 40 48 } ;
: asm/je asm{ EAX EAX TEST 1 L JE EAX INC 1 L: EAX DEC } ;
0 test2: je
 	['] je 6
 	['] asm/je 6
	cmp ;
