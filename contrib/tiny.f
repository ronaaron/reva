0 [IF]
  BITS 32
  
                org     0x08048000
  
  ehdr:                                                 ; Elf32_Ehdr
                db      0x7F, "ELF", 1, 1, 1, 0         ;   e_ident
        times 8 db      0
                dw      2                               ;   e_type
                dw      3                               ;   e_machine
                dd      1                               ;   e_version
                dd      _start                          ;   e_entry
                dd      phdr - $$                       ;   e_phoff
                dd      0                               ;   e_shoff
                dd      0                               ;   e_flags
                dw      ehdrsize                        ;   e_ehsize
                dw      phdrsize                        ;   e_phentsize
                dw      1                               ;   e_phnum
                dw      0                               ;   e_shentsize
                dw      0                               ;   e_shnum
                dw      0                               ;   e_shstrndx
  
  ehdrsize      equ     $ - ehdr
  
  phdr:                                                 ; Elf32_Phdr
                dd      1                               ;   p_type
                dd      0                               ;   p_offset
                dd      $$                              ;   p_vaddr
                dd      $$                              ;   p_paddr
                dd      filesize                        ;   p_filesz
                dd      filesize                        ;   p_memsz
                dd      5                               ;   p_flags
                dd      0x1000                          ;   p_align
  
  phdrsize      equ     $ - phdr
  
  _start:
  
  ; your program here
                mov     eax, 1
                mov     ebx, 42  
                int     0x80
 
  filesize      equ     $ - $$

[THEN]

needs assembler

~asm

variable entry-ofs
variable phdr
: +org origin @ + ;

$8048000 org
create elf-header
	$7f 1, 'E 1, 'L 1, 'F 1, 
	       1 1, 1 1, 1 1, 0 1,
	0 , 0 ,				| times 8 db 0
	2 2,				| e_type
	3 2,				| e_machine
	1 ,					| e_version
	here entry-ofs !
	0 ,					| e_entry
	0 ,					| e_phoff
	0 ,					| e_shoff
	0 ,					| e_flags
	here 
	0 ,					| e_hsize, e_phentsize
	1 2,				| e_phnum
	0 2,				| e_shentsize
	0 2,				| e_shnum
	0 2,				| e_shstrndx
	| 'here' of e_hsize offset is on stack
	dup here - over w!
	1+ 1+				| now it's offset of e_phentsize

	| phdr:
	| fix-up the offset information in the first header
	here dup entry-ofs @ -
		entry-ofs @ cell+ !
	
	dup
	negate phdr !		| ( phentsizeptr )
	1 ,					| p_type
	0 ,					| p_offset
	here ,				| p_vaddr
	here ,				| p_paddr
	here				| phentsizeptr phdrptr filesizeptr
	0 ,					| p_filesz
	0 ,					| p_memsz 
	5 ,					| flags
	$1000 ,				| align

	here phdr +!		| phdr -> size of phdr
	phdr ? ." is phdr size" cr

	-rot				| filesizeptr phentsizeptr phdrptr
	here - swap w!		| filesizeptr
| create elf_start
	here 
	' elf-header - +org
	dup ." entry point at: " .x cr
	entry-ofs @ !		| fix up the entry offset

	|  actual code:
	1 eax mov
	42 ebx mov
	$80 int

	| calculate 'filesize'
	here 
	' elf-header - swap !


here ' elf-header - temp !
exit~

~asm.elf-header temp @ 
" testme" creat dup temp !
write temp @ close bye
