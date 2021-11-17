model small
.stack 100h	

.data
x dd 4
a dd 0.17
temp dd ?
temp2 dd ?
c1 dd 1
c2 dd 2
c3 dd 3
c4 dd 4
c5 dd 5
c6 dd 6
c7 dd 7
c12 dd 12
c14 dd 14
c36 dd 36

.code	
org 100h 

start:
mov ax,@data
mov ds,ax

.386
.287
FNINIT ;Это чтобы обновить всё для работы с сопроцессором

;подсчет знаменателя 2+6*cos(x - a)
FILD c4
FSUB a
FCOS ;-0.77225882
FIMUL c6
FIADD c2

;подсчет числителя 36 + 4*5 и помещение его значения в ST0
FILD c4 ;знаменатель из ST0 перешел в ST1
FIMUL c5
FIADD c36

;подсчет первой части числителя (36 + 4*5)/(2+6*cos(x - a)) и сохранение во временную переменную temp
FDIV ST(0), ST(1)
FST temp

;подсчет второй части числителя (...) - 14/7 + 1
FILD c14
FIDIV c7
FCHS ;изменение знака
FIADD c1

;суммирование обеих частей числителя и полученное значение вносится во временную переменную temp
FADD temp
FST temp

;сброс всех ST
FNINIT
;подсчет первой части знаменателя 36-4/2 и запись результата во временную переменную temp2
FILD c36
FISUB c4
FIDIV c2
FIST temp2

;подсчет второй части знаменателя 12*sin(x+a)
FILD x
FADD a
FSIN ;-0.8564779
FIMUL c12

;сложение двух частей знаменателя
FIADD temp2

;подсчет полной первой дроби и занесение получившегося значения во временную переменную temp
FLD temp
FLD temp
FDIV ST(0), ST(2)
FST temp

;снова сбрасываются значения ST
FNINIT

;подсчет числа e^(x*a)
FILD x
FMUL a

FLDL2E
FISUB c1
FMUL ST(0), ST(1)
F2XM1
FIADD c1
FLD ST(1)
F2XM1
FIADD c1
FMUL
FST temp2

;подсчет числителя (3*e^(x*a)+4)
FIMUL c3
FIADD c4

;подсчет знаменателя 12 - 7
FILD c12
FISUB c7

;подсчет дроби (3*e^(x*a)+4) / (12 - 7)
FXCH ST(1)
FDIV ST(0), ST(1)

;подсчет всей правой части 7*6*(дробь)
FIMUL c7
FIMUL c6

;получение ответа
FLD temp
FSUB ST(0), ST(1)
FST temp

;-87.23249536...

mov ax, 4c00h
int 21h
end start