| http://ronware.org/reva/viewtopic.php?pid=6673#p6673

needs debugger
needs asm/x86

: a asm{ 
	0 L: 
	5 # eax mov 
	1 L: eax eax xor 
	1 L je 
	0 L jne 
	} ;

see a
bye
