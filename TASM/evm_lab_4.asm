model tiny ; сообрается, что в программе будет использоваться одель малой памяти,
            ; где всего один сегмент кода, один сегмент данных, один сегмент стека
.stack 100h ; определяется объем стека, резервируется 100h байт
.data ; блок с заданием переменных
error db 10,13,"incorrect number$"
newline db 10,13,"$"
buff    db 6,7 Dup('$')

;строки вывода информации
strEnterA db 'Enter A: $'
strEnterB db 'Enter B: $'
strAnswer db 'A + B = $'
endline db 10,13, '$'

strTestA db '4$'
strTestB db '4$'

;Данные по значению A
strIntA label byte
maxLenIntA db 4
lenIntA db ?
valueIntA dw ?;4 Dup('$')

;Данные по значению A
strIntB label byte
maxLenIntB db 4
lenIntB db ?
valueIntB dw ?;4 Dup('$')

answerValue dw ?

.code ; блок с кодом

PrintNumber proc
    ;число находится в индексе dl
    xor cl, cl
    mov al, dl
    xor ah, ah
    mov bl, 100
    div bl ;частное записывается в al, остаток от деления записывается в ah
    mov dh, ah
    cmp al, 0
    je ignoreFirstNumberic
        mov cl, 1 ; вывод сотен произошел удачно
        call PrintNumberic
    ignoreFirstNumberic:

    xor ax, ax
    mov al, dh
    mov bl, 10
    div bl ;частное записывается в al, остаток от деления записывается в ah
    mov dh, ah
    cmp cl, 0
    jne SecondPrint
    cmp al, 0
    jne SecondPrint
    jmp ignore
    SecondPrint:
        call PrintNumberic
    ignore:
    
    mov al, dh
    call PrintNumberic
    xor ax, ax
    ret
PrintNumber endp

PrintNumberic proc
        ;цифра в al
        ;вывод цифры al на экран в виде символа
        add al, 48
        mov dl, al ;вывод цифры al на экран в виде символа
        mov ah, 02h
        int 21h
        ret
PrintNumberic endp

GetNumber proc
    xor dl, dl
        inputLoop:
        xor ax, ax
        ;   посимвольный ввод
        mov ah, 01h ;ввод очередного символа
        int 21h

        cmp al, 13 ;нажата клавиша Enter?
        je endInput ;закончить ввод

        mov cl, al

        xor ax, ax
        mov al, dl ;исходное число умножается на 10
        mov bl, 10
        mul bl
        mov dl, al

        mov al, cl
        sub al, 48 ;перевод числа в десятичную цифру
        add al, dl ;к полученной цифре прибавляется записанное до этого число
        mov dl, al ;получается новое чиcло dl

        jmp inputLoop ;иначе продолжить ввод
    endInput:
    ret
GetNumber endp

start: ; функция start (с неё всё начинается)

    ;org 100h
    mov ax, @data ; .data помещен в регистр ax
    mov ds, ax ; теперь сегмент данных ds указывает на .data
    xor ax, ax

    ;mov dl, 7
    ;call PrintNumber

    ;вывод строки "Ввести A"
    mov ah, 09h
    mov dx, offset strEnterA ;переход на новую строку
    int 21h

    ;ввод числа А
    call GetNumber
    push dx
    
    mov ah, 09h
    mov dx, offset endline ;переход на новую строку
    int 21h

    ;вывод строки "Ввести B"
    mov ah, 09h
    mov dx, offset strEnterB ;переход на новую строку
    int 21h

    ;ввод числа B
    call GetNumber

    pop bx
    mov al, bl
    add al, dl
    mov dl, al

    call PrintNumber
    ;jmp PrintNumber

    ;mov ah, 09h
    ;mov dx, offset endline ;переход на новую строку
    ;int 21h

    ;mov ah, 09h
    ;mov dx, offset strAnswer ;переход на новую строку
    ;int 21h



    ; конец программы
    mov ax, 4c00h
    int 21h

 ;   PrintNumber:
 ;       ;число находится в регистре dh
 ;       
 ;       ret
 ;   end PrintNumber
;
end start

