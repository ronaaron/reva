; The "new core" uses NASM so it can be compiled anywhere NASM runs


%define k *1024
%define DICTSIZE 2000 k
%define CODESIZE 2000 k
%define STACKSIZE 2 k
%define TIBSIZE 1 k
%define HEADERSIZE (save_header_end - save_header)

%define XT_FIELD 4
%define NAME_FIELD 8
%define CLASS_FIELD -4
%define FUNCALIGN align 4	; on Mac it's 16!

%define swap xchg eax, dword [esi]
%macro dup 0
	lea esi, [esi-4]
	mov [esi], eax
%endmacro
%macro drop2 0
	lodsd
	lodsd
%endmacro
%define drop lodsd
%macro rot 0
	push eax
	mov eax, [esi+4]
	mov ebx, [esi]
	mov [esi+4], ebx
	pop dword [esi]
%endmacro
%macro mrot 0
	push eax
	mov ebx, [esi+4]
	mov eax, [esi]
	mov [esi], ebx
	pop dword [esi+4]
%endmacro

%macro upsh 1
	dup
	mov eax, %1
%endmacro
%macro upop 1
	mov %1, eax
	drop
%endmacro
%macro countstr 1
%%start_of_string:
	db (%%eos-%%start_of_string-1)
	db %1
%%eos:
%endmacro

%macro PROC 1	; xt name
%if (OS==MAC)
GLOBAL %1
%endif
FUNCALIGN
%1:
%endmacro
%macro ENDP 1
%endmacro
%macro DEFER 1-2	; xt,fun
%if (OS==MAC)
GLOBAL %1
%endif
	PROC %1
%ifempty %2
	dd noop
%else
	dd %2
%endif
	ENDP %1
%endmacro

%macro DEFERCALL 1
%if (OS==MAC)

	call dword [%1]
	
%else
	call dword [%1]
%endif
%endmacro


%macro DEFERJMP 1
%if (OS==MAC)
	jmp dword [%1]
%else
	jmp dword [%1]
%endif
%endmacro

%macro VARNEW 1-2
FUNCALIGN
%ifempty %2
	%1: dd 0
%else
	%1: dd %2
%endif
%endmacro
%define mylink 0
%macro DICT 2-3	; name, xt, class
align 4
%ifempty %3
	dd fclass
%else
	dd %3
%endif
%%us:
;%2.dict:
	dd mylink
%define mylink %%us
	dd %2
	countstr %1
%endmacro

; This is for debugging!
%macro GOTHERE 0-1
%ifempty %1
	upsh '*'
%else
	upsh %1
%endif
	call emit
%endmacro

%macro stdcall 1-9 ;proc,[arg] 		; indirectly call STDCALL procedure
	%define _j %1
	%rep %0-1
	%rotate -1
	push %1
	%endrep
	call _j
%endmacro

%macro ccall 1-9 
	%define _j %1

	push esi
	push ebp
	mov ebp, esp
	
%if (OS==MAC)
	%assign __params %0-1
	; necessary on Mac:
	sub esp, 010h
	and esp, 0fffffff0h
	; stack is aligned on 16 -byte boundary.  now adjust for parameters

	%if __params > 0
	sub esp, 4*(4-(__params % 4))
	%endif
%endif

	; push arguments in reverse order:
	%rep %0-1
		%rotate -1
		push %1
	%endrep


	; call the routine
	;int3
	call _j

	mov esp, ebp
	pop ebp
	pop esi
%endmacro
