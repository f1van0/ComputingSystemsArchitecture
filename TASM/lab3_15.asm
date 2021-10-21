model small
.stack 100h
.data
indent db 60
currentRow db 00h
colsEraser db 0
rowsCount equ 10
colsCount equ 3
.code
start:
mov ax, @data
mov ds,ax
mov colsEraser, colsCount ;стиратель колонок должен знать сколько колонок будет заполнено
inc colsEraser            ;для сокращения количества итераций можно увеличить его значение на 1

MOV  AH,05       ;задать активную страницу
MOV  AL,01h      ;активная страница = 01h
INT  10H         ;прерывание

;   {Цикл анимации передвижения колонок влево}
cycleMoveLeft:
;   {Цикл для заполнения нужного числа строк символами}
cycleDrawRow:
;[Этап задания положения курсора]
MOV  AH,02      	   ;установить позицию курсора:
MOV  BH,01h     	   ;на странице 01h
MOV  DH,currentRow     ;на строку currentRow
MOV  DL,indent  	   ;на столбец (отступ) в строке indent
INT  10H        	   ;прерывание

;[Этап стирания с экрана прошлых выведенных символов]
MOV  AH,09          ;вывести символ
MOV  AL,100         ;пустой символ
MOV  BL,00H			;с черным цветом
MOV  CL, colsEraser ;colsEraser раз
INT  10H            ;прерывание

;[Этап вывода символов colsCount раз]
MOV  AH,09          ;вывести символ
MOV  AL,24H         ;символ $
MOV  BL, 0A0H		;с черным цветом шрифта и зеленым цветом фона
MOV  CL, colsCount  ;colsCount раз;
INT  10H            ;прерывание

;[Этап после вывода одной строки на экран]
inc currentRow             ;текущая строка увеличивается на 1 для следующей итерации
cmp currentRow, rowsCount  ;текущая строка сравнивается с заданным количеством строк
jb cycleDrawRow			   ;если первое < второго, то переход на метку

;[Этап после вывода всех строк на экран]
mov cx, 1   	  ;интервал (задержка)
mov ah, 86h 	  ;системный таймер
int 15h			  ;прерывание
mov currentRow, 0 ;текущая строка зануляется
cmp indent, 0 	  ;если отступ = 0
	jbe endd 	  ;выйти из цикла
dec indent        ;иначе уменьшить отсутп indent
jmp cycleMoveLeft ;перейти к метке cycleMoveLeft


endd:
mov ah, 4Ch
int 21h
end start