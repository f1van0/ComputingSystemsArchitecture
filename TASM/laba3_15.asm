model small
.stack 100h
.data
indent db 60
currentRow db 00h
space db 0
rowsCount equ 10
colsCount equ 3
.code
start:
mov ax, @data
mov ds,ax
mov space, colsCount ;������� ������� ����� ���������� �������� � ������
inc space            ;������� ������� ������������� �� 1, ����� ��������� ���������� �������� � �������

MOV  AH,05       ;������ �������� ��������
MOV  AL,01h      ;�������� 01h
INT  10H         ;����������

;   {���� ��� ��������������� �������� �������� �������� �����}
cycle1:
;   {���� ��� ������������ �� �������. ����� �������� �� ������ �������}
cycle2:
;[���� ��������� ������� ������� � ������ ����� ������]
MOV  AH,02      	   ;���������� ������� �������
MOV  BH,01h     	   ;�� �������� 01h
MOV  DH,currentRow     ;�� ������ currentRow
MOV  DL,indent  	   ;� ������ ������� ������ indent
INT  10H        	   ;����������

;[���� �������� ������� ������� � �������]
MOV  AH,09          ;�������� ������ �� ������� �������
MOV  AL,255         ;������ ������
MOV  BL,00H			;������� �����
MOV  CL, space      ;space ���
INT  10H            ;����������

;[���� ������ ������������ �������� colsCount ���]
MOV  AH,09          ;����� ������
MOV  AL,24H         ;����� ������� $
MOV  BL, 0A0H		;���� ������ � ����, 0A0H - ���� ������ ������, � ������� �������, ����� ������
MOV  CL, colsCount  ;colsCount ���;
INT  10H            ;����������

inc currentRow             ;����� ������ �������������
cmp currentRow, rowsCount  ;������������ � �������� ����������� ����� ��� ������
jb cycle2				   ;���� ����� ������ ������ ��������� ����������, �� ���������� ������� � ����� cycle2

mov cx, 1   	  ;����� ��������� (��������)
mov ah, 86h 	  ;��������� ������
int 15h			  ;����������
mov currentRow, 0 ;������� ������ ���������� = 0, �����, � ������ �����������, �������������� ����� �� ���������� �����
cmp indent, 0 	  ;���� �������� �� ������ ���� ������ = 0, ��
	jbe endd 	  ;����� (�������� �����������)
dec indent        ;����� ���������� �������� �� 1

jmp cycle1 ;������� � ����� cycle1

endd:
mov ah, 4Ch
int 21h
end start