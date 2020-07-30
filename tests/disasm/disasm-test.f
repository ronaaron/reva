needs tester.f
details on

1 [IF]
t{ aaa aad aam aas }

t: adc eax, ecx
t: adc ecx, [ebx+$12345678]
t: adc edx, 4
t: adc eax, 1
t: adc dword [ebp*4-2], 5

t: add al, ah
t: add [ecx], bl
t: add esp, 2
t: add [bx], al

t: and eax, eax
t: and ecx, [bp+di-2]

t: arpl [edx],  ax
t: arpl [$200], bx

t: bound ebx, [ecx+esi*4]

t: bsf ecx, edx 
t: bsr ecx, [ebx]

t: bswap edx
t: bt [edi], ecx
t: btc eax, 3
| can't make nasm assemble "BTx mem, imm". It seems to be a bug in nasm
t/ dd 0x002bba0f / bts [ebx], 0

t: btr edx, eax
t: bts [ebx], ecx 

t: call [$1000]
t: call eax
t: call [ebx+edi]
t: call far [esi]

t{ cbw cwde clc cld cli clts cmc }

t: cmove eax, edx
t: cmova ebx, [edi]
t: cmovne edx, [esi+ebp+$15]
t: cmovo esi, [edi]

t: clflush [eax]

t: cmp eax, ebx
t: cmp al, 7
t: cmp byte [ecx+esi+4], 2
t: cmp [edi+edi], esi

t{ cmpsb cmpsw cmpsd cpuid }

t: cmpxchg eax, ebx
t: cmpxchg [edi], al
t: cmpxchg [esi], edx

t{ cwd cdq daa das }

t: dec eax
t: dec byte [esi+ebp*4]

t: div dword [9]
t: div byte [9]

t: div bl
t: div dword [ebx]

t: enter 4, 0
t: enter 8, 1
t: enter $1000, 8

t: hlt 

t: idiv cl
t: idiv byte [edi]
t: idiv dword [edi]

t: imul dl
t: imul byte [ebx]
t: imul dword [ebx]
t: imul eax, ecx
t: imul ecx, [eax]
t: imul eax, ebx, 4
t: imul eax, [edi*4], 5

t: imul edx, 8
t: imul ecx, $11112222
t: imul ecx, [edx], 4

t: in eax, 4
t: in al, 8

t: in al, dx
t: in eax, dx
t: in ax, dx

t: inc byte [ecx]
t: inc al
t: inc dword [ebx]

t{ insb insw insd }

t: int 0
t: int 3
t: into

t{ invd iretd }
t: invlpg [ebx]

| JMPxx can't be tested here

t{ lahf }

t: lar eax, [ebx]
t: lar edx, edx

t: lds esi, [ebx]
t: lss esp, [ebx+ebp*4]
t: les edi, [8]
t: lfs ebx, [edi]
t: lgs edx, [esp]
t: lea eax, [eax+esi*8+$1234]

t: ldmxcsr [esp+edi*4-$100]

t{ leave lfence lock }

t: lgdt [ebx]
t: lidt [esi]

t: lmsw ax
t: lmsw [ebx]

t: lldt bx
t: lldt [ebx]

t{ lodsb lodsw lodsd }

t: lsl edx, [ebx]
t: ltr [ebx]
t: ltr dx

t{ mfence monitor }

t: mov cl, [eax]
t: mov bl, al
t: mov [esi], cl
t: mov eax, [edx+edx]
t: mov eax, esp
t: mov [edx], esi
t: mov al, [0]
t: mov eax, [1]
t: mov ebx, gs
t: mov fs, [ebp]
t: mov cl, 1
t: mov edx, 0
t: mov byte [ebx], 1
t: mov dword [ebx], 1

t: mov cr0, eax
t: mov ebx, cr2
t: mov edx, cr7
t: mov cr1, ecx

t: mov dr0, ebx
t: mov dr4, esi
t: mov edi, dr1
t: mov esp, dr7

t{ movsb movsw movsd }

t: movsx eax, bl
t: movsx eax, bx
t: movsx eax, byte [edi]
t: movsx eax, word [edi]

t: movzx edx, cl
t: movzx edx, bx
t: movzx edx, byte [esi+0xABCD]
t: movzx edx, word [esi]

t: mul cl
t: mul ecx
t: mul byte [ebx]
t: mul dword [edx]

t: mwait

t: neg eax
t: neg cl
t: neg byte [edi]
t: neg dword [edi]

t: nop
t: nop eax
t: nop dword [eax]
t: nop dword [eax+eax]

t: not ebp
t: not cl
t: not byte [ebx]
t: not dword [edx]

t: or al, 0
t: or eax, 1
t: or dl, 2
t: or ecx, 3
t: or dword [edi], 8
t: or byte [edi], 7
t: or eax, ebx
t: or [edx], edi

t: out 8, al
t: out 0, eax
t: out dx, al
t: out dx, eax

t: pop eax
t: pop dword [ebx]
t: pop ds
t: pop gs
t{ popad popfd pushad pushfd }

t: push esp
t: push dword [edi]
t: push fs

t: rcl eax, 1
t: rcl ebx, cl
t: ror edx, $10
t: rol byte [edi], 1
t: rcr dword [edi], 1
t: ror dword [esi], 5
t: rcr byte [ebx], cl

t{ rdmsr rdpmc rdtsc rdtscp }

t{ repe repne }
t/ rep / repe
t/ repz / repe
t/ repnz / repne

| t: retf
t: ret

t{ rsm sahf }

t: shl al, 1
t: shl byte [edx], 1
t: sar byte [ebx], 1
t: shr dword [edi], cl
t: sar dl, 1
t/ sal edx, $50 / shl edx, 50

t{ scasb scasw scasd }

t: seta [ebp]
t: setae cl
t: setb dl
t: setbe al
t/ setc [edx] / setb [edx]
t: sete bl
t: setg [eax] 
t: setge al
t: setl dl
t: setle [edi]

t: sfence

t: sgdt [ebx]
t: shld edx, eax, 8
t: shld eax, ecx, cl
t: shrd esi, edi, 1
t: shrd esp, ebp, cl
t: sidt [edx]
t: sldt [eax]
t: sldt ebx
t: sldt bx

t: smsw eax
t: smsw dx
t: smsw [edx]
t{ stc std sti }

t: stmxcsr [eax]

t{ stosb stosw stosd }

t: str [edi]

t: sbb [eax], edx
t: sbb [esi], cl
t: sbb cl, [ebx]
t: sbb eax, [esi+edi*4-$500]
t: sub al, 1
t: sub eax, $1234
t: sub cl, 0xFF
t: sub byte [esi], 5 
t: sub edx, $8765321
t: sub edi, esi

t{ sysenter sysexit sysret }

t: test eax, eax
t: test [ebx], ecx
t: test cl, 8

t: ud2

t: verr bx
t: verr [eax]

t{ wait wbinvd wrmsr }


t: xadd al, cl
t: xadd [ebx], eax

t/ xchg eax, eax / nop
t: xchg [ebx], cl
t: xchg [edx], eax

| uncommon order
| t: xchg ebx, edx
| t: xchg esp, ebp

t{ xgetbv xsetbv }

t: xlatb

t: xor eax, eax
t: xor al, 1
t: xor [edi], dl
t: xor ebx, [edx]
t: xor [edi], cl
t: xor ebp, [esp]

t/ db $0f, $01, $0ca / ???

| can't assemble swapgs in 32-bit mode
t/ db $0f, $01, $0f8 / swapgs
[ELSE]
[THEN] 
test bye

