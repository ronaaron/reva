| The Reva Assembler 
| Should take an assembly input file and properly convert it to an output...


| Need the actual assembler bits:
needs asm/x86

needs asm/format/pe
needs asm/format/elf
needs asm/format/mach

| create missing assembler directives:
~asm

0 constant PE
1 constant ELF
2 constant MACH

os variable, current-format

create known-formats
	' pe-format ,
	' elf-format ,
	' mach-format ,

: format  ( n -- )
	dup PE MACH between 0if 
		. ." is not a valid format!" cr bye
	then

	dup current-format ! 

	| we have the format; now load the correct support code
	cells known-formats + @execute

	;

| Go back to the main context:
~


