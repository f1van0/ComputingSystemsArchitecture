;лабораторная №1
model small
.stack	100h
.data
len equ	10	;количество элементов в mas
res   db    10 dup(?)
.code
start:
	mov	ax,@data
	mov	ds,ax
	mov	cx,len	;длину поля mas в cx
	xor si,si
	jcxz	exit	;проверка cx на 0, если 0, то на выход
cycl:
	xor ax,ax
	mov ax,si
	mul si
	mov res[si],al
nxt:
	inc si	;перейти к следующему элементу
	loop cycl
exit:
	mov	ax,4c00h
	int	21h	;возврат управления операционной системе
end	start

