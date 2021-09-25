model small ; сообрается, что в программе будет использоваться одель малой памяти,
            ; где всего один сегмент кода, один сегмент данных, один сегмент стека
.stack 100h ; определяется объем стека, резервируется 100h байт
.data ; блок с заданием переменных
xcoord db 50 ; составляющая x точки O
ycoord db 38 ; составляющая y точки O
radius db 100 ; радиус
answ db 4Eh ; переменная, отвечающая за ответ на задачу

.code ; блок с кодом
start: ; функция start (с неё всё начинается)
mov ax, @data ; .data помещен в регистр ax
mov ds, ax ; теперь сегмент данных ds указывает на .data

;код расчета x ^ 2
xor ax, ax ; логическое или xor с повторяющимися регистрами ax, ax меняет значение в регистре ax на 0
mov al, xcoord ; переводит значение xcoord в регистр al
mul xcoord ; умножение mul работает с al и в данном умножает al на xcoord
mov bx, ax ; bx = ax (bx = xcoord ^ 2)

;код расчета y ^ 2 и расчёт x ^ 2 + y ^ 2
xor ax, ax
mov al, ycoord
mul ycoord
add bx, ax ; bx = bx + ax (bx = xcoord ^ 2 + ycoord ^ 2)

;код расчета R ^ 2 и изменение answ при условии, что R ^ 2 >= x ^ 2 + y ^ 2
xor ax, ax
mov al, radius
mul radius
cmp ax, bx ; ax (radius ^ 2) > bx (xcoord ^ 2 + ycoord ^ 2)?
jb exit ; если да, то 
mov answ, 59h ; записываем символ Y в answ
exit:

;код вывода ответа answ в консоль
mov dl, answ ; пока что не работает ; по идее, dx указывает на смещение answ в сегменте .data
mov ah, 02h ; вывод символа на экран
int 21h

mov ah, 4Ch ; либо 4c00h посылает шестнадцатиричную команду в ячейку ah, чтобы завершить программу
int 21h ; прерывание
end start ; конец start
