_SHA1Transform:;        proc    near

   ;    void SHA1Transform(unsigned long state[5], unsigned char buffer[64])
	push	  ebp
	mov	  ebp,esp
	add	  esp,-12
	push	  ebx
	push	  esi
	push	  edi
@1:
	mov	  ebx, mobkdeia
cinvoke memcpy,ebx,dword [ebp+12],64
	mov	  eax,dword  [ebp+8]
	mov	  eax,dword [eax]
	mov	  edx,dword [ebp+8]
	mov	  edx,dword [edx+4]
	mov	  ecx,dword [ebp+8]
	mov	  ecx,dword [ecx+8]
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp+8]
	mov	  ecx,dword [ecx+12]
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebp+8]
	mov	  ecx,dword [ecx+16]
	mov	  dword [ebp-12],ecx
    ;       /* 4 rounds of 20 operations each. Loop unrolled. */
    ;       R0(a,b,c,d,e, 0); R0(e,a,b,c,d, 1); R0(d,e,a,b,c, 2); R0(c,d,e,a,b, 3);
	mov	  ecx,dword [ebx]
	shl	  ecx,24
	mov	  esi,dword [ebx]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx]
	shl	  esi,8
	mov	  edi,dword [ebx]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	and	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+4]
	shl	  ecx,24
	mov	  esi,dword [ebx+4]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+4]
	shl	  esi,8
	mov	  edi,dword [ebx+4]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+4],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	and	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+8]
	shl	  ecx,24
	mov	  esi,dword [ebx+8]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+8]
	shl	  esi,8
	mov	  edi,dword [ebx+8]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+8],ecx
	mov	  esi,edx
	xor	  esi,eax
	and	  esi,dword [ebp-12]
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+12]
	shl	  ecx,24
	mov	  esi,dword [ebx+12]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+12]
	shl	  esi,8
	mov	  edi,dword [ebx+12]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+12],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	and	  esi,dword [ebp-8]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
   ;        R0(b,c,d,e,a, 4); R0(a,b,c,d,e, 5); R0(e,a,b,c,d, 6); R0(d,e,a,b,c, 7);
	mov	  ecx,dword [ebx+16]
	shl	  ecx,24
	mov	  esi,dword [ebx+16]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+16]
	shl	  esi,8
	mov	  edi,dword [ebx+16]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+16],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	and	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+20]
	shl	  ecx,24
	mov	  esi,dword [ebx+20]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+20]
	shl	  esi,8
	mov	  edi,dword [ebx+20]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+20],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	and	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+24]
	shl	  ecx,24
	mov	  esi,dword [ebx+24]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+24]
	shl	  esi,8
	mov	  edi,dword [ebx+24]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+24],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	and	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+28]
	shl	  ecx,24
	mov	  esi,dword [ebx+28]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+28]
	shl	  esi,8
	mov	  edi,dword [ebx+28]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+28],ecx
	mov	  esi,edx
	xor	  esi,eax
	and	  esi,dword [ebp-12]
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
   ;        R0(c,d,e,a,b, 8); R0(b,c,d,e,a, 9); R0(a,b,c,d,e,10); R0(e,a,b,c,d,11);
	mov	  ecx,dword [ebx+32]
	shl	  ecx,24
	mov	  esi,dword [ebx+32]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+32]
	shl	  esi,8
	mov	  edi,dword [ebx+32]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+32],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	and	  esi,dword [ebp-8]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+36]
	shl	  ecx,24
	mov	  esi,dword [ebx+36]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+36]
	shl	  esi,8
	mov	  edi,dword [ebx+36]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+36],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	and	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+40]
	shl	  ecx,24
	mov	  esi,dword [ebx+40]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+40]
	shl	  esi,8
	mov	  edi,dword [ebx+40]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+40],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	and	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+44]
	shl	  ecx,24
	mov	  esi,dword [ebx+44]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+44]
	shl	  esi,8
	mov	  edi,dword [ebx+44]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+44],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	and	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
   ;        R0(d,e,a,b,c,12); R0(c,d,e,a,b,13); R0(b,c,d,e,a,14); R0(a,b,c,d,e,15);
	mov	  ecx,dword [ebx+48]
	shl	  ecx,24
	mov	  esi,dword [ebx+48]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+48]
	shl	  esi,8
	mov	  edi,dword [ebx+48]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+48],ecx
	mov	  esi,edx
	xor	  esi,eax
	and	  esi,dword [ebp-12]
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+52]
	shl	  ecx,24
	mov	  esi,dword [ebx+52]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+52]
	shl	  esi,8
	mov	  edi,dword [ebx+52]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+52],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	and	  esi,dword [ebp-8]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+56]
	shl	  ecx,24
	mov	  esi,dword [ebx+56]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+56]
	shl	  esi,8
	mov	  edi,dword [ebx+56]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+56],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	and	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+60]
	shl	  ecx,24
	mov	  esi,dword [ebx+60]
	shr	  esi,8
	or	  ecx,esi
	and	  ecx,-16711936
	mov	  esi,dword [ebx+60]
	shl	  esi,8
	mov	  edi,dword [ebx+60]
	shr	  edi,24
	or	  esi,edi
	and	  esi,16711935
	or	  ecx,esi
	mov	  dword [ebx+60],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	and	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
   ;        R1(e,a,b,c,d,16); R1(d,e,a,b,c,17); R1(c,d,e,a,b,18); R1(b,c,d,e,a,19);
	mov	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx]
	add	  ecx,ecx
	mov	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	and	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+4]
	add	  ecx,ecx
	mov	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+4]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+4],ecx
	mov	  esi,edx
	xor	  esi,eax
	and	  esi,dword [ebp-12]
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+8]
	add	  ecx,ecx
	mov	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+8]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+8],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	and	  esi,dword [ebp-8]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx+12]
	add	  ecx,ecx
	mov	  esi,dword [ebx]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+12]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+12],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	and	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1518500249
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
   ;        R2(a,b,c,d,e,20); R2(e,a,b,c,d,21); R2(d,e,a,b,c,22); R2(c,d,e,a,b,23);
	mov	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx+16]
	add	  ecx,ecx
	mov	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+16]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+16],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+20]
	add	  ecx,ecx
	mov	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+20]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+20],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+24]
	add	  ecx,ecx
	mov	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+24]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+24],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+28]
	add	  ecx,ecx
	mov	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+28]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+28],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
   ;        R2(b,c,d,e,a,24); R2(a,b,c,d,e,25); R2(e,a,b,c,d,26); R2(d,e,a,b,c,27);
	mov	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+32]
	add	  ecx,ecx
	mov	  esi,dword [ebx+20]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+32]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+32],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+36]
	add	  ecx,ecx
	mov	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+36]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+36],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+40]
	add	  ecx,ecx
	mov	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+40]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+40],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+44]
	add	  ecx,ecx
	mov	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+44]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+44],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
   ;        R2(c,d,e,a,b,28); R2(b,c,d,e,a,29); R2(a,b,c,d,e,30); R2(e,a,b,c,d,31);
	mov	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+48]
	add	  ecx,ecx
	mov	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+48]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+48],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+52]
	add	  ecx,ecx
	mov	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+52]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+52],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+56]
	add	  ecx,ecx
	mov	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+56]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+56],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+60]
	add	  ecx,ecx
	mov	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+60]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+60],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
   ;        R2(d,e,a,b,c,32); R2(c,d,e,a,b,33); R2(b,c,d,e,a,34); R2(a,b,c,d,e,35);
	mov	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx]
	add	  ecx,ecx
	mov	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+4]
	add	  ecx,ecx
	mov	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+4]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+4],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+8]
	add	  ecx,ecx
	mov	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+8]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+8],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx+12]
	add	  ecx,ecx
	mov	  esi,dword [ebx]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+12]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+12],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
   ;        R2(e,a,b,c,d,36); R2(d,e,a,b,c,37); R2(c,d,e,a,b,38); R2(b,c,d,e,a,39);
	mov	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx+16]
	add	  ecx,ecx
	mov	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+16]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+16],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+20]
	add	  ecx,ecx
	mov	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+20]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+20],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+24]
	add	  ecx,ecx
	mov	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+24]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+24],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+28]
	add	  ecx,ecx
	mov	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+28]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+28],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,1859775393
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
   ;        R3(a,b,c,d,e,40); R3(e,a,b,c,d,41); R3(d,e,a,b,c,42); R3(c,d,e,a,b,43);
	mov	  ecx,dword [ebp-4]
	or	  ecx,edx
	and	  ecx,dword [ebp-8]
	mov	  esi,dword [ebp-4]
	and	  esi,edx
	or	  ecx,esi
	mov	  esi,dword [ebx+20]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+32]
	add	  esi,esi
	mov	  edi,dword [ebx+20]
	xor	  edi,dword [ebx]
	xor	  edi,dword [ebx+40]
	xor	  edi,dword [ebx+32]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+32],esi
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,edx
	or	  ecx,eax
	and	  ecx,dword [ebp-4]
	mov	  esi,edx
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+36]
	add	  esi,esi
	mov	  edi,dword [ebx+24]
	xor	  edi,dword [ebx+4]
	xor	  edi,dword [ebx+44]
	xor	  edi,dword [ebx+36]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+36],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebp-12]
	or	  ecx,eax
	and	  ecx,edx
	mov	  esi,dword [ebp-12]
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+40]
	add	  esi,esi
	mov	  edi,dword [ebx+28]
	xor	  edi,dword [ebx+8]
	xor	  edi,dword [ebx+48]
	xor	  edi,dword [ebx+40]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+40],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebp-8]
	or	  ecx,dword [ebp-12]
	and	  ecx,eax
	mov	  esi,dword [ebp-8]
	and	  esi,dword [ebp-12]
	or	  ecx,esi
	mov	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+44]
	add	  esi,esi
	mov	  edi,dword [ebx+32]
	xor	  edi,dword [ebx+12]
	xor	  edi,dword [ebx+52]
	xor	  edi,dword [ebx+44]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+44],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
   ;        R3(b,c,d,e,a,44); R3(a,b,c,d,e,45); R3(e,a,b,c,d,46); R3(d,e,a,b,c,47);
	mov	  ecx,dword [ebp-4]
	or	  ecx,dword [ebp-8]
	and	  ecx,dword [ebp-12]
	mov	  esi,dword [ebp-4]
	and	  esi,dword [ebp-8]
	or	  ecx,esi
	mov	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+48]
	add	  esi,esi
	mov	  edi,dword [ebx+36]
	xor	  edi,dword [ebx+16]
	xor	  edi,dword [ebx+56]
	xor	  edi,dword [ebx+48]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+48],esi
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-4]
	or	  ecx,edx
	and	  ecx,dword [ebp-8]
	mov	  esi,dword [ebp-4]
	and	  esi,edx
	or	  ecx,esi
	mov	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+52]
	add	  esi,esi
	mov	  edi,dword [ebx+40]
	xor	  edi,dword [ebx+20]
	xor	  edi,dword [ebx+60]
	xor	  edi,dword [ebx+52]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+52],esi
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,edx
	or	  ecx,eax
	and	  ecx,dword [ebp-4]
	mov	  esi,edx
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+56]
	add	  esi,esi
	mov	  edi,dword [ebx+44]
	xor	  edi,dword [ebx+24]
	xor	  edi,dword [ebx]
	xor	  edi,dword [ebx+56]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+56],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebp-12]
	or	  ecx,eax
	and	  ecx,edx
	mov	  esi,dword [ebp-12]
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+60]
	add	  esi,esi
	mov	  edi,dword [ebx+48]
	xor	  edi,dword [ebx+28]
	xor	  edi,dword [ebx+4]
	xor	  edi,dword [ebx+60]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+60],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
   ;        R3(c,d,e,a,b,48); R3(b,c,d,e,a,49); R3(a,b,c,d,e,50); R3(e,a,b,c,d,51);
	mov	  ecx,dword [ebp-8]
	or	  ecx,dword [ebp-12]
	and	  ecx,eax
	mov	  esi,dword [ebp-8]
	and	  esi,dword [ebp-12]
	or	  ecx,esi
	mov	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx]
	add	  esi,esi
	mov	  edi,dword [ebx+52]
	xor	  edi,dword [ebx+32]
	xor	  edi,dword [ebx+8]
	xor	  edi,dword [ebx]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebp-4]
	or	  ecx,dword [ebp-8]
	and	  ecx,dword [ebp-12]
	mov	  esi,dword [ebp-4]
	and	  esi,dword [ebp-8]
	or	  ecx,esi
	mov	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+4]
	add	  esi,esi
	mov	  edi,dword [ebx+56]
	xor	  edi,dword [ebx+36]
	xor	  edi,dword [ebx+12]
	xor	  edi,dword [ebx+4]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+4],esi
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-4]
	or	  ecx,edx
	and	  ecx,dword [ebp-8]
	mov	  esi,dword [ebp-4]
	and	  esi,edx
	or	  ecx,esi
	mov	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+8]
	add	  esi,esi
	mov	  edi,dword [ebx+60]
	xor	  edi,dword [ebx+40]
	xor	  edi,dword [ebx+16]
	xor	  edi,dword [ebx+8]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+8],esi
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,edx
	or	  ecx,eax
	and	  ecx,dword [ebp-4]
	mov	  esi,edx
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+12]
	add	  esi,esi
	mov	  edi,dword [ebx]
	xor	  edi,dword [ebx+44]
	xor	  edi,dword [ebx+20]
	xor	  edi,dword [ebx+12]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+12],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
   ;        R3(d,e,a,b,c,52); R3(c,d,e,a,b,53); R3(b,c,d,e,a,54); R3(a,b,c,d,e,55);
	mov	  ecx,dword [ebp-12]
	or	  ecx,eax
	and	  ecx,edx
	mov	  esi,dword [ebp-12]
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+16]
	add	  esi,esi
	mov	  edi,dword [ebx+4]
	xor	  edi,dword [ebx+48]
	xor	  edi,dword [ebx+24]
	xor	  edi,dword [ebx+16]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+16],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebp-8]
	or	  ecx,dword [ebp-12]
	and	  ecx,eax
	mov	  esi,dword [ebp-8]
	and	  esi,dword [ebp-12]
	or	  ecx,esi
	mov	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+20]
	add	  esi,esi
	mov	  edi,dword [ebx+8]
	xor	  edi,dword [ebx+52]
	xor	  edi,dword [ebx+28]
	xor	  edi,dword [ebx+20]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+20],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebp-4]
	or	  ecx,dword [ebp-8]
	and	  ecx,dword [ebp-12]
	mov	  esi,dword [ebp-4]
	and	  esi,dword [ebp-8]
	or	  ecx,esi
	mov	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+24]
	add	  esi,esi
	mov	  edi,dword [ebx+12]
	xor	  edi,dword [ebx+56]
	xor	  edi,dword [ebx+32]
	xor	  edi,dword [ebx+24]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+24],esi
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-4]
	or	  ecx,edx
	and	  ecx,dword [ebp-8]
	mov	  esi,dword [ebp-4]
	and	  esi,edx
	or	  ecx,esi
	mov	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+28]
	add	  esi,esi
	mov	  edi,dword [ebx+16]
	xor	  edi,dword [ebx+60]
	xor	  edi,dword [ebx+36]
	xor	  edi,dword [ebx+28]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+28],esi
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
   ;        R3(e,a,b,c,d,56); R3(d,e,a,b,c,57); R3(c,d,e,a,b,58); R3(b,c,d,e,a,59);
	mov	  ecx,edx
	or	  ecx,eax
	and	  ecx,dword [ebp-4]
	mov	  esi,edx
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+20]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+32]
	add	  esi,esi
	mov	  edi,dword [ebx+20]
	xor	  edi,dword [ebx]
	xor	  edi,dword [ebx+40]
	xor	  edi,dword [ebx+32]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+32],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebp-12]
	or	  ecx,eax
	and	  ecx,edx
	mov	  esi,dword [ebp-12]
	and	  esi,eax
	or	  ecx,esi
	mov	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+36]
	add	  esi,esi
	mov	  edi,dword [ebx+24]
	xor	  edi,dword [ebx+4]
	xor	  edi,dword [ebx+44]
	xor	  edi,dword [ebx+36]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+36],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebp-8]
	or	  ecx,dword [ebp-12]
	and	  ecx,eax
	mov	  esi,dword [ebp-8]
	and	  esi,dword [ebp-12]
	or	  ecx,esi
	mov	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+40]
	add	  esi,esi
	mov	  edi,dword [ebx+28]
	xor	  edi,dword [ebx+8]
	xor	  edi,dword [ebx+48]
	xor	  edi,dword [ebx+40]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+40],esi
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebp-4]
	or	  ecx,dword [ebp-8]
	and	  ecx,dword [ebp-12]
	mov	  esi,dword [ebp-4]
	and	  esi,dword [ebp-8]
	or	  ecx,esi
	mov	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+44]
	add	  esi,esi
	mov	  edi,dword [ebx+32]
	xor	  edi,dword [ebx+12]
	xor	  edi,dword [ebx+52]
	xor	  edi,dword [ebx+44]
	shr	  edi,31
	or	  esi,edi
	mov	  dword [ebx+44],esi
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-1894007588
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
   ;        R4(a,b,c,d,e,60); R4(e,a,b,c,d,61); R4(d,e,a,b,c,62); R4(c,d,e,a,b,63);
	mov	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+48]
	add	  ecx,ecx
	mov	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+48]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+48],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+52]
	add	  ecx,ecx
	mov	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+52]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+52],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+56]
	add	  ecx,ecx
	mov	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+56]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+56],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+60]
	add	  ecx,ecx
	mov	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+60]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+60],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
   ;        R4(b,c,d,e,a,64); R4(a,b,c,d,e,65); R4(e,a,b,c,d,66); R4(d,e,a,b,c,67);
	mov	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx]
	add	  ecx,ecx
	mov	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+4]
	add	  ecx,ecx
	mov	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+4]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+4],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+8]
	add	  ecx,ecx
	mov	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+8]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+8],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx+12]
	add	  ecx,ecx
	mov	  esi,dword [ebx]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+12]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+12],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
   ;        R4(c,d,e,a,b,68); R4(b,c,d,e,a,69); R4(a,b,c,d,e,70); R4(e,a,b,c,d,71);
	mov	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx+16]
	add	  ecx,ecx
	mov	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+16]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+16],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+20]
	add	  ecx,ecx
	mov	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+20]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+20],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+24]
	add	  ecx,ecx
	mov	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+24]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+24],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
	mov	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+28]
	add	  ecx,ecx
	mov	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+28]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+28],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
   ;        R4(d,e,a,b,c,72); R4(c,d,e,a,b,73); R4(b,c,d,e,a,74); R4(a,b,c,d,e,75);
	mov	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+32]
	add	  ecx,ecx
	mov	  esi,dword [ebx+20]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+32]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+32],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+36]
	add	  ecx,ecx
	mov	  esi,dword [ebx+24]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+36]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+36],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+8]
	xor	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+40]
	add	  ecx,ecx
	mov	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+8]
	xor	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+40]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+40],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	add	  ecx,esi
	mov	  esi,edx
	shl	  esi,5
	mov	  edi,edx
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  esi,dword [ebp-4]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-4],ecx
	mov	  ecx,dword [ebx+32]
	xor	  ecx,dword [ebx+12]
	xor	  ecx,dword [ebx+52]
	xor	  ecx,dword [ebx+44]
	add	  ecx,ecx
	mov	  esi,dword [ebx+32]
	xor	  esi,dword [ebx+12]
	xor	  esi,dword [ebx+52]
	xor	  esi,dword [ebx+44]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+44],ecx
	mov	  esi,dword [ebp-4]
	xor	  esi,edx
	xor	  esi,dword [ebp-8]
	add	  ecx,esi
	mov	  esi,eax
	shl	  esi,5
	mov	  edi,eax
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-12],ecx
	mov	  ecx,edx
	shl	  ecx,30
	shr	  edx,2
	or	  ecx,edx
	mov	  edx,ecx
   ;        R4(e,a,b,c,d,76); R4(d,e,a,b,c,77); R4(c,d,e,a,b,78); R4(b,c,d,e,a,79);
	mov	  ecx,dword [ebx+36]
	xor	  ecx,dword [ebx+16]
	xor	  ecx,dword [ebx+56]
	xor	  ecx,dword [ebx+48]
	add	  ecx,ecx
	mov	  esi,dword [ebx+36]
	xor	  esi,dword [ebx+16]
	xor	  esi,dword [ebx+56]
	xor	  esi,dword [ebx+48]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+48],ecx
	mov	  esi,edx
	xor	  esi,eax
	xor	  esi,dword [ebp-4]
	add	  ecx,esi
	mov	  esi,dword [ebp-12]
	shl	  esi,5
	mov	  edi,dword [ebp-12]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-8],ecx
	mov	  ecx,eax
	shl	  ecx,30
	shr	  eax,2
	or	  ecx,eax
	mov	  eax,ecx
	mov	  ecx,dword [ebx+40]
	xor	  ecx,dword [ebx+20]
	xor	  ecx,dword [ebx+60]
	xor	  ecx,dword [ebx+52]
	add	  ecx,ecx
	mov	  esi,dword [ebx+40]
	xor	  esi,dword [ebx+20]
	xor	  esi,dword [ebx+60]
	xor	  esi,dword [ebx+52]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+52],ecx
	mov	  esi,dword [ebp-12]
	xor	  esi,eax
	xor	  esi,edx
	add	  ecx,esi
	mov	  esi,dword [ebp-8]
	shl	  esi,5
	mov	  edi,dword [ebp-8]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  dword [ebp-4],ecx
	mov	  ecx,dword [ebp-12]
	shl	  ecx,30
	mov	  esi,dword [ebp-12]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-12],ecx
	mov	  ecx,dword [ebx+44]
	xor	  ecx,dword [ebx+24]
	xor	  ecx,dword [ebx]
	xor	  ecx,dword [ebx+56]
	add	  ecx,ecx
	mov	  esi,dword [ebx+44]
	xor	  esi,dword [ebx+24]
	xor	  esi,dword [ebx]
	xor	  esi,dword [ebx+56]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+56],ecx
	mov	  esi,dword [ebp-8]
	xor	  esi,dword [ebp-12]
	xor	  esi,eax
	add	  ecx,esi
	mov	  esi,dword [ebp-4]
	shl	  esi,5
	mov	  edi,dword [ebp-4]
	shr	  edi,27
	or	  esi,edi
	add	  ecx,esi
	add	  ecx,-899497514
	add	  edx,ecx
	mov	  ecx,dword [ebp-8]
	shl	  ecx,30
	mov	  esi,dword [ebp-8]
	shr	  esi,2
	or	  ecx,esi
	mov	  dword [ebp-8],ecx
	mov	  ecx,dword [ebx+48]
	xor	  ecx,dword [ebx+28]
	xor	  ecx,dword [ebx+4]
	xor	  ecx,dword [ebx+60]
	add	  ecx,ecx
	mov	  esi,dword [ebx+48]
	xor	  esi,dword [ebx+28]
	xor	  esi,dword [ebx+4]
	xor	  esi,dword [ebx+60]
	shr	  esi,31
	or	  ecx,esi
	mov	  dword [ebx+60],ecx
	mov	  ebx,dword [ebp-4]
	xor	  ebx,dword [ebp-8]
	xor	  ebx,dword [ebp-12]
	add	  ecx,ebx
	mov	  ebx,edx
	shl	  ebx,5
	mov	  esi,edx
	shr	  esi,27
	or	  ebx,esi
	add	  ecx,ebx
	add	  ecx,-899497514
	add	  eax,ecx
	mov	  ecx,dword [ebp-4]
	shl	  ecx,30
	mov	  ebx,dword [ebp-4]
	shr	  ebx,2
	or	  ecx,ebx
	mov	  dword [ebp-4],ecx

	mov	  ecx,dword [ebp+8]
	add	  dword [ecx],eax
	mov	  eax,dword [ebp+8]
	add	  dword [eax+4],edx
	mov	  edx,dword [ebp+8]
	mov	  eax,dword [ebp-4]
	add	  dword [edx+8],eax
	mov	  edx,dword [ebp+8]
	mov	  ecx,dword [ebp-8]
	add	  dword [edx+12],ecx
	mov	  eax,dword [ebp+8]
	mov	  edx,dword [ebp-12]
	add	  dword [eax+16],edx
	xor	  ecx,ecx
	mov	  dword [ebp-12],ecx
	mov	  dword [ebp-8],ecx
	mov	  dword [ebp-4],ecx
	mov	  edx,ecx
@2:
	pop	  edi
	pop	  esi
	pop	  ebx
	mov	  esp,ebp
	pop	  ebp
	ret


_SHA1Init:
   ;    void SHA1Init(SHA1_CTX* context)
	push	  ebp
	mov	  ebp,esp
	mov	  eax,dword [ebp+8]
   ; EAX = context
	mov	  dword [eax],067452301h
	mov	  dword [eax+4],0EFCDAB89h
	mov	  dword [eax+8],098BADCFEh
	mov	  dword [eax+12],010325476h
	mov	  dword [eax+16],0C3D2E1F0h
	xor	  edx,edx
	mov	  dword [eax+24],edx
	mov	  dword [eax+20],edx
	pop	  ebp
	ret


_SHA1Update:
   ;    void SHA1Update(SHA1_CTX* context, unsigned char* data, unsigned int len)
	push	  ebp
	mov	  ebp,esp
	push	  ebx
	push	  esi
	push	  edi
	mov	  edi,dword [ebp+16]
	mov	  esi,dword [ebp+8]
   ; ESI = context, EDI = len
@5:
	mov	  eax,dword [esi+20]
	shr	  eax,3
	and	  eax,63
	mov	  edx,edi
	shl	  edx,3
	add	  dword [esi+20],edx
	mov	  ecx,dword [esi+20]
	mov	  edx,edi
	shl	  edx,3
	cmp	  ecx,edx
	jae	  @6
	inc	  dword [esi+24]
@6:
	mov	  ecx,edi
	shr	  ecx,29
	add	  dword [esi+24],ecx
	lea	  edx,dword [edi+eax]
	cmp	  edx,63
	jbe	   @7
	mov	  ebx,64
	sub	  ebx,eax
	add	  eax,esi
	add	  eax,28
cinvoke memcpy,eax,dword [ebp+12],ebx
	lea	  eax,dword [esi+28]
	push	  eax
	push	  esi
	call	  _SHA1Transform
	add	  esp,8
	jmp	   @9
@8:
	mov	  edx,dword [ebp+12]
	add	  edx,ebx
	push	  edx
	push	  esi
	call	  _SHA1Transform
	add	  esp,8
	add	  ebx,64
@9:
	lea	  ecx,dword [ebx+63]
	cmp	  edi,ecx
	ja	    @8
	xor	  eax,eax
	jmp	    @11
@7:
	xor	  ebx,ebx
@11:
	sub	  edi,ebx
	mov	  edx,dword [ebp+12]
	add	  edx,ebx
	add	  esi,eax
	add	  esi,28
cinvoke memcpy,esi,edx,edi
@12:
	pop	  edi
	pop	  esi
	pop	  ebx
	pop	  ebp
	ret


_SHA1Final:
   ;    void SHA1Final(unsigned char digest[20], SHA1_CTX* context)
	push	  ebp
	mov	  ebp,esp
	add	  esp,-8
	push	  ebx
	push	  esi
	mov	  ebx,dword [ebp+12]
	mov	  esi,dword [ebp+8]
@13:
	xor	  eax,eax
@14:
	mov	  edx,eax
	and	  edx,3
	mov	  ecx,3
	sub	  ecx,edx
	shl	  ecx,3
	cmp	  eax,4
	jb	    @16
	xor	  edx,edx
	jmp	    @17
@16:
	mov	  edx,1
@17:
	mov	  edx,dword [ebx+4*edx+20]
	shr	  edx,cl
	and	  dl,-1
	mov	  byte	[ebp+eax-8],dl
	inc	  eax
	cmp	  eax,8
	jb	    @14
	push	  1
	push	   s@
	push	  ebx
	call	  _SHA1Update
	add	  esp,12
	jmp	    @20
@19:
	push	  1
	push	   s@+2
	push	  ebx
	call	  _SHA1Update
	add	  esp,12
@20:
	mov	  eax,dword [ebx+20]
	and	  eax,504
	cmp	  eax,448
	jne	    @19
	push	  8
	lea	  ecx,dword [ebp-8]
	push	  ecx
	push	  ebx
	call	  _SHA1Update
	add	  esp,12
	xor	  eax,eax
@21:
	mov	  edx,eax
	and	  edx,3
	mov	  ecx,3
	sub	  ecx,edx
	shl	  ecx,3
	mov	  edx,eax
	shr	  edx,2
	mov	  edx,dword [ebx+4*edx]
	shr	  edx,cl
	and	  dl,-1
	mov	  byte	[esi+eax],dl
	inc	  eax
	cmp	  eax,20
	jb	    @21
	xor	  ecx,ecx
	mov	  eax,ecx
	lea	  eax,dword [ebx+28]
cinvoke memset,eax,0,64
cinvoke memset,ebx,0,20
	lea	  eax,dword [ebx+20]
cinvoke memset,eax,0,8
	lea	  edx,dword [ebp-8]
cinvoke memset,edx,0,8
	lea	  ecx,dword [ebx+28]
	push	  ecx
	push	  ebx
	call	  _SHA1Transform
	add	  esp,8
@24:
	pop	  esi
	pop	  ebx
	pop	  ecx
	pop	  ecx
	pop	  ebp
	ret

