; vim: ft=nasm 

%define EOF 26

%define INVALID_HANDLE_VALUE  -1
%define STD_INPUT_HANDLE      -10
%define STD_OUTPUT_HANDLE     -11
%define STD_ERROR_HANDLE      -12
%define GENERIC_READ		   80000000h
%define GENERIC_WRITE		   40000000h
%define GENERIC_EXECUTE 	   20000000h
%define GENERIC_ALL		   10000000h
%define CREATE_NEW	   1
%define CREATE_ALWAYS	   2
%define FILE_SHARE_READ 	   00000001h
%define FILE_SHARE_WRITE	   00000002h
%define FILE_SHARE_DELETE	   00000004h
%define FILE_ATTRIBUTE_READONLY    001h
%define FILE_ATTRIBUTE_HIDDEN	   002h
%define FILE_ATTRIBUTE_SYSTEM	   004h
%define FILE_ATTRIBUTE_DIRECTORY   010h
%define FILE_ATTRIBUTE_ARCHIVE	   020h
%define FILE_ATTRIBUTE_NORMAL	   080h
%define FILE_ATTRIBUTE_TEMPORARY   100h
%define FILE_ATTRIBUTE_COMPRESSED  800h
%define OPEN_EXISTING	   3
%define OPEN_ALWAYS	   4
%define TRUNCATE_EXISTING  5
%define PAGE_EXECUTE_READWRITE 	40h

%define SIGTRAP 080000003h
%define SIGFPE 0C0000094h
%define SIGILL 0C000001dh
%define SIGSEGV 0C0000005h

%define CODESECTION SECTION .text
%define DATASECTION SECTION .data
%define BSSSECTION  SECTION .bss
; include "inc/win32a.inc"

%define KEY_EVENT 1
%define MOUSE_EVENT 2
%define WINDOW_BUFFER_SIZE_EVENT 4
%define MENU_EVENT 8
%define FOCUS_EVENT 16
%define CTRL_C_EVENT  0
%define CTRL_BREAK_EVENT  1
%define CTRL_CLOSE_EVENT  2
%define CTRL_LOGOFF_EVENT  5
%define CTRL_SHUTDOWN_EVENT  6
%define ENABLE_LINE_INPUT  2
%define ENABLE_ECHO_INPUT  4
%define ENABLE_PROCESSED_INPUT  1
%define ENABLE_WINDOW_INPUT  8
%define ENABLE_MOUSE_INPUT  16
%define ENABLE_PROCESSED_OUTPUT  1
%define ENABLE_WRAP_AT_EOL_OUTPUT  2

CODESECTION
%define GetProcessHeap _GetProcessHeap@0
%define HeapAlloc _HeapAlloc@12
%define HeapReAlloc _HeapReAlloc@16
%define HeapFree _HeapFree@12
%define GetModuleHandle _GetModuleHandleA@4
%define GetModuleFileName _GetModuleFileNameA@12
%define GetCommandLine _GetCommandLineA@0
%define ExitProcess _ExitProcess@4
%define GetStdHandle _GetStdHandle@4
%define WriteFile _WriteFile@20
%define ReadFile _ReadFile@20
%define ReadConsole _ReadConsoleA@20
%define CreateFile _CreateFileA@28
%define GetLastError _GetLastError@0
%define GetFileSize _GetFileSize@8
%define CloseHandle _CloseHandle@4
%define LoadLibrary _LoadLibraryA@4
%define FreeLibrary _FreeLibrary@4
%define GetProcAddress _GetProcAddress@8
%define SetErrorMode _SetErrorMode@4
%define SetConsoleCtrlHandler _SetConsoleCtrlHandler@8
%define SetConsoleOutputCP _SetConsoleOutputCP@4
%define GetConsoleOutputCP _GetConsoleOutputCP@0
%define Sleep _Sleep@4
;%define VirtualProtect _VirtualProtect@16
%define SetUnhandledExceptionFilter _SetUnhandledExceptionFilter@4

extern GetProcessHeap, HeapAlloc, HeapReAlloc, HeapFree, GetModuleHandle
extern GetModuleFileName, GetCommandLine, ExitProcess, GetStdHandle
extern WriteFile, ReadFile, ReadConsole, CreateFile, GetLastError
extern GetFileSize, CloseHandle, LoadLibrary, FreeLibrary, GetProcAddress
extern SetErrorMode, SetConsoleCtrlHandler, SetConsoleOutputCP
extern GetConsoleOutputCP, Sleep, SetUnhandledExceptionFilter
;extern VirtualProtect

;%define CODESIZE (code_end-os_start)
;---------------------------------------------------------------------
; windows-specific linkage stuff:
CODESECTION
	jmp start	; stupid, but there you have it
align 4
os_start:
	push esi
	; make sure we can write our code section:
;	stdcall VirtualProtect, os_start, CODESIZE, PAGE_EXECUTE_READWRITE  , oldprotect
	stdcall GetModuleHandle, 0
	mov [hinstance], eax
	push eax
	stdcall GetModuleFileName, eax, app_file_name, 255
	pop eax

	stdcall GetStdHandle, STD_INPUT_HANDLE
	mov [StdIn], eax

	stdcall GetStdHandle, STD_OUTPUT_HANDLE
	mov [StdOut], eax

	stdcall GetProcessHeap
	mov [processheap], eax

	; set console to UTF8 mode
	stdcall GetConsoleOutputCP
	mov [origcp], eax
	stdcall SetConsoleOutputCP, 65001	

.redirected:

	stdcall GetCommandLine
	mov [argv], eax
	; figure out how many args there are, while modifying the argv if necessary:
	mov esi, eax
	mov edi, esi
	xor eax, eax
	mov [argc], eax		; initially, zero args

	; normal argument
.argloop:
	lodsb		; ESI, source string
	cmp al, '"'
	je .quoteloop
	cmp al, ' '	; space
	je .argspace
	cmp al, 9	; tab
	je .argspace
	or al, al
	jz .argend
	stosb
	jmp .argloop

.quoteloop:
	lodsb		; ESI, source string
	or al, al
	jz .argend
	cmp al, '"'	; space
	je .argspace
	stosb
	jmp .quoteloop

.argspace:	; esi points to a space character
	mov [edi], ah	; NUL terminate
	inc edi
	; scan to end of spaces
.argspace2:
	lodsb
	cmp al, ' '
	je .argspace2
	cmp al, 9
	je .argspace2
	or al, al
	jz .argend
	; now ESI points to next argument, and EDI points to next place to
	; store:
	dec esi
	inc dword [argc]
	jmp .argloop

.argend:
	inc dword [argc]
	mov [edi], ah

	; set up exception handler
	pusha
	stdcall SetErrorMode, -1
	stdcall SetUnhandledExceptionFilter, win_except
	stdcall SetConsoleCtrlHandler, ctrl_c, 1
	popa

	pop esi
	ret

;except_code dd 0
;except_addr dd 0
;except_ip   dd 0
align 4
ctrl_c:
	push ebp
	mov ebp, esp
	push esi

	sub esp, 8
	mov esi, esp
	sub esp, 80

	mov eax, [ebp+8]
	cmp eax, 2	; CTRL_CLOSE_EVENT
	je os_bye

	DEFERCALL ctrlc_handler
	mov eax, 1 ; handled the request

	pop esi
	mov esp, ebp
	pop ebp
	ret 4

;.close:	jmp os_bye

%define uc_edi 0+156
%define uc_esi 4+156
%define uc_ebx 8+156
%define uc_edx 12+156
%define uc_ecx 16+156
%define uc_eax 20+156
%define uc_ebp 24+156
%define uc_esp 40+156
%define uc_eip 28+156
align 4
win_except:
	push ebp
	mov ebp, esp

	;push esi
	;sub esp, 8
	;mov esi, esp
	;sub esp, 80
	; do something with the data passed in:
	mov eax, [ebp+8]	; EXCEPTION_POINTERS
	mov ebx, [eax+4]	; CONTEXT_RECORD
	push dword [eax]	; EXCEPTION_RECORD

	mov esi, _s1
	upsh dword [ebx+uc_edi]	; EDI
	upsh dword [ebx+uc_esi]	; ESI
	upsh dword [ebx+uc_ebx]	; EBX
	upsh dword [ebx+uc_edx]	; EDX
	upsh dword [ebx+uc_ecx]	; ECX
	upsh dword [ebx+uc_eax]	; EAX
	upsh dword [ebx+uc_ebp]	; EBP
	upsh dword [ebx+uc_esp]	; ESP
	upsh dword [ebx+uc_eip]	; EIP
	pop ecx
	upsh dword [ecx] 	; ExceptionCode

	mov [ebx+uc_eax], eax
	mov [ebx+uc_esi], esi

	mov eax, [_rp0]
	mov [ebx+uc_esp], eax 	; return stack
	mov eax, trampoline
	mov [ebx+uc_eip], eax 	; EIP

	mov eax, -1
	pop esi
	mov esp, ebp
	pop ebp
	ret 4

; 	; set up 'per thread' handler
; 	pop eax		; return address
; 	xor ebx, ebx
; 	push ebp
; 	push dword 0
; 	push dword 0
; 	push dword [fs:ebx]
; 	push criterr
; 	push dword [fs:ebx]
; 	mov dword [fs:ebx], esp
; 	jmp eax		; go back to caller

; Critical error handler:
; ALIGN 4
; criterr:
; 	mov  eax, [esp+4]	; esp+4 --> exception record
; 				; esp+8 --> CONTEXT record
; 				; esp+12 -->  ERR structure
; 				; EXCEPT+0 -> exception code
; 				;  + 4 -> flags
; 				;  + 8 -> nested exception
; 				;  + 12  -> exception address
; 				;  + 16 -> numberparams
; 				;  + 20 -> additional data
; 	mov ebx, [eax]
; 	mov [except_code], ebx	; 
; 	mov ebx, [eax+12]
; 	mov [except_addr], ebx
; 	call reset
; 	call exception
; 	mov eax, [esp+12]
; 	mov dword [eax+0xb8], hello
; 	mov eax, 0	; 1 = next handler, 0= continue
; 	ret


;---------------------------------------------------------------------

;---------------------------------------------------------------------
; IMPLEMENTATION OF OS-DEFERRED WORDS
;---------------------------------------------------------------------
os_bye:
	push ebx
	stdcall SetConsoleOutputCP, 1 ;[origcp]
	pop ebx
	upop ebx
	stdcall ExitProcess,ebx
align 4
os_type:
	mov ebx, [esi]
	pusha
	stdcall WriteFile, dword [StdOut], ebx, eax, written_buffer, 0
	popa
	drop2
	ret

align 4
os_emit:
	pusha
	mov [emit_buffer], eax  ; keep it safe
	stdcall WriteFile, dword [StdOut], emit_buffer, 1, written_buffer, 0
	popa
	drop
	ret

align 4
os_key:
	dup
	mov eax, -1
	mov [emit_buffer], eax
	push esi
	;stdcall ReadConsole, dword [StdIn], emit_buffer, 1, written_buffer, 0
	stdcall ReadFile, dword [StdIn], emit_buffer, 1, written_buffer, 0
;	stdcall ReadFile, [StdIn], emit_buffer, 1, written_buffer, 0
	pop esi
	mov eax, [emit_buffer]
	ret

align 4
os_idle:
	stdcall Sleep, 0
	ret

; ( s n <name> -- )
PROC _loadlib
	call _fzt
	push esi
	stdcall LoadLibrary, eax
	pop esi
	ret
ENDP _loadlib
PROC _unloadlib
	test eax, eax
	jz .done
	push esi
	stdcall FreeLibrary, eax
	pop esi
.done:
	drop
	ret
ENDP _unloadlib

; ( s n lib -- handle )
PROC _osfunc
	upop ebx
	lodsd
	push esi
	stdcall GetProcAddress, ebx, eax
	pop esi
	ret
ENDP _osfunc
	
;---------------------------------------------------------------------
; ANS FILE ACCESS WORDS
;---------------------------------------------------------------------
; ( -- fam )
%define os_ro  GENERIC_READ
%define os_rw  GENERIC_READ | GENERIC_WRITE
%define os_wo  GENERIC_WRITE

; ( c-addr u fam -- fileid ) \   s" file.txt" r/w create-file
PROC io_create
	mov ecx, CREATE_ALWAYS
	mov ebx, os_rw
	jmp openrw.2
ENDP io_create

PROC openr
	mov ebx, os_ro
	jmp openrw.1
ENDP openr

; ( c-addr u -- fileid ) \   s" file.txt" r/o open-file
PROC openrw
	mov ebx, os_rw
.1:
	mov ecx, OPEN_EXISTING

.2:
	mov dword [__ior], 0
	push ebx
	push ecx
	call _fzt
	pop ecx
	pop ebx
	push esi
	stdcall CreateFile, eax, ebx, FILE_SHARE_READ, 0, ecx, FILE_ATTRIBUTE_NORMAL, 0
	pop esi
	cmp eax, INVALID_HANDLE_VALUE
	jne .open.0
	push eax
	stdcall GetLastError
	mov dword [__ior], eax
	pop eax
.open.0:
	mov ebx, dword [__ior]
	or ebx, ebx
	ret
ENDP openrw

; ( fileid -- ior )
PROC io_close
	push esi
	stdcall CloseHandle, eax
	pop esi
	jmp win_return2
ENDP io_close

; ( c-addr u1 fileid -- u2 ) 
PROC io_read
	upop ecx ; [fhandle]; handle
	upop [numbytes]; how many
	push esi
	stdcall ReadFile, ecx , eax, dword [numbytes], written_buffer, 0
	pop esi
	upsh [written_buffer]
	swap
	jmp win_return2
ENDP io_read

; ( c-addr u fileid -- ior )  pad 10 file_desc @ write-file
PROC io_write
	upop ecx ; [fhandle]; handle
	upop [numbytes]; how many
;	mov [tempX], eax ; buffer
	push esi
	stdcall WriteFile, ecx, eax, dword [numbytes], written_buffer, 0
	pop esi
win_return2:
	or eax, eax
	jz .err
	xor eax, eax
.err2:	test eax, eax
	upop dword [__ior]
	ret
.err:	stdcall GetLastError
	jmp .err2
ENDP io_write

;FORTH 'GetLastError', _gle
;	dup
;	stdcall GetLastError
;NEXT _gle
; ( fileid -- ud )
PROC io_size
	push esi
	stdcall GetFileSize, eax ,0 ; [fhandle], 0
	pop esi
	ret
ENDP io_size

; ( c-addr u -- x ior )
; PROC io_status
; 	call _zt
; 	upop ebx
; 	pusha
; 	stdcall GetFileAttributes, ebx
; 	mov [tempX], eax
; 	popa
; 	upsh [tempX]
; 	xor ebx, ebx
; 	cmp [tempX], -1
; 	je .io.1
; 	inc ebx
; .io.1:
; 	upsh ebx
; 	ret
; ENDP io_status

PROC _makeexe
	drop
	ret
ENDP _makeexe
;---------------------------------------------------------------------
; ANS MEMORY ALLOCATION WORDS
;---------------------------------------------------------------------

; ( u -- a-addr )

PROC mem_alloc
;	dup
	stdcall HeapAlloc, dword [processheap], 0, eax
alloc_return:
	mov ebx, eax
alloc_return2:
	cmp ebx, 1
	sbb ebx, ebx
	mov dword [__ior], ebx
	ret
ENDP mem_alloc

; ( a-addr -- )
PROC mem_free
	stdcall HeapFree, dword [processheap], 0, eax
	mov dword [__ior], eax
	upop ebx
	ret
ENDP mem_free

; ( a-addr u -- a-addr2 )
PROC mem_realloc
	upop ebx	; EAX -> addr, EBX -> newsize
	stdcall HeapReAlloc, dword [processheap], 0, eax, ebx
	jmp alloc_return
ENDP mem_realloc

PROC os_syscall
	upsh -1
	jmp throw
ENDP os_syscall
; macro simplification from FreeForth:
;section 'rsrc' data readable resource from 'reva.res'
DATASECTION
VARNEW sigint

BSSSECTION
bss_start:
	origcp resd 1
	processheap resd 1
	emit_buffer resd 1
	written_buffer resd 1
	numbytes resd 1
	oldprotect resd 1
