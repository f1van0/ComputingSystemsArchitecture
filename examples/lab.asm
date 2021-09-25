masm
model small
.stack 256
.data
len equ 9
a db 1,2,3,4,5,6,7,8,9,10
.code
start: mov ax,@data
       mov ds,ax
       mov cx,len
       xor si,si
cycl1: mov ax, si
mov di, ax
cycl2: mov bl, a[di]
cmp a[si],bl
jae M1
mov al, a[si]
mov a[si], bl
mov a[di], al
M1:
inc di
cmp di, len
jle cycl2
inc si
loop cycl1
exit:
    mov ax, 4c00h
int 21h
end start
