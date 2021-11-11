model small
.stack 100h	

.data
x dd 1
a dd 3
y dd 0

.code	
org 100h 

start:
mov ax,@data
mov ds,ax

.386
.287
finit
fld x
fld a
fmul
;fldl2e
;fmul
;fld     st
;frndint
;fsub    st(1), st
;fxch    st(1)
;f2xm1
;fld1
;fadd
;fstp    st(1)
fst y

mov ax, 4c00h
int 21h
end start