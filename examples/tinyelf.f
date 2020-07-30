| example how to produce a very minimal ELF format program

needs asm/format/elf

~asm
begin-exe
code 
	| just returns a '42' as an exit code, doesn't do anything useful
	1 # EAX MOV
	42 # EBX MOV
	$80 INT
	
" tiny" save-exe bye
