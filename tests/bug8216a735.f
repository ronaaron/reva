| demonstrate bug [8216a7359af15aa3254b1e409ba39108c6bbed3c]
| Output is something like:
| 08269424  FE 00                       inc [eax]
| 08269426 
| eip      esp      ebp      eax      ecx      edx      ebx      esi      edi
| 08266BC4 BF9F8A54 00000010 000000C0 00000003 00000000 00000000 0806DB6C 080716A2 
| 
| Exception SIGSEGV in: sib
| 08 00                       or [eax],al
| 08266BC6  00 00             add [eax],al

needs debugger

: crash inline{ fe 00 85 c0 } ;

see crash
