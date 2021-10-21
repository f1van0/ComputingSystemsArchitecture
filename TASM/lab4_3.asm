model tiny ; сообрается, что в программе будет использоваться одель малой памяти,
            ; где всего один сегмент кода, один сегмент данных, один сегмент стека
.stack 100h ; определяется объем стека, резервируется 100h байт
.data ; блок с заданием переменных
strEnterChar db 'Enter target char:',10,13,'$' 
newline db 10,13,'$'
strEnterString db 'Enter string:',10,13,'$' 
strAnswer db 'Answer:',10,13,'$' 
targetChar DB ?
resultString DB 100 ("$")

.code ; блок с кодом
start: ; функция start (с неё всё начинается)
    org 100h
    mov ax, @data ; .data помещен в регистр ax
    mov ds, ax ; теперь сегмент данных ds указывает на .data
    xor ax, ax

    mov ah, 09h
    mov dx, offset strEnterChar ;вывод сообщения о вводе символа, который будет убран из строки
    int 21h

    mov ah, 01h ;ввод символа, который будет убран из строки
    int 21h
    mov targetChar, al

    mov ah, 09h
    mov dx, offset newline ;переход на новую строку
    int 21h

    mov ah, 09h
    mov dx, offset strEnterString ;вывод сообщения о вводе строки
    int 21h

    mov cl, 0 ;обнуление счетчика для подсчета символов
    lea bx, resultString ; запись в bx адреса первого элемента resultString
    inputLoop:
        mov ah, 01h ;ввод очередного символа
        int 21h

        cmp al, targetChar ;введен символ, который нужно убрать?
        je ignore ;если да, то пропустить 3 команды ниже
            mov [BX], al ;очередной символ помещается в стек
            inc cl ;кол-во символов увеличивается
            inc BX ;итерирование по массиву 
        ignore:

        cmp al, 13 ;нажата клавиша Enter?
        je endInput ;закончить ввод
        jmp inputLoop ;иначе продолжить ввод
    endInput:

    mov ah, 09h
    mov dx, offset newline ;переход на новую строку
    int 21h

    mov ah, 09h
    mov dx, offset strAnswer ;вывод строки "Answer"
    int 21h

    lea BX, resultString
    outputLoop:
        mov dl, [BX] ;вывод символа из массива resultString
        mov ah, 02h
        int 21h
        inc BX ;итерирование по массиву
        dec cl ;уменьшение значение счетчика на 1
        cmp cl, 0 ;если значение счетчика = 0
        je endOutput ;то выйти из цикла
        jmp outputLoop ;иначе перейти по метке outputLoop
    endOutput:

    mov ax, 4c00h
    int 21h
end start