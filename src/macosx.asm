; vim: ft=nasm 

%define EOF 4
%define FUNCALIGN align 16
%define ALTSIZE 16000

%define SEEK_SET 0
%define SEEK_CUR 1
%define SEEK_END 2

%define SIG_ERR -1
%define SIG_DFL 0
%define SIG_IGN 1
%define SIG_HOLD 5

%define SIGHUP 1
%define SIGINT 2
%define SIGQUIT 3
%define SIGILL 4
%define SIGTRAP 5
%define SIGABRT 6

%define SIGEMT 7

%define SIGFPE 8
%define SIGKILL 9
%define SIGBUS 10
%define SIGSEGV 11
%define SIGSYS 12
%define SIGPIPE 13
%define SIGALRM 14
%define SIGTERM 15

%define O_RDONLY	     0
%define O_WRONLY	     1
%define O_RDWR		     2

SA_SIGINFO     equ 0x0040 ; use sa_sigaction instead of sa_handler
SA_RESTART     equ 0x0002 ; restart system calls which were interrupted

struc sigaction ; sact, m, f {
	action resd 1 ; sact ; void (*sa_sigaction)(int,siginfo*, void *)
	mask resd 1 ; m ; sigset_t mask;
	flags resd 1 ; f ; int flags
endstruc

struc sigaltstack
	ss_sp resd 1
	ss_size resd 1
	ss_flags resd 1
endstruc

struc siginfo
	si_signo	resd 1
	si_errno	resd 1 
	si_code		resd 1
	si_pid		resd 1
	si_uid		resd 1
	si_status	resd 1
	si_addr		resd 1 ;; fault address
	; etc value, band, pad[7]
endstruc

struc sigcontext
	sc_pad		resd 3
	
	sc_eax		resd 1
	sc_ebx		resd 1
	sc_ecx		resd 1
	sc_edx		resd 1
	sc_edi		resd 1
	sc_esi		resd 1
	sc_ebp		resd 1
	sc_esp		resd 1
	sc_ss		resd 1
	sc_flags	resd 1
	sc_eip		resd 1
	sc_cs		resd 1
	sc_ds		resd 1
	sc_es		resd 1
	sc_fs		resd 1
	sc_gs		resd 1
endstruc


struc stat_t 
	.dev:	resd 1 	; + 0
	.inode:	resd 1	; +12
	.mode:	resd 1	; +16
	.nlink:	resd 1	; +20
	.uid:	resd 1	; +24
	.gid:	resd 1	; +28
	.rdev:	resd 2	; +32
	.times: resd 3	; +40 pad
	sb_size	resd 1	; +44
	.hsize:	resd 1	; +48
	.blksize: resd 1	; +52
	.blocks:	resd 1	; +56
	.atime:	resd 1	; +60
	.mtime:	resd 1	; +64
	.ctime:	resd 1	; +68
	.shimon: resd 6	; -- +100
endstruc

%define CODESECTION SECTION .text align=16
%define DATASECTION SECTION .text 
%define BSSSECTION SECTION .bss

CODESECTION
EXTERN _exit
EXTERN _dlopen
EXTERN _dlclose
EXTERN _dlsym
EXTERN _malloc
EXTERN _free
EXTERN _realloc
EXTERN _open
EXTERN _close
EXTERN _creat
EXTERN _read
EXTERN _write
EXTERN _fstat
EXTERN _chmod
EXTERN _getpid
EXTERN _sigaction
EXTERN _mprotect
EXTERN _realpath
EXTERN __NSGetExecutablePath

os_start:
	ccall _mprotect, os_start, (data_end-os_start),  7

	push eax
	call .me
.me:	pop eax
	neg eax
	mov dword [codeoff], eax
	pop eax

;	upsh 'X'
;	call os_emit
	mov dword [StdOut], 1
	mov dword [StdIn], 0
	; save argc, argv
	mov eax, [esp+4]
	mov [argc], eax
	mov eax, [esp+8]
	mov [argv], eax
	mov eax, [argc]
;	mov eax, [esp+4*eax+12]
;	mov [environ], eax
	; Now, let's get the pid
	ccall _getpid
;	mov eax, osx_getpid
;	int 80h
	mov [ourpid], eax

; use NSGetExecutablePath to find our name...
	mov dword [temp_temp], 256
	ccall __NSGetExecutablePath , app_file_name, temp_temp
	xor eax, eax
	jnz .argv
	mov eax, dword [temp_temp]
	lea eax, [eax + app_file_name]
	mov byte [eax], 0
	; try to resolve a link:
	ccall _realpath, app_file_name, resolve_link
	cmp eax, 0
	je .readlinkok
	; resolve_link, eax is real file name: copy it over
	call _ztc
	push eax
	mov ecx, eax
	mov edi, app_file_name
	mov edx, resolve_link
	call _move.a
	pop eax
	lea eax, [eax + app_file_name]
	mov byte [eax], 0
	jmp .readlinkok

	; Assume 'argv[0]' has the correct value (woe to us if it doesn't!)
.argv:
	upsh [argv]
	call _ztc
	inc eax	; include NUL
	upsh app_file_name
	swap
	call _move

.readlinkok:

	mov ecx, 15
.again:
	push ecx
	cmp ecx, SIGINT
	je .int
	ccall _sigaction, ecx, new_act, 0
	jmp .next
.int:
	ccall _sigaction, ecx, sig_act, 0

.next:
	pop ecx
	loop .again

	ret

FUNCALIGN
reva_int_handler:
	pusha
	push ebp
	mov ebp, esp

	sub esp, 8
	mov esi, esp
	sub esp, 40

	DEFERCALL ctrlc_handler

	mov esp, ebp
	pop ebp
	popa
	ret

FUNCALIGN
reva_sig_handler:
	push ebp
	mov ebp, esp
	pusha

	mov ebx, [ebp+16]	; ucontext
	mov ecx, [ebp+8]	; exception

	mov esi, _s1

	lea ebx, [ebx+28]
	mov ebx, [ebx]

;	upsh ebx
;	call exception
;	call os_bye

	upsh dword 0
	upsh [ebx+sc_edi] ; edi
	upsh [ebx+sc_esi] ; esi
	upsh [ebx+sc_ebx] ; ebx
	upsh [ebx+sc_edx] ; edx
	upsh [ebx+sc_ecx] ; ecx
	upsh [ebx+sc_eax] ; eax
	upsh [ebx+sc_ebp] ; ebp
	upsh [ebx+sc_esp] ; esp
	upsh [ebx+sc_eip] ; eip
	upsh ecx 	; exception

	;mov [ebx+sc_eax], eax 	; exception -> EAX
	;mov eax, exception
	;mov [ebx+sc_eip], eax
	;mov [ebx+sc_esi], esi ; eip
	;mov eax, [_rp0]
	;mov [ebx+sc_esp], eax 	; return stack

	mov [ebx+sc_eax], eax 	; exception -> EAX
	mov [ebx+sc_esi], esi 	; data stack

	mov eax, [_rp0]
	mov [ebx+sc_esp], eax 	; return stack
	mov [ebx+sc_eip], dword trampoline ; EIP

	popa
	mov esp, ebp
	pop ebp
	ret
	
FUNCALIGN
os_type:
        upop ecx                ;
	jecxz .done

	ccall _write, 1, eax, ecx
.done:
        drop
	ret

FUNCALIGN
os_emit:
	mov [emit_buf], eax
	ccall _write, 1, emit_buf, 1
.done:
	drop
	ret

FUNCALIGN
os_key:
	dup
	mov [emit_buf], dword 0
	ccall _read, 0, emit_buf, 1
	dec eax
	mov eax, [emit_buf]
	jnz .bad

	ret
.bad:
	mov eax,-1
	ret
FUNCALIGN
os_bye:
	ccall _exit, eax

PROC os_syscall
	upsh -1
	jmp throw
ENDP os_syscall


; syscall interface ends here
;---------------------------------------------------------------------
; ANS FILE ACCESS WORDS
;---------------------------------------------------------------------

PROC openrw  ;( a n -- filied )
	mov ecx, O_RDWR
	jmp io_open
ENDP openrw

PROC openr ; ( a n -- fileid )
	mov ecx, O_RDONLY
	; fall through
	
; sys_open(filename, flags, mode) --> handle
; ( c-addr u fam -- fileid ior ) \   s" file.txt" r/o open-file
;	upop ecx	; flags O_RDONLY etc.
io_open:
	push ecx
	call _fzt
	pop ecx
;	mov ebx, eax	; filename
;	mov edx, 666o
;	xor edx, edx	; mode
;	mov eax, osx_open
;	macos osx_open, eax, ecx
	ccall _open, eax, ecx
;call_linux:
;	linux
osx_return: ; convert value in EAX into 'ior'
	mov ebx, eax	
osx_return2: ; convert value in EBX into 'ior'
	; ebx<0 --> 1 else 0
	test ebx, ebx
	js .end
	xor ebx, ebx
	jmp .end
.end:	mov dword [__ior], ebx
	test ebx, ebx	; jnz is error
	ret
ENDP openr

; ( fileid -- )
PROC io_close
;	mov ebx, eax
	;mov eax, osx_close
	;macos osx_close, eax
	ccall _close, eax

;call_osx2: ; convert value in EAX into 'ior'
;	linux
	upop ebx
	jmp osx_return2
ENDP io_close

; ( c-addr u -- fileid ior ) \   s" file.txt" r/w create-file
PROC io_create
	call _fzt
;	mov ebx, eax	; filename
;	mov ecx, 666o
;	mov edx, 1000o
;	mov eax, osx_creat
;	macos osx_creat, eax, 666o, 1000o
	ccall _creat, eax, 666o, 1000o
	jmp osx_return
;	jmp call_linux
ENDP io_create

; ( c-addr u1 fileid -- n )  pad 10 file_desc @ read-file
; sys_read(fd, buf, count)
PROC io_read
	mov edx, eax	; fileid
	drop
	mov ecx, eax	; count
	drop
;	mov ebx, eax	; addr
	
;	macos osx_read, edx, ecx, eax
	ccall _read, edx, eax, ecx
	jmp osx_return
ENDP io_read

; ( c-addr u fileid -- ior )  pad 10 file_desc @ write-file
PROC io_write
	mov edx, eax	;fileid
	drop
	mov ecx,eax	; count
	drop
;	mov ebx	,eax	; count
;	macos osx_write, edx, ecx, eax
	ccall _write, edx, eax ,ecx
	upop ebx
;	mov eax, osx_write
	jmp osx_return2
ENDP io_write


; ( fileid -- ud )
; fstat64(fd, fstat64)
PROC io_size
;	dup
;	mov ebx, eax
;	mov ecx, stat_buf
;	mov eax, osx_fstat64
;	macos osx_fstat64, ebx, stat_buf
	ccall _fstat, eax, stat_buf
;	linux
	mov ebx, stat_buf
	mov eax, dword [stat_buf + 48]
;	mov [esi], eax
;	mov eax, dword [stat_buf.hsize]
	ret
ENDP io_size


;---------------------------------------------------------------------
; ANS MEMORY ALLOCATION WORDS
;---------------------------------------------------------------------
; For now I will use the libc routines.
PROC mem_alloc
	or eax ,eax
	jz .0
;	push eax	
;	call malloc
	ccall _malloc,eax
;	add esp, 4
.0:
	mov ebx, eax
	sub ebx, ebx
	sbb ebx, 0
	mov dword [__ior], ebx
	;u
	;upsh 0
	;cmp ebx, 0
	;jnz .1
;	inc eax
;.1:	upop [__ior]
	ret
ENDP mem_alloc

; ( a-addr -- )
PROC mem_free
	or eax ,eax
	jz .0
;	push eax
;	call free
;	add esp, 4
	ccall _free,eax
	xor eax, eax
.0:
	upop dword [__ior]
	ret
ENDP mem_free

; ( a-addr u -- a-addr2 )
PROC mem_realloc
	mov ebx ,eax
	drop
	ccall _realloc, eax, ebx
	;push eax
	;drop
	;push eax
	;call realloc
	;add esp, 8
	jmp mem_alloc.0
ENDP mem_realloc

; ( s n <name> -- )
PROC _loadlib
	call _fzt
	; load the library:
;	push 1 | 0x9	; RTLD_LAZY | RTLD_GLOBAL
;	push eax	; library name
;	call dlopen
;	add esp, 8
	ccall _dlopen, eax, (1 | 8)
	ret
ENDP _loadlib
PROC _unloadlib
	test eax, eax 
	jz .done
	ccall _dlclose, eax
;	push eax	; library handle
;	call dlclose
;	add esp, 4
.done:
	drop
	ret
ENDP _unloadlib

; ( s n lib -- handle )
PROC _osfunc
	upop ebx	; EBX is handle
	lodsd		; drop count, EAX is function name
	ccall _dlsym, ebx, eax
	ret
ENDP _osfunc

_makeexe:
	ccall _chmod, eax, 0755o
	drop
	ret




DATASECTION

codeoff dd 0
sig_act: istruc sigaction ;reva_sig_handler, 0, SA_SIGINFO
	at action, dd reva_int_handler
	at mask, dd 0
	at flags, dd SA_SIGINFO ;| SA_RESTART
	iend
new_act: istruc sigaction ;reva_sig_handler, 0, SA_SIGINFO
	at action, dd reva_sig_handler
	at mask, dd 0
	at flags, dd SA_SIGINFO ;| SA_RESTART
;	at restorer, dd 0
	iend
stat_buf: istruc stat_t
	iend

saltstack: istruc sigaltstack
	at ss_sp, dd altstack
	at ss_size, dd ALTSIZE
	at ss_flags, dd 0
	iend

BSSSECTION
ourpid resd 1
temp_temp resd 1
emit_buf resd 1
saveesp resd 1
altstack resb ALTSIZE
resolve_link resb 256
bss_start:
