model small
.stack 100h	
.data

tmp dd ?
x dd 250.0
y dd 2.0
a dd 400.0
t1 dd ?
t2 dd ?
t3 dd ? 
somePower dd 0.1617;

.code	
org 100h 

start:
mov ax,@data
mov ds,ax
;Здесь немного написал, как получить число е, или как возвести число е в степень a, где 0 < a < 1 (0.391 и типа того).
;А как возвести число е в степень, например 12.9146 уже сам(а) додумаешь, это пустяк.
.386
.287
FNINIT 

;COUNT E
FLDL2E
mov eax, 1
mov tmp, eax
FISUB tmp
F2XM1
mov eax, 1
mov tmp, eax
FIADD tmp
mov eax, 2
mov tmp, eax
FIMUL tmp
FST tmp
;COUNT EPOWER < 1
;402DF8

FNINIT 
;Посчитать e^a, где 0 < a < 1
FLDL2E
mov eax, 1
mov tmp, eax
FISUB tmp
mov eax, somePower
mov tmp, eax
FMUL somePower
F2XM1
mov eax, 1
mov tmp, eax
FIADD tmp
mov eax, somePower
mov tmp, eax
FLD tmp
F2XM1
mov eax, 1
mov tmp, eax
FIADD tmp
FMUL
FST tmp

mov ax, 4c00h
int 21h
end start