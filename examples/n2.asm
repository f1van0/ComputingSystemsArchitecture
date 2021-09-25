model small
.stack 100h
.data
res1 db 0
res2 db 0
n equ 5
m equ 3
k equ 6
l equ 4
.code
    
start:   
mov ax,@data
mov ds,ax
mov cx,m 
mov ax,n
call prog
mov res1,al
mov ax,k
mov cx,l
call prog
mov res2,al

jmp m1
prog proc
push ax
push cx
sbb ax,cx
call fac
pop cx
push ax
mov ax,cx
call fac
mov dx,ax
pop ax
mul dx
pop cx
push ax
mov ax,cx
call fac
pop bx
div bx
ret
prog endp 

fac proc
xor bx,bx 
mov bx,1
mov cx,ax 
mov ax,1
cycl:    
mul bx 
inc bx
loop cycl
ret
fac endp
m1:
 
exit:
mov ax,4c00h
int 21h
end start 