model small
.stack 100h
.data
.code

tyu proc near
mov ah,01
mov ch,00
mov cl,7
int 10h

mov ah,02
mov bh,00
mov dh,19 ; y
int 10h

mov ah,03 ; положение курсора
mov bh,00
int 10h

mov ah,09 ; вывод
mov al,03H
mov bh,00
mov bl,1
mov cx,01 
int 10h

mov dh,19
mov si,0
cicl:
mov ah,02 ; положение курсора
mov bh,00
int 10h
inc dh
cmp dh,27
jbe cicl
ret
tyu endp

gorizont proc near
MOV  AH,01     ;Установить размер курсора
MOV  CH,00     ;Верхняя линия сканирования
MOV  CL,7     ;Нижняя линия сканирования
int 10h
MOV AH,02          ;Установить положение курсора
MOV BH,00          ;Страница 0 
MOV DL,35     ;Столбец              
int 10h

mov ah,09
mov al,03H
mov bh,00
mov bl,1
mov cx,10 
int 10h
ret
gorizont endp


START:
mov ax,@data
  mov ds,ax

mov ah,00
mov al,03   
int 10h

mov ah,05;Установить активную страницу
mov al,0
int 10h

mov ah,01;Установить размер курсора
mov ch,00 ;Верхняя линия сканирования
mov cl,7;Нижняя линия сканирования
int 10h
mov ah,02;Установить положение курсора
mov bh,00;Страница 0
 mov dh,18;Строка
mov dl,35;Столбец              
int 10h
mov ah,03
mov bh,00     
int 10h
               
mov ah,4
int 10h 

mov dl,35
call tyu
mov dl,45 
call tyu
mov dh,18
call gorizont
mov dh,28
call gorizont
mov ax,4c00h
  int 21h
end start







