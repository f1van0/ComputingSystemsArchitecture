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

;Данные по значению A
valueIntA dw ?

;Данные по значению B
valueIntB dw ?

;Ответ
answer db ?

;Путь к файлу
path db "testasm.txt", 0

;Буффер для вывода
buf	DB ?	

;Временная переменная
temp DB '', 0
len db 0 

identf dw ?

.code ; блок с кодом

PrintNumber proc
    ;число находится в индексе dl
    xor cl, cl
    mov al, answer
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

PrintNumberic2 proc
        ;цифра в al
        ;вывод цифры al на экран в виде символа
        add al, 48
        mov dl, al ;вывод цифры al на экран в виде символа
        mov ah, 02h
        int 21h
        ret
PrintNumberic2 endp

PrintNumberic proc
        ;цифра в al
        ;вывод цифры al на экран в виде символа
        add al, 48
        mov temp, al

        PUSH AX
        PUSH BX
        PUSH DX
        PUSH CX

        MOV   AH,  40h	        ;Записываем в файл
   	    mov   BX, identf		        ;Идентификатор файла
   	    MOV   DX,  offset temp	;Адрес буфера с данными
   	    MOV   CX,  1	    	;Будем записывать значение из temp
   	    INT   21h	        	;Вызов функции 40h

        POP CX
        POP DX
        POP BX
        POP AX
        
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

    mov answer, dl

    ;Создание нового файла\перезапись существующего файла
    MOV   AH,  3Ch
   	MOV   CX,  0		    ;Атрибуты файла
   	MOV   DX,  offset path	;Путь к файлу
   	INT   21h		        ;Вызов функции 3Ch 

    ;Открытие файла для записи           
   	PUSH  AX		        ;Помещаем в стек идентификатор файла
    mov identf, AX
   	MOV   AX,  3D02h
   	MOV   DX,  offset path	;Путь к файлу
   	INT   21h		        ;Вызов функции 3Dh

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    call PrintNumber

    POP DX
    POP BX
    POP CX
    POP AX

    ;Открытие файла на чтение
   	MOV   AX,  3D00h    	;Открываем файл для чтения
   	MOV   DX,  offset path	;Путь к файлу
   	INT   21h	        	;Вызов функции 3Dh
    
    ;Чтение из файла
   	PUSH  AX	        	;Помещаем в стек идентификатор файла
   	MOV   AH,  3Fh		    ;Читаем из файла
   	POP   BX	        	;Идентификатор файла
   	MOV   DX,  offset buf	;Адрес буфера для данных
   	INT   21h

    ;Закрытие файла
   	MOV   AH,  3Eh
   	INT   21h

   	MOV   DI,  offset buf	    ;Адрес буфера с прочитанными данными
	MOV   BX,  7		        ;BX = количеству символов в строке
	MOV   BYTE PTR [DI+BX], '$' ;К буферу в конец добавляет знак $, чтобы можно было его сразу вывести на экран

    ;Выводим результат на экран
   	MOV   AH,  9
   	MOV   DX,  offset buf
   	INT   21h

    ; конец программы
    mov ax, 4c00h
    int 21h
end start

