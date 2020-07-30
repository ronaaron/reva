
; -----------------------------------------------
;    Application: sha1 hasher v0.02 - FASM example
;       Language: Assembly (FASM syntax)
;         Author: axm
;    Description: simple and easy sha1 implementation in asm [public domain].
;  Last Modifier:
;           Date: Jul. 25, 2003
; -----------------------------------------------
; * dialog source template taken from CodeRace by pelaillo,thanks to him
; -----------------------------------------------

format PE GUI 4.0

include '%include%\win32a.inc'


MAXSIZE = 600h

section '.code'  code readable executable

    invoke GetModuleHandle,0
    mov [hinstance],eax
    invoke DialogBoxParam,eax,IDD_MAIN,NULL,main_dlg_proc,NULL
  terminate:
    invoke ExitProcess,eax

proc main_dlg_proc,.hwnd,.umsg,.wparam,.lparam
    ps PAINTSTRUCT
    lpRect RECT
    enter
    push esi edi
    mov eax,[.umsg]
    cmp eax, WM_INITDIALOG
    je .wm_initdialog
    cmp eax, WM_MOUSEMOVE
    je .wm_mousemove
    cmp eax, WM_LBUTTONDOWN
    je .wm_ldown
    cmp eax, WM_LBUTTONUP
    je .wm_lup
    cmp eax,WM_COMMAND
    je .wm_command
    cmp eax,WM_CLOSE
    je .wm_close
    jmp .finish
  .wm_initdialog:
    invoke SetDlgItemText,[.hwnd],IDC_FIELD,szTest
    mov eax,IDC_FIELD
    jmp .en_change
    jmp .finish
  .en_change:
    cmp eax,IDC_FIELD
    jne .finish
    invoke GetDlgItemText,[.hwnd],IDC_FIELD,buf,MAXSIZE
    mov edi,buf
    mov [hLen],eax
call  Generatestringhash
    invoke SetDlgItemText,[.hwnd],IDC_RESHOME,serial
    jmp .finish
.wm_mousemove:
;     .if KeyDown == TRUE
cmp [KeyDown], TRUE
jne .flo
 lea eax, [lpRect]
	invoke GetWindowRect,[.hwnd],eax;addr lpRect
	mov eax,[.lparam]
	and eax,0FFFFh
	sub eax, [lMouseX]
	add [lpRect.left], eax
	mov eax,[.lparam]
	shr eax,16
	sub eax, [lMouseY]
	add [lpRect.top], eax
	invoke SetWindowPos,[.hwnd], NULL,[lpRect.left],[lpRect.top], NULL, NULL,SWP_NOZORDER+SWP_NOSIZE
;      .endif
.flo:
    jmp .finish

.wm_ldown:
	mov eax,[.lparam]
	shr eax,16
	mov [lMouseY], eax
	mov eax, [.lparam]
	and eax, 0FFFFh
	mov [lMouseX], eax
	mov [KeyDown], TRUE
	invoke SetCapture, [.hwnd]
    jmp .finish
.wm_lup:
	mov [KeyDown], FALSE
	invoke ReleaseCapture
    jmp .finish
.wm_filez: ;browse
;;;;;;;;;;;;;;;;;;;;;;;open file
     mov     [ofn.lStructSize],sizeof.OPENFILENAME
     mov     eax,[.hwnd]
     mov     [ofn.hwndOwner],eax
     mov     eax,[hinstance]
     mov     [ofn.hInstance],eax
     mov     [ofn.lpstrFilter],asm_filter
     mov     [ofn.lpstrFile],szFileName
     mov     [ofn.nMaxFile],MAXSIZE
     mov     [ofn.Flags],OFN_FILEMUSTEXIST+OFN_PATHMUSTEXIST+OFN_LONGNAMES+OFN_EXPLORER
     invoke  GetOpenFileName,ofn
     invoke  CreateFile,szFileName,GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_ARCHIVE, 0
     mov    [hFile],eax
     cmp    eax,INVALID_HANDLE_VALUE
     je     .error
  invoke SetDlgItemText,[.hwnd],IDC_RESVISITOR,szFileName
     invoke CreateFileMapping, [hFile], 0, PAGE_READONLY, 0, 0, 0
     mov [hMapFile], eax
     invoke MapViewOfFile, [hMapFile], FILE_MAP_READ, 0, 0, 0
     mov [pMemory], eax
     invoke GetFileSize, [hFile],  0
     mov [dwFileSize], eax
     mov ebx, [pMemory]
     mov ecx, [dwFileSize]
;;;;;;;;;;;;;;;;;;;;;;;;;;
 invoke GetTickCount
 mov [Tick],eax
 call Generatefilehash	  ;hash file
  invoke GetTickCount
  sub eax,[Tick]
     cinvoke wsprintf,dwValue ,_value,eax
     invoke SetDlgItemText,[.hwnd],IDC_HOME,dwValue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     invoke UnmapViewOfFile, [pMemory]
     invoke CloseHandle, [hMapFile]
     invoke CloseHandle, [hFile]
     invoke SetDlgItemText,[.hwnd],IDC_VISITOR,serial2
.error:
     jmp .finish
  .wm_about:
     invoke DialogBoxParam,[hinstance],IDD_ABOUT,NULL,about_dlg_proc,NULL
     jmp .finish
  .wm_command:
     mov eax,[.wparam]
     mov edx,eax
     shr edx,16
     and eax,0FFFFh
     cmp edx,EN_CHANGE
     je .en_change
     cmp eax,IDC_FILEZ
     je .wm_filez
     cmp eax,IDC_ABOUT
     je .wm_about
     cmp eax,IDOK
     je .wm_close
     cmp eax,IDCANCEL
     jne .finish
   .wm_close:
     invoke EndDialog,[.hwnd],eax
   .finish:
     xor eax,eax
   .exit:
     pop edi esi
     return

proc about_dlg_proc,.hwnd,.umsg,.wparam,.lparam
    enter
    push esi edi
    mov eax,[.umsg]
    cmp eax, WM_INITDIALOG
    je .wm_initdialog
    cmp eax,WM_COMMAND
    je .wm_command
    cmp eax,WM_CLOSE
    je .wm_close
    jmp .finish
  .wm_initdialog:
    invoke SendDlgItemMessage,[.hwnd],IDC_DESC,WM_SETTEXT,0,szDesc
    jmp .finish
  .wm_command:
    cmp [.wparam],IDOK
    je .wm_close
    cmp [.wparam],IDCANCEL
    jne .finish
  .wm_close:
    invoke EndDialog,[.hwnd],eax
  .finish:
    xor eax,eax
  .exit:
    pop edi esi
    return



Generatestringhash:

	push	  ebp
	mov	  ebp,esp
	add	  esp,-160
	push	  esi
	push	  edi

	mov	  esi, ecfkdeia
	lea	  edi, [ebp-100]
	mov	  ecx,25
	rep   movsd
	push	   _context
	call	  _SHA1Init	 ;     SHA1Init(&context);
	pop	  ecx
	push	  [hLen]
	mov	  eax,	buf; userinput?
	push	  eax
	push	   _context
	call	  _SHA1Update	 ;     SHA1Update(&context, Name, strlen(Name))
	add	  esp,12
	push	   _context
	mov	  edx, _digest
	push	  edx
	call	  _SHA1Final	 ;     SHA1Final(digest, &context);
	add	  esp,8
nop

hex2asc:
	mov edi, serial
	mov esi, _digest
	mov ecx,20;16
	xor eax,eax
h2a_1:
	lodsb
	push eax
	and eax,15
	mov al,[eax+hextab]
	mov bl,al
	pop eax
	shr eax,4
	mov al,[eax+hextab]
	stosb
	mov al,bl
	stosb
	loop h2a_1

	pop	  edi
	pop	  esi
	mov	  esp,ebp
	pop	  ebp
	ret

Generatefilehash:

	push	  ebp
	mov	  ebp,esp
	add	  esp,-160
	push	  esi
	push	  edi
	mov	  esi, ecfkdeia
	lea	  edi, [ebp-100]
	mov	  ecx,25
	rep   movsd
	push	   _context
	call	  _SHA1Init	 ;     SHA1Init(&context);
	pop	  ecx
	push	  [dwFileSize]
	push	   [pMemory]
	push	   _context
	call	  _SHA1Update	 ;     SHA1Update(&context, Name, strlen(Name))
	add	  esp,12
	push	   _context
	mov	  edx, _digest
	push	  edx
	call	  _SHA1Final	 ;     SHA1Final(digest, &context);
	add	  esp,8

hex2asc2:
	mov edi, serial2
	mov esi, _digest
	mov ecx,20;16
	xor eax,eax
h2a_2:
	lodsb
	push eax
	and eax,15
	mov al,[eax+hextab]
	mov bl,al
	pop eax
	shr eax,4
	mov al,[eax+hextab]
	stosb
	mov al,bl
	stosb
	loop h2a_2

	pop	  edi
	pop	  esi
	mov	  esp,ebp
	pop	  ebp
	ret


include 'sha1.inc'



section '.data' data readable writeable

	szTest	db 'Servez à ce monsieur,le vieux petit juge blond '
		db 'assis au fond,une bière hollandaise '
		db 'et des kiwis,parce qu il y tient.',0
;       szHome  db 'str_ucase',0
	szDesc	db 'This program computes sha1 hash of text or file. ',13,10

		db '<<This code is for the pleasure of programming in FASM.',13,10
		db 'Use it as you wish and under your own risk, but '
		db 'please do not change this advice.>>',13,10
		db 'pelaillo, 2002',0

ofn OPENFILENAME
hextab	db '0123456789ABCDEF'
s@ db 080H, 00H
serialhex   dd 0

ecfkdeia db 0,99
hLen		dd ?
hFile		dd ?
hMapFile	dd ?
pMemory 	dd ?
dwFileSize	dd ?

Tick		dd ?
lMouseX 	dd ?
lMouseY 	dd ?
KeyDown 	dd 0
userinput rb MAXSIZE;  db 64 dup (?)
serial	  rb MAXSIZE; db 128 dup (?)
serial2   rb MAXSIZE; db 128 dup (?)
_digest   rb MAXSIZE; db 128 dup (?)
_context  rb MAXSIZE;   db 92 dup (?)
mobkdeia rb MAXSIZE;   db 64 dup (?)

	hinstance dd 0
	profile_func dd 0
	hbrush dd 0
	oldwndproc dd 0
	msg  MSG
	buf  rb MAXSIZE

  szFileName	    rb 360

 _value      db '%lu',0
 dwValue     dd ?
  tttt	     db '',0
  asm_filter db 'All files',0,'*.*',0
	     db 0

section '.idata' import data readable writeable

  library kernel32,'kernel32.dll',\
	  user32,'user32.dll',\
	  comdlg32,'comdlg32.dll',\
	  msvcrt,'msvcrt.dll'

  import kernel32,\
	 CloseHandle,'CloseHandle',\
	 CreateFile,'CreateFileA',\
	 CreateFileMapping,'CreateFileMappingA',\
	 ExitProcess,'ExitProcess',\
	 GetFileSize,'GetFileSize',\
	 GetModuleHandle,'GetModuleHandleA',\
	 GetTickCount,'GetTickCount',\
	 MapViewOfFile,'MapViewOfFile',\
	 UnmapViewOfFile,'UnmapViewOfFile'

  import user32,\
	 DialogBoxParam,'DialogBoxParamA',\
	 EndDialog,'EndDialog',\
	 GetDlgItemText,'GetDlgItemTextA',\
	 GetWindowRect,'GetWindowRect',\
	 ReleaseCapture,'ReleaseCapture',\
	 SendDlgItemMessage,'SendDlgItemMessageA',\
	 SetCapture,'SetCapture',\
	 SetDlgItemInt,'SetDlgItemInt',\
	 SetDlgItemText,'SetDlgItemTextA',\
	 SetWindowPos,'SetWindowPos',\
	 wsprintf,'wsprintfA'

  import comdlg32,\
	 GetOpenFileName,'GetOpenFileNameA'

  import msvcrt,\
	 memcpy,'memcpy',\
	 memset,'memset'

section '.rsrc' resource data readable discardable

IDD_MAIN   = 100
IDD_ABOUT  = 200
IDB_ABOUT  = 10

  directory	RT_ACCELERATOR,accelerators,\
		RT_DIALOG,dialogs,\
		RT_BITMAP,bitmaps,\
		RT_ICON,icons,\
		RT_GROUP_ICON,group_icons,\
		RT_VERSION,versions
  resource versions,\
	   1,LANG_NEUTRAL,version_info

  resource accelerators,\
	   IDR_ACCELERATOR,LANG_ENGLISH+SUBLANG_DEFAULT,acc_keys
  resource bitmaps,\
	   IDB_ABOUT,LANG_NEUTRAL,about_bmp
  resource icons,\
	   1,LANG_NEUTRAL,icon_data
  resource group_icons,\
	   IDI_ICON,LANG_NEUTRAL,main_icon

  resource dialogs,\
    IDD_MAIN,LANG_ENGLISH+SUBLANG_DEFAULT,dlg_main,\
	     IDD_ABOUT,LANG_NEUTRAL+SUBLANG_DEFAULT,dlg_about

     IDR_ACCELERATOR = 100
     IDM_EXIT	     = 100
     IDM_CUT	     = 101
     IDM_COPY	     = 102
     IDM_PASTE	     = 103
     IDM_ABOUT	     = 104
  accelerator acc_keys, \
    FVIRTKEY+FNOINVERT+FALT,	 'X', IDM_EXIT, \
    FVIRTKEY+FNOINVERT+FCONTROL, 'A', IDM_ABOUT, \
    FVIRTKEY+FNOINVERT+FCONTROL, 'X', IDM_CUT, \
    FVIRTKEY+FNOINVERT+FCONTROL, 'C', IDM_COPY, \
    FVIRTKEY+FNOINVERT+FCONTROL, 'V', IDM_PASTE


	IDC_HOME       = 1000
	IDC_VISITOR    = 1001
	IDC_NOMHOME    = 1002
	IDC_NOMVISITOR = 1003
	IDC_RESHOME    = 1004
	IDC_RESVISITOR = 1005
	IDC_ABOUT      = 1006
	IDC_FIELD      = 1007
	IDC_FILEZ      = 1008

 dialog dlg_main, 'Sha1 hasher (Powered by FASM v1.48)',50,50,240,150,DS_CENTER +WS_CAPTION+WS_POPUP+WS_SYSMENU+DS_MODALFRAME
    dialogitem 'EDIT',	'',IDC_FIELD,2,16,236,24,WS_VISIBLE+WS_TABSTOP+WS_BORDER+ES_MULTILINE+ES_AUTOVSCROLL+WS_VSCROLL
    dialogitem 'EDIT',	'',IDC_HOME,86,120,60,12,WS_VISIBLE+WS_BORDER+WS_TABSTOP+ES_AUTOHSCROLL+ES_READONLY+ES_RIGHT
    dialogitem 'EDIT',	'',IDC_RESHOME,2,44,228,14,WS_VISIBLE+WS_BORDER+WS_TABSTOP+ES_AUTOHSCROLL+ES_READONLY
    dialogitem 'EDIT',	'',IDC_VISITOR,2, 103, 228, 14 ,WS_VISIBLE+WS_BORDER+WS_TABSTOP+ES_AUTOHSCROLL+ES_READONLY;+ES_RIGHT
    dialogitem 'EDIT',	'',IDC_RESVISITOR,2, 74, 198, 24,WS_VISIBLE+WS_TABSTOP+WS_BORDER+ES_READONLY+ES_MULTILINE+ES_AUTOVSCROLL+WS_VSCROLL
    dialogitem 'BUTTON','&Ok',IDOK,162,131,43,16,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON
    dialogitem 'BUTTON','&Close',IDCANCEL,82,133,43,16,WS_VISIBLE+WS_TABSTOP+BS_PUSHBUTTON
    dialogitem 'BUTTON','&About',IDC_ABOUT,2,133,43,16,WS_VISIBLE+WS_TABSTOP+BS_PUSHBUTTON
    dialogitem 'BUTTON','&Browse',IDC_FILEZ,201, 78, 38, 16,WS_VISIBLE+WS_TABSTOP+BS_PUSHBUTTON
    dialogitem 'STATIC','&Hash string:',-1,4,4,148,8,WS_VISIBLE
    dialogitem 'STATIC','&Hash file:',-1,4,62,148,8,WS_VISIBLE
    dialogitem 'STATIC','Time (milliseconds):',-1,4,120,81,8,WS_VISIBLE
 enddialog

	IDC_LIST   = 2001
	IDC_TITLE  = 2002
	IDC_DESC   = 2003
	IDI_ICON   = 2004

 dialog dlg_about,  'About this program...',70,60,180,84,DS_CENTER +WS_CAPTION+WS_POPUP+WS_SYSMENU+DS_MODALFRAME
    dialogitem 'STATIC',IDB_ABOUT,-1,1,1,40,100,WS_VISIBLE+SS_BITMAP
    dialogitem 'EDIT','SHA1 Hasher (Powered by FASM v1.48)',IDC_TITLE,30,2,146,10,WS_VISIBLE+WS_TABSTOP+ES_READONLY
    dialogitem 'EDIT','',IDC_DESC,30,12,146,50,WS_VISIBLE+WS_BORDER+WS_TABSTOP+ES_READONLY+ES_MULTILINE+ES_AUTOVSCROLL+WS_VSCROLL
    dialogitem 'BUTTON','&Ok',IDOK,118,66,58,16,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON
 enddialog

  bitmap about_bmp,'res\about.bmp'
  icon main_icon, icon_data, 'res\main.ico'

 version version_info,VOS__WINDOWS32,VFT_APP,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
	  'FileDescription','Simple example in FASM',\
	  'LegalCopyright',<'Copyright ',0A9h,' 2003 axm.'>,\
	  'FileVersion','0.02',\
	   'ProductVersion','0.02',\
	  'OriginalFilename','hasher.exe'

