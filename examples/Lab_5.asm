.386
.model small
.stack 256h

.data
	m1 dd 7.0
	m2 dd 4.0
	m3 dd 6.0
	m4 dd 5.0
	m5 dd 2.0
	m6 dd 3.0
	m7 dd 13.0
	m8 dd 14.0
	m9 dd 36.0
	m10 dd 17.0
	
	x dd 2.0
	a dd 1.0
	
	y dd 0.0
	
	cwr dw ?
	
	
.code

main:
	mov ax, @data
	mov ds, ax
	
	finit
	;
	fild m3
	fmul m2 ; st(0) = 6*4
	fadd m1 ; st(0) = 7+6*4

	fld a			; st(0) = a st(1) = 7+6*4
	fdiv m6		; st(0) = a/3 st(1) = 7+6*4
	fadd x 		; st(0) = a/3+x st(1) = 7+6*4
	fsin 		; st(0) = sin(a/3+x) st(1) = 7+6*4
	fld m5		; st(0) = 2 st(1) = sin(a/3+x) st(2) = 7+6*4
	fsubr 		; st(0) = 2-sin(a/3+x) st(1) = 7+6*4
	fld m4	  	; st(0) = 5 st(1) = 2-sin(a/3+x) st(2) = 7+6*4
	fdivr 		  ; st(0) = 5/(2-sin(a/3+x)) st(1) = 7+6*4
	fmul m7  	; st(0) = 5/(2-sin(a/3+x))*13 st(1) = 7+6*4
	fadd 		 ; st(0) = 5/(2-sin(a/3+x))*13+7+6*4

	fld m9 ; st(0) = 36    st(1) = 5/(2-sin(a/3+x))*13+7+6*4
	fsub m2 ; st(0) = 36-4    st(1) = 5/(2-sin(a/3+x))*13+7+6*4
	fdiv m6 ; st(0) = (36-4)/3    st(1) = 5/(2-sin(a/3+x))*13+7+6*4
	fadd m5 ; st(0) = ((36-4)/3)+2    st(1) = 5/(2-sin(a/3+x))*13+7+6*4
	
	fld m10	; st(0) = 17   st(1) = ((36-4)/3)+2    st(2) = 5/(2-sin(a/3+x))*13+7+6*4
	fmul m3 ; st(0) = 17*6   st(1) = ((36-4)/3)+2    st(2) = 5/(2-sin(a/3+x))*13+7+6*4
	
	fld m8 ; st(0) = 14    st(1) = 17*6   st(2) = ((36-4)/3)+2    st(3) = 5/(2-sin(a/3+x))*13+7+6*4
	fsub m2 ; st(0) = 14-4    st(1) = 17*6   st(2) = ((36-4)/3)+2    st(3) = 5/(2-sin(a/3+x))*13+7+6*4
	fdiv m5 ; st(0) = (14-4)/2   st(1) = 17*6   st(2) = ((36-4)/3)+2    st(3) = 5/(2-sin(a/3+x))*13+7+6*4
	
	
	fld x  ; st(0) = x  st(1) = (14-4)/2   st(2) = 17*6   st(3) = ((36-4)/3)+2    st(4) = 5/(2-sin(a/3+x))*13+7+6*4
	fsub a ; st(0) = x-a   st(1) = (14-4)/2   st(2) = 17*6   st(3) = ((36-4)/3)+2    st(4) = 5/(2-sin(a/3+x))*13+7+6*4
	fldl2e
	fmulp st(1), st(0) 	; st(0) = log2(e^(x-a))
	
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
	fmulp st(1), st(0) 	; st(0) = exp^(x-a)   st(1) = (14-4)/2   st(2) = 17*6   st(3) = ((36-4)/3)+2    st(4) = 5/(2-sin(a/3+x))*13+7+6*4 
	
	
	fmul	; st(0) = exp^(x-a)*(14-4)/2  st(1) = 17*6   st(2) = ((36-4)/3)+2    st(3) = 5/(2-sin(a/3+x))*13+7+6*4
	fadd	; st(0) = exp^(x-a)*(14-4)/2 + 17*6  st(1) = ((36-4)/3)+2    st(2) = 5/(2-sin(a/3+x))*13+7+6*4
	fdiv	; st(0) = (exp^(x-a)*(14-4)/2 + 17*6)/(((36-4)/3)+2)  st(1) = 5/(2-sin(a/3+x))*13+7+6*4
	fadd	; st(0) = (5/(2-sin(a/3+x))*13+7+6*4)+(exp^(x-a)*(14-4)/2 + 17*6)/(((36-4)/3)+2) 
 	;	
	fst y
	
	mov ax, 4c00h
	int 21h
end main										