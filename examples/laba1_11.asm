;������ୠ� �1
model small
.stack	100h
.data
len equ	10	;������⢮ ����⮢ � mas
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
	mov ax,si
	mul si
	mov res[si],al
nxt:
	inc si	;��३� � ᫥���饬� ������
	loop cycl
exit:
	mov	ax,4c00h
	int	21h	;������ �ࠢ����� ����樮���� ��⥬�
end	start

