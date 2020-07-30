; vim: ft=nasm 

%define EOF 4
%define linux_exit 1
%define linux_read 3
%define linux_write  4
%define linux_open  5
%define linux_close  6
%define linux_creat  8
%define linux_unlink 10
%define linux_seek64 140
%define linux_fstat64 197
%define linux_ftruncate 194 ; ftruncate64
%define linux_rename 38
%define linux_stat 106
%define linux_fsync 118
%define linux_signal 48
%define linux_ioctl 54
%define linux_sigaction 67
%define linux_sigsuspend 72
%define linux_sigpending 73
%define linux_sigreturn 119
%define linux_getpid 20
%define linux_readlink 85
%define linux_select 82
%define linux_mprotect 125
%define SEEK_SET 0
%define SEEK_CUR 1
%define SEEK_END 2
%define SIG_ERR -1
%define SIG_DFL 0
%define SIG_IGN 1

%define SIGHUP 1
%define SIGINT 2
%define SIGQUIT 3
%define SIGILL 4
%define SIGTRAP 5
%define SIGABRT 6
%define SIGBUS 7
%define SIGFPE 8
%define SIGKILL 9
%define SIGUSR1 10
%define SIGSEGV 11
%define SIGUSR2 12
%define SIGPIPE 13
%define SIGALRM 14
%define SIGTERM 15
%define O_RDONLY	     0
%define O_WRONLY	     1
%define O_RDWR		     2

%define K_RAW 0
%define K_XLATE  1
%define K_MEDIUMRAW 2
%define KDGKBMODE	0x4B44	;* gets current keyboard mode */
%define KDSKBMODE	0x4B45	;* sets current keyboard mode */
%define TCGETS 0x5401
%define TCSETSW 0x5403

%macro syscall 1-7
       ; syscalls can take a variable number of arguments, from 0 to 6.
       ; The args go in ebx, ecx, edx, esi, edi, ebp, in that order.
       ; (this is from the Linux Assembly HOWTO)
       %define _j %1
       %assign _k 1
       %rep %0-1
	%rotate 1
	%if _k == 1
		mov ebx, %1
	%elif _k == 2
		mov ecx, %1
	%elif _k == 3
		mov edx, %1
	%elif _k == 4
		mov esi, %1
	%elif _k == 5
		mov edi, %1
	%elif _k == 6
		mov ebp, %1
	%else
		%error "syscall only accepts up to 6 parameters"
	%endif
	%assign _k _k+1
       %endrep
       mov eax, _j
       int 80h
%endmacro

struc sigaction ; sact, m, f {
	action resd 1 ; sact ; void (*sa_sigaction)(int,siginfo*, void *)
	mask resb 128 ; m ; sigset_t mask;
	flags resd 1 ; f ; int flags
	restorer resd 1 ; 0 ; void (*sa_restorer)(void) 
endstruc

struc stat_t 
	.dev:	resd 2 	; + 0
	.ploni: resd 1 	; + 8; pad
	.inode:	resd 1	; +12
	.mode:	resd 1	; +16
	.nlink:	resd 1	; +20
	.uid:	resd 1	; +24
	.gid:	resd 1	; +28
	.rdev:	resd 2	; +32
	.almoni: resd 1	; +40 pad
	sb_size	resd 1	; +44
	.hsize:	resd 1	; +48
	.blksize: resd 1	; +52
	.blocks:	resd 1	; +56
	.atime:	resd 1	; +60
	.mtime:	resd 1	; +64
	.ctime:	resd 1	; +68
	.shimon: resd 6	; -- +100
endstruc

%define CODESECTION SECTION .wtext write
%define DATASECTION SECTION .wtext
%define BSSSECTION SECTION .bss

CODESECTION
EXTERN dlopen
EXTERN dlclose
EXTERN dlsym
EXTERN malloc
EXTERN free
EXTERN realloc
EXTERN tcgetattr
EXTERN tcsetattr

os_start:
	mov dword [StdOut], 1
	mov dword [StdIn], 0
	; save argc, argv
	mov eax, [esp+4]
	mov [argc], eax
	mov eax, [esp+8]
	mov [argv], eax
	mov eax, [argc]

	syscall linux_readlink, procname, app_file_name, 255
	cmp eax, -1
	jne .readlinkok
	; failed reading the link, probably we don't have permission.  Assume
	; 'argv[0]' has the correct value (woe to us if it doesn't!)
	upsh [argv]
	call _ztc
	inc eax	; include NUL
	upsh app_file_name
	swap
	call _move
.readlinkok:

	; set signal handlers
	mov ecx, 15
.again:
	push ecx
	cmp ecx, SIGINT
	je .int
	syscall linux_sigaction, ecx, new_act, 0
	jmp .next
.int:
	syscall linux_sigaction, ecx, sig_act, 0

.next:
	pop ecx
	loop .again
	ret

struc sigcontext
	sc_whatever resd 5
	sc_gs		resw 1
	sc_gsh		resw 1
	sc_fs		resw 1
	sc_fsh		resw 1
	sc_es		resw 1
	sc_esh		resw 1
	sc_ds		resw 1
	sc_dsh		resw 1
	sc_edi		resd 1
	sc_esi		resd 1
	sc_ebp		resd 1
	sc_esp		resd 1
	sc_ebx		resd 1
	sc_edx		resd 1
	sc_ecx		resd 1
	sc_eax		resd 1
	sc_trapno	resd 1
	sc_errno	resd 1
	sc_eip		resd 1
	sc_cs		resw 1
	sc_csh		resw 1
	sc_flags	resd 1
	sc_esp_at_signal	resd 1
	sc_ss		resw 1
	sc_ssh		resw 1
endstruc
align 4
reva_sig_handler:
	mov ebx, [esp+12]	; ucontext
	mov ecx, [esp+4]	; exception

	mov esi, _s1

	upsh dword 0
	upsh dword [ebx+sc_edi] ; edi
	upsh dword [ebx+sc_esi] ; esi
	upsh dword [ebx+sc_ebx] ; ebx
	upsh dword [ebx+sc_edx] ; edx
	upsh dword [ebx+sc_ecx] ; ecx
	upsh dword [ebx+sc_eax] ; eax
	upsh dword [ebx+sc_ebp] ; ebp
	upsh dword [ebx+sc_esp] ; esp
	upsh dword [ebx+sc_eip] ; eip
	upsh ecx ; exception

	mov [ebx+sc_eax], eax 	; exception -> EAX
	mov [ebx+sc_esi], esi 	; data stack

	mov eax, [_rp0]
	mov [ebx+sc_esp], eax 	; return stack
	mov [ebx+sc_eip], dword trampoline ; EIP

	ret
	
align 4
reva_int_handler:
	push ebp
	mov ebp, esp

	sub esp, 8
	mov esi, esp
	sub esp, 50

	DEFERCALL ctrlc_handler

	mov esp, ebp
	pop ebp
	ret

align 4
os_type:
        upop edx                ;
        mov ecx, eax
        or edx,edx              ; Is the count zero?
        jz .done                ; If so, we can exit
	syscall linux_write, 1, ecx, edx
.done:
        drop
	ret

os_emit:
	lea ecx, [esp-4]
	mov [ecx], eax
	syscall linux_write, 1, ecx, 1
.done:
	drop
	ret


align 4
os_key:
	dup
	push dword 0
	syscall linux_read, 0, esp, 1
	dec eax
	pop eax
	jnz .bad

	ret
.bad:
	mov eax,-1
	ret

align 4
os_bye:
	syscall linux_exit, eax

PROC os_syscall
       ; syscalls can take a variable number of arguments, from 0 to 6.
       ; The args go in ebx, ecx, edx, esi, edi, ebp, in that order.
       ; (this is from the Linux Assembly HOWTO)

       ; At entry, the Forth stack holds args, argcount, syscall-number

       ; validate argcount, if > 6 return without changing the stack
           mov ecx, [esi]          ; ecx = argcount
           cmp ecx, 6
           ja .ret

           lea edi, [esi+4 +4*ecx] ; compute data stack adjustment
           push edi                ; save it
           push eax                ; save syscall-number
           mov eax, esi            ; esi modified when argcount>3
           lea ecx, [.6 +4*ecx]    ; i.e. .0-4*argcount
           jmp ecx

.6:        mov ebp, [eax+24]       ; 3-bytes instruction
           nop                     ; 1-byte nop padding
.5:        mov edi, [eax+20]
           nop
.4:        mov esi, [eax+16]
           nop
.3:        mov edx, [eax+12]
           nop
.2:        mov ecx, [eax+8]
           nop
.1:        mov ebx, [eax+4]
           nop
.0:        pop eax                 ; restore syscall-number
           int 80h                 ; eax = syscall result
           pop esi                 ; restore adjusted data stack
.ret:      ret
ENDP os_syscall


; syscall interface ends here
;---------------------------------------------------------------------
; ANS FILE ACCESS WORDS
;---------------------------------------------------------------------

; EAX is system call to make
; parms are EBX, ECX, EDX, ESI, EDI
; retval in EAX, negative on failure

; ior is 0 if succeeded.
%define linux int $80 

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
	mov ebx, eax	; filename
;	mov edx, 666o
;	xor edx, edx	; mode
	mov eax, linux_open
call_linux:
	linux
call_linux_return: ; convert value in EAX into 'ior'
	mov ebx, eax	
call_linux_return2: ; convert value in EBX into 'ior'
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
	mov ebx, eax
	mov eax, linux_close
call_linux2: ; convert value in EAX into 'ior'
	linux
	upop ebx
	jmp call_linux_return2
ENDP io_close

; ( c-addr u -- fileid ior ) \   s" file.txt" r/w create-file
PROC io_create
	call _fzt
	mov ebx, eax	; filename
	mov ecx, 666o
	mov edx, 1000o
	mov eax, linux_creat
	jmp call_linux
ENDP io_create

; ( c-addr u1 fileid -- n )  pad 10 file_desc @ read-file
; sys_read(fd, buf, count)
PROC io_read
	push eax	; fileid
	drop
	mov edx,eax		; count
	drop
	mov ecx	,eax	; count
	pop ebx		; fileid
	mov eax, linux_read
	jmp call_linux
ENDP io_read

; ( c-addr u fileid -- ior )  pad 10 file_desc @ write-file
PROC io_write
	push eax	; fileid
	drop
	mov edx,eax		; count
	drop
	mov ecx	,eax	; count
	pop ebx		; fileid
	mov eax, linux_write
	jmp call_linux2
ENDP io_write

; ( c-addr u -- x ior )
;PROC io_status
;	call _zt
;	push eax 
;	drop
;	pop ebx
;	mov ecx, stat_buf
;	mov eax, linux_stat
;	call call_linux
;	upsh dword [stat_buf.mode]	; third element is ior
;	swap
;	ret
;ENDP io_status

; ( fileid -- ud )
; fstat64(fd, fstat64)
PROC io_size
;	dup
	mov ebx, eax
	mov ecx, stat_buf
	mov eax, linux_fstat64
	linux
	mov eax, dword [stat_buf + sb_size]
;	mov [esi], eax
;	mov eax, dword [stat_buf.hsize]
	ret
ENDP io_size


;---------------------------------------------------------------------
; ANS MEMORY ALLOCATION WORDS
;---------------------------------------------------------------------
; For now I will use the libc routines.
PROC mem_alloc
	push eax	
	call malloc
	add esp, 4
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
	push eax
	call free
	add esp, 4
	xor eax, eax
	upop dword [__ior]
	ret
ENDP mem_free

; ( a-addr u -- a-addr2 )
PROC mem_realloc
	push eax
	drop
	push eax
	call realloc
	add esp, 8
	jmp mem_alloc.0
ENDP mem_realloc

; ( s n <name> -- )
PROC _loadlib
	call _fzt
	; load the library:
	push 1 | 0x100	; RTLD_LAZY | RTLD_GLOBAL
	push eax	; library name
	call dlopen
	add esp, 8
	ret
ENDP _loadlib
PROC _unloadlib
	test eax, eax 
	jz .done
	push eax	; library handle
	call dlclose
	add esp, 4
.done:
	drop
	ret
ENDP _unloadlib

; ( s n lib -- handle )
PROC _osfunc
	upop ebx	; EBX is handle
	lodsd		; drop count, EAX is function name
	push esi
	push eax	; symbol
	push ebx	; libhandle
	call dlsym
	add esp, 8
	pop esi
	ret
ENDP _osfunc
PROC _makeexe
	; chmod = oscall 15
	mov ecx, 0755o
	mov ebx, eax
	mov eax, 15
	linux
	drop
	ret
ENDP _makeexe




DATASECTION
SA_SIGINFO        equ 0x00000004 ; use sa_sigaction instead of sa_handler
sig_act: istruc sigaction ;reva_sig_handler, 0, SA_SIGINFO
	dd reva_int_handler
	dd 0
	dd SA_SIGINFO
	dd 0
	iend
new_act: istruc sigaction ;reva_sig_handler, 0, SA_SIGINFO
	dd reva_sig_handler
	dd 0
	dd SA_SIGINFO
	dd 0
	iend
stat_buf: istruc stat_t
	iend
align 4
procname db '/proc/self/exe',0 ; actually includes the / from 'exe', so don't separate them!
align 4

BSSSECTION
bss_start:
