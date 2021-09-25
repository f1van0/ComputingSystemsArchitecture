model small
.stack 100h
.data
k db 0
n equ 5
m equ 3    
.code
start:   
mov ax,@data
mov ds,ax 
mov ax,n
sbb ax,m
call fac
push ax
mov ax,m
call fac
mov dx,ax
pop ax
mul dx
push ax
mov ax,n
call fac
pop dx
div dl
xor bx,bx
mov cx,ax
;inc bx
;mov k,dl
;cycl1:
;cmp al,k
;je k1
;push ax
;mov al,k
;mul bx
;mov k,al
;pop ax
;inc bx
;loop cycl1
;k1:
;cycl2:    
;cmp al,0
;jle k1
;sbb ax,dx
;inc bx
;loop cycl2
;k1:
jmp m1
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