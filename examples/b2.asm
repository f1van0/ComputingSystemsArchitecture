model small ;?????? ??????
.stack 256 ;?????? ?????
.data
	timeCx dw ? ;????????? ??????????
	A db 1,2,3,4,5,6,7,8,9,11 ;?????? ?
	B db 5,6,4,5,7,8,4,3,2,1  ;?????? B
	C db 10 dup(0) ;?????????????? ??????
	len equ 10 ;????? ????????
.code
	start:
		push @data ;?????????????? ds ?????????? ??????? ??????
		pop ds  ;????? ????
		mov cx,len ;????? ? ?? ?????
		xor si,si ;????????
		xor di,di ;????????
		xor ax,ax ;????????
	for1:
		push cx ;?????????
		mov cx,len ;????? ?????
		xor di,di ;????????
	for2:
		mov bl,A[si] ;????? ??????? ??????? ???????
		cmp bl,B[di] ;??????, ???? ?? ?? ??????
		jne metka ;???? ???, ?? ?????
		push si ;???? ????
		mov si,ax ;?? ????? ? ?????????
		mov C[si],bl ;????? ???????
		inc ax ;????????? ? ??????????
		pop si ;????????? si ?? ?????
	metka:
		inc di ;????????? di
	loop for2 ;????????? ????
		pop cx ;?????????? ??
		inc si ;????????? si
	loop for1 ;????????? ????
		mov cx,len ;????? ? ?? ?????
		xor si,si ;???????? si
	lea bx,C
	call iskl ;???????? ?????????
 	exit: ;?????
		mov ax,4c00h ;??????????? ?????
		int 21h ;?????????? DOS
	iskl proc ;????????? ??? ?????????? ?????????? ?????????
	cicl1: ;????? ?? ???????
		push cx  ;?????????
		mov timeCx,cx  ;???????? ?? ????????? ?????????
		mov cx,len ;?????????? ?? ?????
		sub cx,si ;?????? ??, ??? ??? ??????
		mov di,si ;??????????? si ? di
		push si ;????????? ? ????
	cicl2:  ;????? ?? ??????? ? ???? ?????????? ????????
		inc di ;????????? ??????
		mov al,[bx][si] ;???????? ? ??????? ??????? ??????? ???????
		push cx  ;????????? ??
		mov cx,len ;???????? ? ?? ?????
		sub cx,di  ;?????? ??????? ??????
		push si  ;????????? si
		cmp al,[bx][di] ;??????????? ? ???????
		push di ;????????? di
		jne next ;???? ?? ????? ?? ?? next
		dec timeCx ;????? ????????? ????? ???????
	cicl3:  ;???????? ??? ???????? ?????
		mov si,di ;????? ? si di
		inc di ;???????????
		mov al,[bx][di]  ;????? ????????? ? al
		mov [bx][si],al  ;????? ?? al ? ???????
		inc si ;????????? ? ??????????
	loop cicl3 ;????? ?????
	next:
		pop di ;????????? ?? ?????
		pop si ;????????? ?? ?????
		pop cx ;????????? ?? ?????
	loop cicl2 ;????? ?????
		pop si ;????????? ?? ?????
		pop cx ;????????? ?? ?????
		mov cx,timeCx ;???????? ? ?? ??????? ????? ???????
		inc si ;?????????
	loop cicl1  ;????? ?????
		xor si,si ;????????
		xor di,di ;????????
		mov cx,len ;???????? ?????
	cicl: ;???? ??? ?????????? ???????? ?????, ????? ?????? ???? ?????? ????????
		mov al,[bx][si] ;????? ???????
		cmp [bx][si+1],al ;?????????? ?? ?????????
		push cx ;????????? ??
		jne n ;???? ?? ???????, ?? ?? n
	incicl:  ;?????
		mov di,si ;???????? ???, ??? ??????
		inc di ;?????????
		mov al,[bx][di] ;????? ???????????
		mov [bx][si],al  ;???????? ?? ???????
		inc si ;????????? ? ??????????
	loop incicl ;????? ?????
	n:
		pop cx ;????????? ?? ?????
		inc si ;?????????
	loop cicl ;????? ?????
		xor si,si ;????????
	ret ;???????
	iskl endp ;????? ?????????
end start ;????? ????? - ???? ? ?????????
