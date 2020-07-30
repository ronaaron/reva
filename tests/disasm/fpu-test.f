needs tester.f

details on
suppress-dword off

t: fadd qword [esi]
t: fadd dword [eax+ebx]
t: fadd st0, st5
t: fadd st6, st0
t: faddp st7
t: faddp
t: fiadd word [eax]
t: fiadd dword [edx]

t: fbld [esi+ebp+$12345678]
t: fbstp [ebx]

t: fcmovb st0, st1
t: fcmove st0, st2
t: fcmovbe st0, st3
t: fcmovu st0, st4
t: fcmovnb st0, st5
t: fcmovne st0, st6
t: fcmovnbe st0, st7
t: fcmovnu st0, st0

t: fcomi st0, st2
t: fcomip st0, st3
t: fucomi st0, st5
t: fucomip st0, st7

t: fcos
t: fdecstp

t: fdiv qword [esi]
t: fdiv dword [$1000]
t: fdiv st0, st2
t: fdiv st4, st0
t: fdivp st7
t: fdivp
t: fidiv dword [ebx]
t: fidiv word [edx]

t: fdivr qword [edi]
t: fdivr dword [ebp+$1000]
t: fdivr st0, st2
t: fdivr st4, st0
t: fdivrp st6
t: fdivrp
t: fidivr dword [eax]
t: fidivr word [ecx]

t: ffree st0

t: ficom word [esi]
t: ficom dword [edi]
t: ficomp dword [esp]
t: ficomp word [esi]

t: fild dword [eax]
t: fild word [eax]
t: fild qword [eax]

t: fincstp

t: fist dword [eax]
t: fist word [ebx]
t: fistp word [edi]
t: fistp qword [edi+esi*2]
t: fistp dword [esp]

t: fisttp word [eax]
t: fisttp dword [eax]
t: fisttp qword [eax]

t: fld dword [ebx]
t: fld qword [ebx]
t: fld tword [ebx]
t: fld st1

t{ fld1 fldl2t fldl2e fldpi fldlg2 fldln2 fldz }

t: fldcw [edx]
t: fldenv [edi]

t: fmul qword [esi]
t: fmul dword [eax+ebx]
t: fmul st0, st2
t: fmul st3, st0
t: fmulp st5
t: fmulp
t: fimul word [ebx]
t: fimul dword [esi+ebp]

t{ fnop fpatan fprem fprem1 fptan frndint }

t{ fscale fsin fsincos fsqrt }

t: fst dword [eax]
t: fst qword [eax]
t: fst st5
t: fst st1
t: fstp dword [0]
t: fstp qword [edi]
t: fstp tword [esi]
t: fstp st4
t: fstp st1

t: fsub qword [esi]
t: fsub dword [eax+ebx]
t: fsub st0, st2
t: fsub st4, st0
t: fsubp st3
t: fsubp
t: fisub word [ebx]
t: fisub dword [esi+ebp]

t: fsubr qword [esi]
t: fsubr dword [eax+ebx]
t: fsubr st0, st2
t: fsubr st4, st0
t: fsubrp st2
t: fsubrp
t: fisubr word [ebx]
t: fisubr dword [esi+ebp]

t: ftst

t: fucom st0, st2 
t: fucom st0, st1
t: fucomp st0, st5
t: fucompp

t: fxam 

t: fxch st5
t: fxch

t: fxtract
t{ fyl2x fyl2xp1 }
test bye
