needs tester.f
needs debugger
test-postfix
details on

t{ aaa aad aam aas }

t: eax ebx adc
t: 4 # esi adc
t: 5 # -2 [nob] [ebp] *4 adc
t: dl cl adc
t: 12345678 # 10 [eax] adc 
t: 12 # 10 [eax] adc 
t: 12345678 # ecx  adc 
t: dl 12345678 [edx] adc
t: cl ' base #) adc

t: 2 # al add
t: ebx ecx and

t: 0 [edx] eax bound
t: 5 [ebp] [esi] *8 ebx bound

t: 2 #) ebx bsf
t: edx edi bsr
t: 0 [nob] [edx] *2 eax bsr

t: esi bswap

t:   edx	call
t: 1234 #	call
t: 0 [edx]	call
t: 0 [ebp]  far call
t: 1000 100 # far call
t: 500 #) far call
t: 100 [nob] [esi] *8 call
t: ' + # call
t: ' type #) call

t{ cwde cdq }
t{ clc cld cmc }

t: eax ebx cmovo
t: eax ecx cmovno
t: 1 #) eax cmovb
t: 0 [edi] ebx cmovae
t: -5 [nob] [esi] *2 esp cmove
t: edi esi cmovne
t: FF [esi] [edi] *1 ebp cmove
t: eax eax cmova
t: ebx edi cmovs
t: ' base #) eax cmovns
t: 0 #) ecx cmovpe
t: 2 #) ebp cmovpo
t: ebx esi cmovl
t: esi ebx cmovge
t: edi edx cmovle
t: ecx esi cmovg

t: ebx edx cmp
t{ cmpsb cmpsd }

t: eax 12 #) cmpxchg 
t: eax edx cmpxchg 
t: al 0 [ebp] cmpxchg 
t: dl 5 [edi] [eax] *2 cmpxchg

t{ daa das }

t: eax dec
t: cl dec
t: 12 #) dec
t: ' scratch #) byte dec

t: bl div
t: 4  #) byte  div
t: ecx div
t: 8 [ebx] div

t: cl idiv
t: esi idiv
t: 0 [esi] [edi] *1 byte idiv
t: 12345 #) idiv

| imul is very limited

t: 4 # al in
t: edx al in

test bye
