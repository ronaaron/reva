; vim: ft=nasm 
; File: 	src/newcore.asm
; Description:	
; Author: 	Ron Aaron
; Created:	20090516 21:41:51	
; Last updated:	20090516 21:41:51		

%define WIN 0
%define LIN 1
%define MAC 2

%ifndef OS
%error "OS must be defined!"
%endif
%if (OS!=WIN && OS!=MAC && OS!=LIN)
%error "What is OS value " OS
%endif
%include 'src/common.asm'

%if (OS==LIN)
%include 'src/linux.asm'
%endif
%if (OS==WIN)
%include 'src/windows.asm'
%endif
%if (OS==MAC)
%include 'src/macosx.asm'
%endif


CODESECTION
GLOBAL _start
GLOBAL start


;;; CODE IS HERE

FUNCALIGN
slurp_exe:
	upsh app_file_name
	call _ztc
	call _slurp
	; a n ( n is file size )
	mov ebx, [esi]
	lea edi, [ebx+eax-4]	; EDI --> end of file
	mov ebp, [edi]		; offset
	add ebp, ebx
	ret
FUNCALIGN
_start: 
start: 
	mov esi, _s0
	; Do one-time startup:
	call os_start
	mov [_rp0], esp
	; load dictionary ...
	call slurp_exe

	; load the compressed dictionary data and unpack it correctly:
	; [ESI] -> ptr (need to free it, don't forget!)
	; EAX -> size
	; ( a n )
	; read the header and verify it's ok
	cmp ebx, ebp
	jz .bye

	push ebx	; save memptr

	; EBP=> the start of the data we are interested in:
	; we have a valid dictionary now: read it in, piece by piece:
	; ( a n )
	; first, copy over our save_header:
	upsh ebp
	upsh save_header
	upsh HEADERSIZE
	call _move
	; ( a n )
	; bump ebp to next area
	add ebp, HEADERSIZE
	mov [sh_ptr2], ebp	; original data

	; we have to allocate a chunk to hold our decompressed data
	; first, how big will it be?
	mov ecx, [static_size]
	add ecx, [sh_hsz]
	add ecx, [sh_dsz]
	add ecx, [sh_esz] ;; extra data to store

	mov [sh_size], ecx	; that's how big
	; the staging area; decompress to there:
	; ( a n p1 )
	upsh ecx
	call mem_alloc
	push eax
	mov [sh_ptr1],  eax
	upsh eax ; [sh_ptr1]
	upsh [sh_ptr2]
	upsh [sh_size]
	upsh [sh_ptr1]
	call blz_depack
	drop2
	; ( a n p1 )
	mov ebp, eax 	; [sh_ptr1]
	
	upsh ebp
	upsh static_start
	upsh [static_size]
	call _move

	add ebp, [static_size]
	upsh ebp
	upsh _h0
	upsh [sh_hsz]
	call _move

	add ebp, [sh_hsz]
	upsh ebp
	upsh _d0
	upsh [sh_dsz]
	call _move
	; ( a n p1 )

	;; extra
	mov ecx, [sh_esz]
	jecxz .noextra

	mov [extra_size], ecx

	add ebp, [sh_dsz]
	upsh ebp		; src
	upsh dword [sh_dsz]
	call mem_alloc		; dest

	mov [extra_data], eax
	upsh dword [sh_esz]	
	call _move
.noextra:

	pop eax
	call mem_free
	pop ecx
	upsh ecx
	call mem_free

.bye:	; ( a n )
	drop2

	; Do every-time startup:
PROC cold
	call reset
; iterate over 'start handlers' and call each one, in order:
	upsh __onstart
	upsh __start
	call iterate
	DEFERCALL appstart
	; fall into 'byebye'
	mov eax, -1
ENDP cold
	; fall through ...
PROC bye
	push eax
	call cleanup
	dup
	pop eax
	jmp os_bye
ENDP bye

PROC reset
	mov esi, _s0
	xor eax, eax
	mov [_rp0], esp
	ret
ENDP reset
FUNCALIGN
__onstart: jmp dword [eax]

; Code for words' implementation:

PROC doesclass
	dup
	mov eax, [eax-4]
	cmp dword [is_compiling], 0
	jz mclass

.compile:
	swap
	call literal
	jmp compile
ENDP doesclass
PROC cclass
	mov eax, [eax]
ENDP cclass
PROC vclass
	mov ebx, dword [is_compiling]
	or ebx, ebx
	jnz literal
	ret
ENDP vclass
PROC valclass
	mov ebx, dword [is_compiling]
	or ebx, ebx
	jz cclass
	; compiling.  This item needs to be 'dereferenced'
	call literal
	upsh cclass
	jmp compile
ENDP valclass

PROC fclass_notail
	mov dword [ssemi_do_tail], 0c3h ; ret ; 0
	jmp fclass.1
	
ENDP fclass_notail

; 'dclass' is just to keep track of 'defer' words
PROC dclass
	cmp dword [is_compiling], 0
	jnz .compile
	; not compiling:
	upop ebx
	jmp dword [ebx]
.compile:
	upsh 015ffh
	call comma2
	jmp  comma
ENDP dclass
; nop	; to make sure dclass and fclass are not identical!
PROC fclass
	mov dword [ssemi_do_tail], 090h
.1:	
	cmp dword [is_compiling], 0
	;mov ebx, dword [is_compiling]
	;or ebx, ebx
	jnz compile
	; fall through
FUNCALIGN
mclass:
	upop ebx
	jmp ebx	; execute the word
ENDP fclass

PROC mclass_notail
	mov dword [ssemi_do_tail], 0c3h ; ret ; 0
	jmp mclass
ENDP mclass_notail
PROC iclass
	; EAX -> XT
	; EDX -> DICT
	mov dword [ssemi_do_tail], 0c3h ; ret ; 0
	cmp dword [is_compiling], 0
	je mclass
	; inline the code:
	; EDX is dictionary entry.  -8 is size
	movzx ecx, byte [eax-1]
	upop edx
	jmp store_here.1
ENDP iclass
PROC store_here	; ( addr n -- ) 
	upop ecx ; n
	upop edx ; source addr
	jecxz compile.ret
align 4
.1:	mov edi, [h]
	add dword [h], ecx
	jmp _move.a
ENDP store_here
PROC compile         
	mov edi, [h]
	sub eax, edi
	lea eax,  [eax-5]
	mov [edi], byte 0xe8
	inc edi
	stosd
	mov [h], edi
	drop
.ret:   ret
ENDP compile
PROC _move	        ;
	upop ecx ; N
	upop edi ; dest      ;
	upop edx
	jecxz .b

	align 4
.a:	mov bl, byte [edx] 
	inc edx 	       
	mov byte [edi], bl
	inc edi 	        
	loop .a 	  
.b:	ret
ENDP _move

; p0 p1 p2 p3 ... pN xt N
PROC _call
	push ebp
	mov ebp, esp
	sub esp,4

	upop ecx		; nparams
%if (OS==MAC)
	sub esp, 010h
	and esp, 0fffffff0h
	;sub esp, 4*(4-(__params % 4))
	jecxz .mac0
	mov edi, ecx	; num params
	and edi, 3
	neg edi
	add edi, 4
	shl edi, 2
	sub esp, edi
.mac0:
%endif
	upop edx		; xt to call
	jecxz .1		; no parameters
.0:	push eax
;	add dword [ebp+4], 4
	drop
	loop .0
.1:	
	upsh ecx	; ECX is zero because of the loop...
	mov [ebp-4], esi
	call edx
	mov esi,[ebp-4]

	mov esp, ebp
	pop ebp
	ret
ENDP _call

PROC noop
	ret
ENDP noop

PROC header
	call parsews	        ;
	DEFERJMP _header
ENDP header

PROC __header
	mov dword [didheader], 1
	; align code space:
	call _align
	; align dictionary:
	mov edi,[d]	     
	add edi, 3
	and edi, -4

	; save old information so we can back out of a failed compile:
	push dword [h]
	pop dword [lasth]
	mov [lastd], edi
	mov ebx, [last]
	push ebx
	mov ebx, [ebx]
	mov [lastl], ebx

	pop ecx			; [last], was in 'ebx'
	; EBX=last@
	; ECX=last
	; EDI=dictionary entry

	; set the class
	push eax

	mov eax, [default_class]
	stosd

	; set 'last'
	mov [ecx], edi 	        ; last= LFA

	; set the previous pointer:
	mov eax, ebx
	stosd

	; set the XT:
	mov eax, [h]
	stosd

	; set the name:
	pop eax
	stosb

	; write the name into its place:
	upsh edi
	swap
	call _move
	; update the dictionary pointer
	mov [d],edi	        ; d= d+9+length
	; check for 'out of dictionary'
	cmp edi, _dtop
	jb .ok
	DEFERCALL dictgone
.ok:
	ret
ENDP __header

PROC inlinesemi	
	; current word is of the class 'inline'.  make it so...
	mov ecx, [h]		; current 'here'
	mov ebx, [lasth]	; get last 'here'
	sub ecx, ebx		; ECX is size of compiled code
	mov edi, [d]
	mov [edi], ecx
	inc edi
	mov ebp, edi
	mov edx, ebx		; source is old 'here'
	mov [h], ebx		; reset 'here' since code isn't there
	call _move.a
	mov byte [edi], 0c3h	; terminate with a RET
	inc edi
	mov [d], edi		; make sure to save the 'dict' pointer
	; make sure class of word is 'inline
	mov ebx, [last]
	mov ebx, [ebx]		; ebx->dict entry
	mov dword [ebx-4], iclass
	; EDI->''xt''  now set the actual XT field to point here
	mov [ebx+4], ebp
	jmp lbracket
ENDP inlinesemi	
PROC semi 	        ; Compile in an exit to the current word
	call ssemi
	; fall into lbracket
ENDP semi
PROC lbracket	        ; Switch back to the interpreter
	mov dword [didheader], 0
	mov dword [is_compiling], 0
	ret	; return to caller of caller
ENDP lbracket
PROC ssemi       ; Exit a word (; will call this!)
	; check for out-of-heap condition:
	mov ebx,[h]
	cmp ebx, _htop
	jb .ok
	DEFERCALL heapgone

.ok:	;  ebx->one byte after last code compiled 
	inc dword [h]
	mov byte [ebx], 0c3h ; ret

	sub ebx, 5
	; tail recursion removal:
	cmp byte [ebx],0e8h    ; Was the last thing compiled a CALL?
	je .do_tail
	cmp byte [ebx],0ffh
	jne .notail
	cmp byte [ebx+1], 015h	; abs indirect call
	jne .notail
	or byte [ebx+1], 010h	; convert to jump
	jmp .do_tail2

	; is the optimization disabled?
.do_tail: 
	cmp dword [ssemi_do_tail], 090h		; NOP
	jne .notail

	; change the terminal call to a jmp
	inc byte [ebx]	; --> E9 == jmp 
.do_tail2:
	dec dword [h]		; undo the advancment so we don't waste space
.notail:
	ret
ENDP ssemi
PROC parsews ; NOTE: must return 0 on failure!
  	dup
 	call parse_setup
  	inc ecx 	        ;
 	mov ebx, 2009h		; space/tab
  align 4
  .0:	jecxz .1
  	mov al, [edi]
  	dec ecx
  	inc edi
  	cmp al, 0ah
  	jne .0a
  	DEFERCALL do_cr
 	jmp .0
  .0a:
  	cmp al, bh
  	ja .1
  	cmp al, bl
  	jae .0
  .1:
  	dec edi 	        ;
  	inc ecx 	        ;
	mov edx, edi
  	mov [esi],edi	        ; a
	inc edx
  align 4
  .2:	jecxz .3
  	mov al, [edi]
  	dec ecx
  	inc edi
  	cmp al, 0ah
  	jne .2a
  	DEFERCALL do_cr
 	jmp .3
align 4
  .2a:
  	cmp al, bh
  	ja .2
  	cmp al, bl
 	jb .2
  .3:
  	mov eax,edi	        ;
  	mov [tin],edi	        ;
  	sub eax,edx
	ret
ENDP parsews

FUNCALIGN
parse_setup:	
 	dup
 	mov edi,[tin]	        ; Pointer into TIB
 	mov ecx,[tp]	        ;
 	sub ecx, edi
 	ret

PROC parse	; ( c <text>c -- a n )
 	call parse_setup
	push ecx
	jz .end

 	mov [esi], edi		; save original string as result

 	; EDI->next char in stream
 	; ECX = count of chars to process
	; AL is character to match

	repne scasb
	jecxz .end

	inc ecx

 	; we matched.  return the string and adjust tin
 	; ECX is how many characters remain in the input
.end:
	pop eax
	sub eax, ecx
 	mov [tin], edi
 	ret

ENDP parse

PROC _align
	mov ebx, [h]
	align 4
.next:
	test ebx, 3
	jz .done
	mov byte [ebx], 90h
	inc ebx
	jmp .next

.done:  mov [h], ebx
	ret
ENDP _align
 
PROC _twodup
	mov ebx, [esi]
	lea esi, [esi-8]
	;sub esi, 8	; space for two more
	mov [esi], ebx
	mov [esi+4], eax
	ret
ENDP _twodup

; ( str len buf -- )
PROC _place
	or eax, eax
	jz .4
	mov ebx, [esi+4]
	or ebx, ebx
	jz .3
	mov ebx, [esi]
	mov [eax], bl
.1: 	inc eax
	xchg eax, [esi]
	call _move
	mov byte [edi], 0
	ret
.3:	mov byte [eax], 0
.4: 	drop2
	drop
	ret
ENDP _place

PROC _printr
	upop ebp
	and ebp, 255		; clamp width
	mov edi, _npad	        ; edi = buffer (in stack space)
	mov bl, ' '
	mov ecx, [base]
	cmp ecx, 10
	jne .a
	or eax,eax	        ; Negative?
	jns .a		        ;
	neg eax 	        ;
	mov bl, '-'

.a:	xor edx,edx	        ;
	div ecx		        ;
	add dl,'0'	        ;
	cmp dl,'9'	        ;
	jbe .b		        ;
	add dl,7	        ;
.b:	dec edi 	        ;
	mov [edi],dl	        ;
	or eax,eax	        ;
	jnz .a		        ;

	cmp bl, '-'
	jne .c
	dec edi
	mov [edi], bl
.c:
	mov eax,edi	        ; Print
	dup
	mov eax, _npad
	sub eax, edi
	; fixup width
	mov ecx, ebp
	sub ebp, eax
	jle .e
	mov ebx, [padchar]
.d:	dec edi
	mov [edi], bl
	dec ebp
	jnz .d
	mov [esi], edi
	mov eax, ecx
.e:	ret
ENDP _printr

PROC  _pplace	; append string
	movzx edx, byte [eax]	; get current count
	mov ebx, [esi]		; second size
	add byte [eax], bl 	; bump size:
	add eax, edx 		; bump target ptr
	jmp _place.1
ENDP _pplace

; : variable 0
PROC variable
	upsh 0
ENDP variable
PROC variable2
	push dword [default_class]
	mov dword [default_class], vclass
	call header
	pop dword [default_class]
	jmp comma
ENDP variable2

PROC literal        ; Compile in a literal
	mov ebx, [h]
	; dup | mov eax, imm32
	mov dword [ebx], $89fc768d
	mov word [ebx+4], $0b806
	add dword [h], 6
ENDP literal
PROC comma 	        ; comma (,) saves a value to "here"
	mov ecx, 4
.0:
	mov edi, [h]
	mov [edi], eax		; stosw without add edi,4
	add [h], ecx		; bump HERE by correct amount
	drop
	ret
ENDP comma

PROC comma3	        ; comma2 (2,) saves 2 bytes to "here"
	mov ecx, 3
	jmp comma.0
ENDP comma3
PROC comma2	        ; comma2 (2,) saves 2 bytes to "here"
	mov ecx, 2
	jmp comma.0
ENDP comma2
PROC comma1	        ; comma1 (1,) saves 1 byte to "here"
	mov ecx, 1
	jmp comma.0
ENDP comma1

; ( a n -- a' n' NC | CF )
PROC _slurp
	mov dword [__ior], 0
	call openr	; handle? ior
	jnz .err	; h (invalid)
	push eax
	; get file size
	dup
	; h h 
	call io_size
	; h sl
	mov ebp, eax
	call mem_alloc
	test eax, eax
	jz .memerr
	; h ptr
	dup ; h ptr ptr
	upsh ebp
	pop ecx
	upsh ecx
	; h ptr ptr size h
	call io_read
	jnz .memerr
	; h ptr rsize
	rot
	call io_close 
.ok:	clc
	ret
.memerr: ; h ptr
	pop ecx
	drop
	call io_close
.err:	; ior
	xor eax, eax
	dup
.err1:
	stc
	ret	
ENDP _slurp

PROC eval	        ; This takes an address & count to eval
	push dword [source]     ; Save "source"
	push dword [tin]        ; Save ">in"
	push dword [tp]         ; Save "tp"
	add eax,[esi]	        ;
	upop dword [source]	        ; New "source"
	upop [tin]	        ; New ">in"
	call interpret
	pop dword [tp]	        ;
	pop dword [tin]         ;
	pop dword [source]      ;
	ret
ENDP eval
; ( <name> -- )
PROC _include
	call parsews
	; fall-through
ENDP _include
; ( a n -- CF )
PROC __include
	call _slurp
	jc .fail
	; ptr size
	push dword [esi]	; save the memory ptr
	push esi
	push eax
	call eval
	pop eax
	pop esi
	drop
	pop eax
	call mem_free
.ok:	mov dword [__ior], 0
	ret
.fail:	drop2
	mov dword [__ior], 1
	ret
ENDP __include

; ( buf count char -- )
PROC _fill
	upop ebx	; char
	upop ecx	; count
	upop edx	; buffer
	jecxz .done
.next:	mov [edx], bl
	inc edx
	loop .next
.done:
	ret
ENDP _fill
FUNCALIGN
_fzt:	; ( str len -- str ) ; copy to a temp buffer first
	call _twodup
	dup
	mov eax, fzt_buf
	swap
	call _move
	mov dword [esi], fzt_buf
	; fall through
; ( str len -- str )
PROC _zt
	upop edx
	test eax, eax
	jz .no
	add edx, eax
	mov byte [edx], 0
.no:
	ret
ENDP _zt
PROC _ztc
	dup
	cmp eax, 0
	jz .q
align 4
.a:     cmp byte [eax],0
        jz .q
        cmp byte [eax + 1],0
        lea eax, [eax + 2]
        jnz .a
        dec eax
.q:     sub eax,[esi]
	ret
ENDP _ztc

; ( xt -- exception# | 0 )

; interpreter goes here:
PROC interpret
.o:	call query	        ; ( Get a LINE )
align 4
.word:	call parsews	        ; NOTE: parsews must return 0 on failure!
	jz .nogo
; ----------------------------------------------------------------------
; Tokenizer: reads one word from input, and converts it to a token
; ( a n -- 0 | xt 1 | n 2 | n n 3 | 4 )
; TOS on return is one of:
;   0 - error, can't parse it
;   1 - XT of a found word
;   2 - one cell value
;   3 - then double-cell value
;   4 (or greater) - ignore
; Calls 'is_word', which permits the user to hook into this process and over-
; ride it if desired.  The 'is_word' is passed the string to parse on the stack.

.token:
	DEFERCALL findinternal ;  _find	; look for an XT
	test eax, eax
	jz .trynum	; failed, look for a number
	; success!
	mov ecx, 1
	jmp .afterok
.trynum:	
	drop
	call single	; try a number
	upop ecx
	test ecx, ecx
	jnz .single
	call double
	upop ecx
	test ecx, ecx
	jnz .double
.tryother:
	DEFERCALL is_word
	upop ecx
	jecxz .fail
	jmp .afterok
.double:
	mov ecx, 3
	jmp .afterok
.single:
	mov ecx, 2
.afterok:
	dec ecx
	jnz .lit
	mov edx, eax
	mov edi, [eax+CLASS_FIELD]
	mov eax, [eax+XT_FIELD]
	call edi
	jmp .word	        ; ( And Loop back )
.lit:	cmp dword [is_compiling], 0
	je .word
	cmp ecx, 1
	je .lit1
	cmp ecx, 2
	jne .word
	swap
	call literal
.lit1:  call literal
	jmp .word
.nogo:  drop2
	jmp .o
.fail:	mov ecx, [is_compiling]
	jecxz .notcompile
	mov dword [is_compiling], 0
	cmp dword [didheader], 0
	je .notcompile
	; blow away last word so we don't try to use it:
	mov ebx, [lasth]
	mov [h], ebx
	mov ebx, [lastd]
	mov [d], ebx
	mov ebx, [lastl]
	mov edx, [last]
	mov [edx], ebx
.notcompile:
	ret	
ENDP interpret

FUNCALIGN
query:
	mov dword ecx,[source]  ;
	jecxz .kbd
	upsh [tin]

	sub ecx,eax	        ; Remaining length
	jbe .eof	        ;

	add eax, ecx

	upop [tp]	        ;
	ret		        ;
.eof:	pop ebx
.eof2:  drop		        ;
	ret
FUNCALIGN
.kbd:
	DEFERCALL prompt
	mov dword [tp],tib      ; Reset TP, TIN
	mov dword [tin],tib     ;
.c:	DEFERCALL key
	cmp eax, EOF
	je bye
.ok:

;	upsh eax
;	call hexout
;	cmp dword [__ior], 0
;	jne .eof3
.redir:
	cmp eax, -1
	je .badkey
	cmp al, 10	        ;
	je .eof2		        ;
	cmp al, 13	        ;
	je .d2		        ;
	cmp al, 9		; convert keyed-in TABs into spaces:
	je .tab
	cmp al, 8		; is it a backspace?
	je .bs
.d:	mov ebx, [tp]
	mov [ebx], al
	inc ebx
	mov [tp], ebx
.d2:
	drop		        ;
	cmp dword [tp], tibtop
	jb .c		        ; And Loop back around
	jmp .eof2
.tab:	mov al, ' '
	jmp .d
.bs:	dec dword [tp]
	cmp dword [tp], tib
	jae .c
.badbs: mov dword [tp], tib
	jmp .c
.badkey:
	drop
	jmp .kbd
FUNCALIGN
__find:
	push ebx
	mov ebx, [last]

	upop ecx	        ;
	push esi
	mov esi,eax	        ;
	mov dh,  byte [eax]     ; get first char to do quick compare:
	mov dl, cl		; and the length; do both compares at once!
FUNCALIGN
.a:	mov ebx,[ebx]	        ;
	test ebx,ebx	        ;
	jz .end 	        ; end of wordlist
	lea edi, [ebx+NAME_FIELD]	; point edi at the string
	cmp dx, [edi]		
	jne .a
	inc edi

.len:   push esi	        ; same length, so do the compare
	push ecx	        ;
	repe cmpsb	        ;
	pop ecx 	        ;
	pop esi 	        ;
	jne .a		        ;

.ret3:  mov eax,ebx         ; exact match: return XT
.ret:	pop esi
.ret2:  pop ebx 	        ;
	ret
.end:	pop esi
	upsh ecx	        ; no matches
	upsh ebx
	jmp .ret2

FUNCALIGN
word_not_found:			; What to do if we can't find a word
	DEFERCALL type		; Display the name
	upsh '?'
	DEFERCALL emit
	upsh 10
	DEFERCALL emit
	upsh 0
	ret

; ----------------------------------------------------------------------
FUNCALIGN
fromdigit_ebx:
	sub ebx, 30h ; 0
	js .bad
	cmp ebx, 4ah
	ja .bad
	movzx ebx, byte [fromdigits + ebx]
	cmp ebx, [base]
	jae .bad
.ok:	ret
.bad:   mov ebx, -1
	ret

PROC fromdigit
	mov ebx, eax
	call fromdigit_ebx
	mov eax, ebx
	ret
ENDP fromdigit
PROC todigit		; ( n -- c )  ---- convert digit to correct ASCII 
	cmp al, 16
	jae .weird
	mov al, byte [digits+eax]
	ret
.weird: mov ebx, [base]
	xor edx, edx
	div ebx
	add dl,'0'	        ;
	cmp dl,'9'	        ;
	jbe .b		        ;
	add dl,7+32	        ;
.b:	mov al, dl
	ret
ENDP todigit
; ----------------------------------------------------------------------
; ( a n -- n -1 | a n 0 ) 
PROC single
	push dword [base]
	push eax
	push esi
	push dword 1	; negative?

	; set up for the current base
	mov ebp, [base]

	; set up for processing:
	upop ecx
	jecxz single.err

	mov edi, eax
	xor eax, eax

	; leading '-' is valid 
	cmp byte [edi], '-'
	jne .s1

	; negative:
	dec dword [esp]
	dec dword [esp]

	inc edi
	dec ecx
	jz .err

.s1:	; check for special base switch char:
	movzx ebx, byte [edi]
	; #$%&'
	sub ebx, '#'
	js .s2
	cmp ebx, 4
	ja .s2
	je .base255
	; in-range, so get the base
	movzx ebp, byte [bases+ebx]
	mov [base],ebp
	inc edi
	dec ecx
	jz .err

.s2:	; process each character	
	; make sure it's a valid character:
	movzx ebx, byte [edi]
	call fromdigit_ebx
	cmp  ebx, ebp
	jae .err
	cmp ebx, -1
	jne .noerr
.err:	pop ebx
	pop esi
	pop eax
	pop dword [base]
	upsh 0
	ret
.noerr:
	; it's valid: do the multiplication+accumulate
	mul ebp		; eax *= base
	jo .err
	add eax, ebx
	jo .err
	inc edi
	loop .s2

.s4:	; end of input string.  EAX is the number.  
	pop ebp
	mul ebp
	pop esi
	pop ebx		; toss away old count 
	add esi, 4	; fix up the stack
.ok:	upsh -1
	pop dword [base]
	ret

.base255:
	drop
	inc edi
	movzx eax, byte [edi]
	jmp .s4
ENDP single

PROC double
	push dword [base]
	push eax
	push esi
	push dword 1	; negative?

	; set up for the current base
	mov ebp, [base]

	; set up for processing:
	upop ecx
	jecxz single.err

	mov edi, eax
	xor eax, eax
	xor esi, esi

	; require final L:
	cmp byte [edi+ecx-1], 'L'
	jne single.err
	dec ecx

	; leading '-' is valid 
	cmp byte [edi], '-'
	jne .d1

	; negative:
	dec dword [esp]
	dec dword [esp]

	inc edi
	dec ecx
	jz single.err

.d1:	; check for special base switch char:
	movzx ebx, byte [edi]
	; #$%&'
	sub ebx, '#'
	js .d2
	cmp ebx, 3
	ja .d2

	; in-range, so get the base
	movzx ebp, byte [bases+ebx]
	mov [base], ebp
	inc edi
	dec ecx
	jz single.err

.d2:	; process each character	
	; make sure it's a valid character:
	movzx ebx, byte [edi]
	; permit commas and periods
	cmp bl, '.'
	je .ignore
	cmp bl, ','
	je .ignore

	call fromdigit_ebx
	cmp  ebx, ebp
	jae single.err
	cmp ebx, -1
	je single.err
	; it's valid: do the multiplication+accumulate
	; ESI:EAX is double
	mul ebp		; eax *= base
	; edx is carry.  Save it
	push edx
	xchg eax, esi
	mul ebp
	xchg eax, esi
	pop edx
	; add carry:
	add esi, edx
	; add digit:
	add eax, ebx
	adc esi, 0
.ignore:
	inc edi
	loop .d2

.d4:	; end of input string.  EDX:EAX is the number.  
	pop ebp
	cmp ebp, -1
	jne .d5
	not esi
	neg eax
	sbb esi, -1
.d5:
	mov edx, esi
	pop esi
	pop ebx		; toss away old count 
	pop dword [base]
	add esi, 4	; fix up the stack
	upsh edx
.ok:	upsh -1
	ret
ENDP double

PROC parse_with_escape
	mov ebx, '\' 
.top:
	mov edi,[tin]	        ; Pointer into TIB
	mov ecx,[tp]	        ;
	sub ecx, edi
	inc ecx			 ;lea ecx, [-1*edi+1]
	mov bh, al		; bl = \  bh = parsechar
	mov ebp, parse_buf 	; ebp = current output location
	xchg esi, edi		; edi == old ESI, esi=src
	; skip leading delimiter:
	lodsb
FUNCALIGN
	; skip until trailing character
	; al is already something other than the terminator
.2:	cmp al, bl
	je .escaped
	; not escaped check for end of run
	cmp al, bh
	je .endofstring
	; neither end of string nor escaped:
.onechar:
	mov byte [ebp], al
	inc ebp
	lodsb
	loop .2

	; we ended the loop one way or the other
.endofstring:
	xchg edi, esi	; restore the 'stack' ptr
	mov eax, parse_buf
	dup
	sub eax, ebp
	neg eax
	mov [tin], edi
	ret

.escaped:
	lodsb
	dec ecx
	jmp .onechar
ENDP parse_with_escape

; simple 'load one file' for the revacore:
GLOBAL _hello
FUNCALIGN
_hello:
	upsh [argc]
	cmp eax, 1
	je .done
	drop
	upsh [argv]
	call _ztc
	upop ebx
	add eax, ebx
	inc eax
	call _ztc
	call __include
.done:	drop
	jmp interpret

PROC _save	; ( a n -- )
	call cleanup
	call _twodup	; ( a n a n )
; STEP 1: Create the destination file, with the executable bit set if needed:
	; open the file
	call io_create
	jnz .err1 ; ( a n h )
	mrot
	call _fzt
	call _makeexe
	; EAX is file handle - save it
	dup	; ( h h )

; STEP 2: Read the running executable, and get back to the 'revacore' part, and
;         write it out to the file created above:
	call slurp_exe
	; ( h h a n )
	mov edx, [revacore_offset]
	or edx, edx
	jz .core

	mov eax, edx
	jmp .nosig
.core:
	mov [revacore_offset], eax

.nosig:
	; write out the exe
	rot
	call io_write
	dup
	; ( fh fh )
	mov ebp, [extra_size]
	mov [sh_esz], ebp
	mov ecx, [h]
	sub ecx, _h0
	mov [sh_hsz], ecx

	; calculate the total size of our data:
	upsh [sh_hsz]
	add eax, [sh_esz]
	add eax, [static_size]
	xor ecx, ecx
	mov ebx, [nosavedict]
	mov ecx, [d]
	sub ecx, _d0
	or ebx, ebx
	jnz .nosave1
	add eax, ecx ; [sh_dsz]
.nosave1:
	mov [sh_dsz], ecx

	dup	; stack has ( size size )
	mov [sh_size], eax	; save our size for later use
	; what is the max we need to have:
	call blz_maxsize
	; allocate a buffer that big:
	call mem_alloc
	upop [sh_ptr2]	; save our dest ptr for compression
	call mem_alloc
	upop [sh_ptr1]	; save the src ptr for compression

	; copy all our data to the sh_ptr1 staging area:
	mov  ebx, [sh_ptr1]
	push ebx

	upsh static_start
	upsh ebx
	upsh [static_size]
	call _move
	pop ebx
	add ebx, [static_size]
	push ebx

	upsh _h0
	upsh ebx
	upsh dword [sh_hsz]
	call _move
	pop ebx
	add ebx, [sh_hsz]
	push ebx

	mov edx, [nosavedict]
	or edx, edx
	jnz .nosave2
	upsh _d0
	upsh ebx
	upsh dword [sh_dsz]
	call _move
	pop ebx
	add ebx, [sh_dsz]
	push ebx
.nosave2:
	;; extra
	upsh dword [extra_data]
	upsh ebx
	upsh dword [sh_esz]
	call _move
	pop ebx
	add ebx, [sh_esz]
	push ebx
	

	pop ebx

	; all the data are in sh_ptr,sh_size  now compress
	upsh [sh_ptr1]
	upsh [sh_size]
	upsh [sh_ptr2]
	call blz_pack
	mov [sh_size], eax
	drop2

;	mov [sh_total], dword 0
	upsh save_header
	upsh dword HEADERSIZE
	call saveit

	upsh [sh_ptr2]
	upsh [sh_size]
	call saveit

	; write out the offset of the revacore:
	upsh revacore_offset
	upsh 4
	call saveit
	drop

	call io_close
.err:	ret
.err2:	; ( h h 0 0 ) close the errant handle
	rot
	call io_close
.err1:  drop2
	drop
	ret
ENDP _save
FUNCALIGN
saveit: ; fh fh ptr size
;	test eax, eax
;	jz .d2
;	add [sh_total], eax
	rot
	call io_write
	dup
	ret
;.d2:	drop2
;	ret

PROC colon 	        ; Ok, this is the entry to the compiler
	call header
	;call rbracket
	;ret 
ENDP colon

PROC rbracket	        ; This is the actual compiler loop
;	mov dword [is_compiling], 1
	inc dword [is_compiling]
	ret
ENDP rbracket


PROC tick
	call parsews
	DEFERCALL findinternal
	test eax, eax
	jz .bad
	mov eax, [eax+XT_FIELD]
	ret
.bad:	drop2
	xor eax, eax
	ret
ENDP tick

; compare a1 and a2; if identical upto min(n1,n2) then (n1==n2)?0:(n1<n2)?-1:1;
; ( a1 n1 a2 n2 -- result )
PROC compare
	call compare_common
	repe cmpsb 	; if Z then strings compare equal
	jz .equal

	mov al, [esi-1]	; do lexicographic compare
	sub al, [edi-1]
.neq:
	movsx eax, al
	jmp .done
.equal: mov eax, edx
.done: 	pop  esi
	ret
ENDP compare

PROC comparei
	call compare_common
	
.ok:	mov al, [esi]
	inc esi
	mov ah, [edi]
	inc edi

	cmp al, "A"
	jb .nowrap
	cmp al, "Z"
	ja .nowrap
	or al, 20h
.nowrap:
	cmp ah, "A"
	jb .nowrap2
	cmp ah, "Z"
	ja .nowrap2
	or ah, 20h
.nowrap2:

	sub al, ah
	loope .ok
	; either not equal, or out of string
	jne compare.neq
	jecxz compare.equal
	jmp compare.neq
ENDP comparei
	

; Internal routine:
; EAX:ECX --> string1
; EDI:EDX --> string2
; leaves EAX=result
; trashes EDI, ECX,, EDX

FUNCALIGN
compare_common:
	upop edx	; n2
	upop edi	; a2
	upop ecx	; n1

	pop  ebp

	jecxz .zerolength
	or eax, eax 
	jz .null
	or edx, edx 
	jz .zerolength
	or edi, edi 
	jz .null

	push esi
	mov  esi, eax	; a1
	mov  eax, edx	; n2
	sub  edx, ecx	; n2-n1
	neg  edx
	cmp  ecx, eax
	jl .ok1
	mov ecx, eax    ; compare for shorter of two lengths
.ok1:
	jmp ebp

.null:
.zerolength:
	xor eax, eax
	cmp ecx, edx
	jz  .done
	mov eax, 1
	jg  .done
	neg eax
.done:
	ret

	


; Implementation of FNV-1a hash:  http://www.isthe.com/chongo/tech/comp/fnv/
; ( str len -- hash )

PROC  fnvhash
	upop ecx	; ECX is len, EAX is stringptr
	mov ebx, eax
.0:
	mov eax, 2166136261	; offset-basis
	mov ebp, 16777619	; FNV prime (32bits)

.1:
	xor al, [ebx]
	mul ebp
	inc ebx
	loop .1
	ret
ENDP fnvhash

PROC onexit
	upsh __exit
	jmp link
ENDP onexit
; iterate over 'exit handlers' and call each one, in reverse order:
PROC cleanup
	upsh __onstart
	upsh __exit
	jmp iterate
ENDP cleanup

PROC catch
	; save data stack
	push esi
	; save value of current handler
	push dword [handler]
	; save value of ESP to 'handler'
	mov [handler], esp
	; execute the XT we got:
	mov ebx, eax
	lodsd
	call ebx
	; if we are here, no 'throw' happened so clean the stack
	pop dword [handler]
	pop ebx	; get rid of saved ESI
	upsh 0	; make sure caller knows there was no failure
	ret
ENDP catch
PROC throw
	test eax, eax
	jz .nothrow
	; throw code in eax - return control to caller of 'catch'
	mov ebx, [handler]
	test ebx, ebx
	jz .nothrow	; blech!  NULL makes a poor handler...
	mov esp, ebx	; set ESP back to the context of the catch
	pop dword [handler]	; restore old handler
	pop esi		; restore previous data stack, but with throwcode on top
	ret		; return to caller
.nothrow:
	drop
	ret
ENDP throw

PROC onstartup
	upsh __start
ENDP onstartup
PROC link2 ; ( dataptr listptr -- )
	; go to the end of the list
.toend:
	mov ebx, eax	; prior ptr in EBX
	mov eax, [eax]	; get previous ptr
	or eax, eax
	jnz .toend
	; EAX is zero, EBX is last ptr.
	mov eax, ebx
	; fall through to 'link'
ENDP link2
PROC link
	; ( dataptr listptr -- )
	mov edx, [h]
	mov ebx, [eax]	; dataptr listptr ebx=prior-item
	mov [eax], edx  ; put here-> listptr
	drop
	mov [edx], ebx	; prior-item --> here
	mov [edx+4], eax
	add dword [h], 8 
	drop
	ret
ENDP link

PROC iterate
	; ( xt list -- )
	upop ecx	; list
	upop ebx	; XT
	or ebx, ebx
	jz .done

.1:	mov ecx, [ecx]
	jecxz .done

	push ecx
	push ebx
	lea edx, [ecx+4]
	upsh edx
	call ebx
	pop ebx
	pop ecx
	upop edx
	or edx, edx
	jnz .1
.done:	ret
ENDP iterate
PROC trampoline
	DEFERCALL exception
	jmp eax
ENDP trampoline
PROC setextra
	; ( a n -- )
	upop ecx
	mov dword [extra_size], ecx
	upop ecx
	mov dword [extra_data], ecx
	ret
ENDP setextra
PROC getextra
	; ( -- a n )
	dup
	mov eax, dword [extra_data]
	dup
	mov eax, dword [extra_size]
	ret
ENDP getextra



before_compress:
%include 'src/brieflz.asm'
after_compress:

code_end:

;;; CODE ENDS HERE

;;; INITIALIZED DATA HERER
DATASECTION
align 4
	ssemi_do_tail dd 090h
	extra_size dd 0
	extra_data dd 0

static_start:
	DEFER prompt
	DEFER appstart, _hello 
	DEFER key, os_key
	DEFER findinternal, __find
	DEFER is_word, word_not_found
	DEFER type, os_type
	DEFER emit, os_emit
	DEFER do_cr
	DEFER exception, os_bye
	DEFER ctrlc_handler
	DEFER heapgone, os_bye
	DEFER dictgone, os_bye
	DEFER _header, __header

;mylink=0
	;; BEGIN DICTIONARY
	align 4

	DICT "'", tick
	DICT "makeexe", _makeexe
	DICT 'exception', exception,dclass
	DICT 'heapgone', heapgone, dclass
	DICT 'dictgone', dictgone, dclass
	DICT 'ctrl-c', ctrlc_handler,dclass
	DICT 'do_cr', do_cr, dclass
	DICT 's0',s0,cclass
	DICT 'd0',d0,vclass
	DICT 'h0',h0,vclass
	DICT 'ioerr',__ior,vclass
	DICT 'rp0',rp0,cclass
	DICT "padchar",padchar,vclass
	DICT '>in',tin,vclass
	DICT 'tib',_tib,vclass
	DICT 'tp',tp,vclass
	DICT 'src',source,vclass
	DICT 'state',is_compiling,vclass
	DICT 'dict',d,vclass
	DICT '(here)',h,vclass
	DICT 'last',last,cclass
	DICT 'base',base,vclass
	DICT '(argv)',argv,valclass
	DICT 'argc',argc,valclass
	DICT 'hinst',hinstance,valclass
	DICT 'stdout',StdOut,valclass
	DICT 'stdin',StdIn,valclass
	DICT 'os',_os,cclass

	DICT 'syscall',os_syscall
	DICT 'nosavedict',nosavedict,vclass
	DICT 'cold',cold
	DICT 'reset',reset
	DICT 'prompt',prompt,dclass
	DICT 'default_class',default_class, vclass
	DICT '>lz',blz_pack
	DICT 'lz>',blz_depack
	DICT 'lzmax',blz_maxsize
	DICT "'variable",vclass
	DICT "'constant",cclass
	DICT "'does",doesclass
	DICT "'value",valclass
	DICT "'forth",fclass
	DICT "'notail",fclass_notail
	DICT "'macro",mclass
	DICT "'inline",iclass
	DICT "'macront",mclass_notail
	DICT "'defer",dclass
	DICT 'catch',catch
	DICT 'throw',throw
	DICT 'onexit',onexit
	DICT 'onstartup',onstartup
	DICT '(lib)',_loadlib
	DICT '(-lib)',_unloadlib
	DICT '(call)',_call
	DICT '(func)',_osfunc
	DICT 'fnvhash',fnvhash
	DICT '(bye)',bye
	DICT 'cmp',compare
	DICT 'cmpi',comparei
	DICT 'place',_place
	DICT '+place',_pplace
	DICT 'move',_move
	DICT 'fill',_fill
	DICT 'zt',_zt
	DICT 'zcount',_ztc
	DICT 'open/r',openr
	DICT 'open/rw',openrw
	DICT 'creat',io_create
	DICT 'close',io_close
	DICT 'read',io_read
	DICT 'write',io_write
	DICT 'fsize',io_size
	DICT 'allocate',mem_alloc
	DICT 'free',mem_free
	DICT 'resize',mem_realloc
	DICT 'header',header
	DICT '(header)', _header, dclass
	DICT 'literal',literal, mclass
	DICT ';;',ssemi, mclass
	DICT ';inline',inlinesemi, mclass
	DICT 'parsews',parsews
	DICT 'align',_align
	DICT 'here,',store_here
	DICT 'compile',compile
	DICT 'interp',interpret
	DICT 'key',key,dclass
	DICT 'appstart',appstart,dclass
	DICT 'emit',emit,dclass
	DICT 'find-dict',findinternal,dclass
	DICT '>single',single
	DICT '>double',double
	DICT 'word?',is_word,dclass
	DICT 'type',type,dclass
	DICT 'digit>',fromdigit
	DICT '>digit',todigit
	DICT ':',colon, mclass
	DICT ';',semi, mclass
	DICT '[',lbracket, mclass
	DICT ']',rbracket, mclass
	DICT '2dup',_twodup
	DICT 'variable',variable
	DICT 'variable,',variable2
	DICT ',' , comma
	DICT '3,' , comma3
	DICT '2,' , comma2
	DICT '1,' , comma1
	DICT 'include',_include
	DICT '(include)',__include
	DICT 'eval',eval
	DICT 'parse',parse
	DICT 'parse/',parse_with_escape
	DICT 'appname',appname,cclass
	DICT '(save)',_save
	DICT "(.r)",_printr
	DICT 'link', link
	DICT '-link', link2
	DICT 'iterate', iterate
	DICT 'slurp',_slurp
	DICT 'setextra', setextra
	DICT 'getextra', getextra
;	DICT 'compsize', compress_size,cclass

;; END DICTIONARY

align 4
;NONBSS
flast dd mylink ; last word in dictionary

VARNEW last,flast
VARNEW h, _h0
VARNEW d,_d0		;
VARNEW default_class,fclass
VARNEW padchar,32
VARNEW base,10
VARNEW _os, OS
VARNEW appname, app_file_name

;VARNEW compress_size, (after_compress-before_compress)

revacore_offset dd 0
__start dd 0
__exit dd 0
handler dd 0
static_size dd  $-static_start
; ----------------------------------------------------------------------
; ( c -- n ) -- convert character to digit
; ----------------------------------------------------------------------
; This table is used for converting an input character to a digit.  Some special 
; flags are also here: -3 means invalid character (in a number).  80h means NOP 
; - ignore the character, and 80h+xxx means switch to base xxx
;argc dd 0
fromdigits:
;    0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
db 00h, 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h,  -1,  -1,  -1,  -1,  -1,  -1  ;3
db  -1, 0ah, 0bh, 0ch, 0dh, 0eh, 0fh, 10h, 11h, 12h, 13h, 14h, 15h, 16h, 17h, 18h  ;4
db 19h, 1ah, 1bh, 1ch, 1dh, 1eh, 1fh, 20h, 21h, 22h, 23h,  -1,  -1,  -1,  -1,  -1  ;5
db  -1, 0ah, 0bh, 0ch, 0dh, 0eh, 0fh, 10h, 11h, 12h, 13h, 14h, 15h, 16h, 17h, 18h  ;6
db 19h, 1ah, 1bh, 1ch, 1dh, 1eh, 1fh, 20h, 21h, 22h, 23h  ; ,  -1,  -1,  -1,  -1,  -1  ;7
align 4
digits db '0123456789ABCDEF'
align 4
bases db 10,16,2,8,255

align 4
VARNEW argc
VARNEW argv
VARNEW is_compiling
VARNEW __ior
VARNEW source
VARNEW tin
VARNEW StdOut
VARNEW StdIn
VARNEW hinstance
VARNEW tp,tib
VARNEW s0,_s0
VARNEW d0,_d0
VARNEW h0,_h0
VARNEW _tib, tib
VARNEW rp0, _rp0
VARNEW nosavedict

; ----------------------------------------------------------------------
; END PERSISTED STATICS
; ----------------------------------------------------------------------
align 4
save_header:
	; These are data-chunks to save:
	sh_hsz dd 0		; code size (need to fill it in)
	sh_dsz dd 0		; dict size (need to  fill it in)
	sh_esz dd 0		; 'extra' size to append
save_header_end:

	; These are for compression and decompression:
	sh_size dd 0
	sh_ptr1 dd 0		; uncompressed data
	sh_ptr2 dd 0		; compressed data

data_end:

;;; UNINITIALIZED DATA HERE
BSSSECTION 
align 4
	resb 32		; fix: 299
_npad:
_rp0 resd 1
lasth resd 1
lastd resd 1
lastl resd 1
didheader resd 1
align 4
tib resb TIBSIZE		; Text Input Buffer (1k)
tibtop:

align 4
__pad:
parse_buf resb 128 k
app_file_name	resb 256
fzt_buf resb 512
 resd 16	; underflow area.
    resd STACKSIZE	; Stack (2k normal)
_s0  resd 1
 resd 256	; underflow area.
_s1  resd 1
align 4
blz_limit resd 1
blz_bkptr resd 1
blz_mem resd 1

 align 4 
_d0  resb DICTSIZE		; Dictionary 
_dtop:

align 4
_h0  resb CODESIZE		; Code 
_htop:
