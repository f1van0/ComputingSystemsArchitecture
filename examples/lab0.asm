.386
.model use32 flat
.data
	x dd 18.7
	a dd 3.4
	y dd 0
	
	cwr dw ?

	mas dw 37,14,5,4,6,17,2
	
.code
	_main:
		finit
		
		fild mas[3]
		fcos 				;st(0)=cos(4)
		fild mas[1]			;st(0)=14 st(1)=cos(4)
		fimul mas[2]			;st(0)=14*5
		fiadd mas			;st(0)=37+14*5
		fdiv				;st(0)= 37+14*5/cos(4)
		
		fild mas[2]			;st(0)= 5 st(1)=(37+14*5)/cos(4)
		fimul mas[4]			;st(0)=5*6
		fld x				;st(0)=x st(1)=5*6 st(2)=(37+14*5)/cos(4)
		fmul				;st(0)=x*5*6 st(1)=(37+14*5)/cos(4)

		fadd				;st(0)=(37+14*5)/cos(4)+x*5*6
		fild mas[3]			;st(0)=4 st(1)=(37+14*5)/cos(4)+x*5*6
		fidiv mas[6]			;st(0)=4/2
		fild mas[5]			;st(0)=17 st(1)=4/2 st(2)=(37+14*5)/cos(4)+x*5*6
		fsub				;st(0)=17-4/2 st(1)=(37+14*5)/cos(4)+x*5*6
		fxch st(1)			;st(0)=(37+14*5)/cos(4)+x*5*6 st(1)=17-4/2 
		fdiv				;st(0)=[(37+14*5)/cos(4)+x*5*6]/[17-4/2]
		
		fild mas[2]			;st(0)=5 st(1)=[(37+14*5)/cos(4)+x*5*6]/[17-4/2]
		fimul mas[4]			;st(0)=5*6
		fld a				;st(0)=a st(1)=5*6 st(2)=[(37+14*5)/cos(4)+x*5*6]/[17-4/2]
		
		; exp(st(0))
		fldl2e
		fmulp st(1), st(0) 		; st(0) := log2(exp^st(1))
						; После finit - поле RC = 00, т.е. округление к ближайшему целом,
						; а надо отбросить дробную часть, т.е. RC := 11.
		fstcw cwr
		or cwr, 11b shl 10
		fldcw cwr
		fld st(0)
		frndint				; st(0) - целая часть от log2(exp^st(1))
		fsub st(1), st(0) 		; st(1) - вещественная часть от log2(exp^st(1))
		fld1
		fscale				; st(0) - 2^[целая часть от log2(exp^st(1))], st(1) - мусор
		fstp st(1)			; st(0) - 2^[целая часть от log2(exp^st(1))], st(1) - вещественная часть от log2(exp^st(1))
		fxch st(1)			; st(0) - вещественная часть от log2(exp^st(1)), st(1) - 2^[целая часть от log2(exp^st(1))]
		f2xm1
		fld1
		fadd				; st(0) - 2^[вещественная часть от log2(exp^st(1))], st(1) - 2^[целая часть от log2(exp^st(1))]
		fmulp st(1), st(0)
		
		fmul				;st(0)=exp(a)*5*6 st(1)=[(37+14*5)/cos(4)+x*5*6]/[17-4/2]
		fadd				;st(0)=exp(a)*5*6+[(37+14*5)/cos(4)+x*5*6]/[17-4/2]
		fst y						
	exit:
		mov ax,4c00h
		int 21
end	_main