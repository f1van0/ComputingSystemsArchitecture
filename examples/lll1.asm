model small
.stack 100h
.data
mas db 1,14,9,10,13,7,1,12,6,5
res db 0,0,0,0,0,0,0,0,0,0
len equ 10 
.code   
start:   
mov ax,@data
mov ds,ax
mov cx,len
xor si,si 
xor di,di
jcxz exit
cycl:
xor si,si 
push cx
mov cx,len
cycl1:
xor ax,ax
mov al,res[di]
cmp mas[si],al
ja m1
jmp m2
m1: 
xor al,al
mov al,mas[si]
mov res[di],al
mov dx,si
m2: 
inc si
loop cycl1
pop cx
mov si,dx
mov dl,0
mov mas[si],dl
inc di
loop cycl
exit:
mov ax,4c00h
int 21h
end start 
