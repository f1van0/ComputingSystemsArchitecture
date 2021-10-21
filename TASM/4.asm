model small
.stack 100h
.data
str1 db 50 dup("$")
str2 db 2 dup(?)
.code
start:
mov ax,@data
mov ds,ax
mov	es,ax
xor	ax,ax
 ;первая строка
 mov ah,0Ah
 mov cx,50
 mov bx,0
 mov dx, offset str1
 int 21h

mov ax,4c00h
int 21h
end start