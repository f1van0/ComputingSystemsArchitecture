;������ୠ� �1
model small
.stack	100h
.data
argument1   equ 2
len equ	10	;������⢮ ����⮢ � mas
mas	db	1,11,9,8,3,7,8,0,2,6
res   db    10 dup(?)
.code
start:
	mov	ax,@data
	mov	ds,ax
	mov	cx,len	;����� ���� mas � cx
	xor si,si
	jcxz	exit	;�஢�ઠ cx �� 0, �᫨ 0, � �� ��室
cycl:
	xor ax,ax
	cmp	mas[si],10	;�ࠢ���� ��।��� ����� mas � 10
	ja  m1	;�᫨ >10, � �� m1 
	mov al,argument1	;㬭������ y=ax
	mul mas[si]
	mov res[si],al
	cmp mas[si],5
	jbe nxt	;�᫨ <=5, � �� nxt
	mov al,argument1
	add res[si],al	;+a
	jmp nxt	
m1:
	mov al,0
	mov res[si],al
nxt:
	inc	si	;��३� � ᫥���饬� ������
	loop cycl
exit:
	mov	ax,4c00h
	int	21h	;������ �ࠢ����� ����樮���� ��⥬�
end	start

