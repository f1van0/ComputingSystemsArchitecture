model tiny
.stack 100h
.data
	MIN    db ?
	COLS      db 6
	ROWS      db 4
	Matrix db 1, 7, 3, 9, 4, 8
		   db 3, 1, 5, 4, 2, 1
		   db 4, 10, 3, 13, 2, 5
		   db 11, 4, 15, 8, 1, 9
.code
	org     100h

;Процедура поиска максимального значения в строке матрицы
findMaxElement PROC 
	xor ax, ax ; пусть ax выступает переменной, в которой будет хранится максимальное значение
	MOV CX, 6 ; определяем количество итераций, в нашем случае их 6
	findMaxLoop: ; цикл поиска максимального значения
		MOV DL, [BX]
		CMP AL, [BX] ; сравнивается 1 байтового значения регистра al и 1 байтового значения по адресу, записанному в bx
		JG exit ; если да, то 
			mov AL, [BX] ; записываем значение по адресу bx в регистр al
		exit:
		INC BX ; смещаем адрес на следующий элемент
	LOOP findMaxLoop
RET
findMaxElement ENDP

	start:
	    mov AX, @data
	    mov DS, AX
		xor AX, AX

		LEA  BX, Matrix ; Получение адреса первого элемента Matrix
		CALL findMaxElement
		MOV MIN, AL

		XOR CX, CX
		DEC ROWS ; так как 1 строка уже пройдена, осталось пройти ROWS - 1 строк
		MOV AH, ROWS
		MOV CL, AH

		XOR AX, AX
		loopRows:
			PUSH CX ; сохранение значения счетчика CX, чтобы его не потерять
			CALL findMaxElement
			CMP AL, MIN ; сравнение значения, пришедшего из функции findMaxElement, и MIN
			JG exit1 ; если MIN больше AL да, то 
				mov MIN, AL ; записываем значение AL в MIN
			exit1:
			POP CX
		LOOP loopRows

		XOR AX, AX
		MOV AL, MIN ; Минимальное значение среди максимальных записывается в AL

mov ax, 4c00h
int 21h
end start
