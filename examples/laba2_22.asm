model small
.stack	100h
.data
m	db 3
n	db 5
fac	db 0
fac_n	db 0
fac_m	db 0
resul	dw 0

.code
;
;
factorial proc near
	mov	ax,1
cycle:
	cmp	cx,1
	je	exit	
	mul	cx
	loop	cycle
exit:
ret
factorial endp
;
;

start proc
	mov ax,@data
	mov ds,ax
	xor	dx,dx
	xor	ax,ax
	xor	cx,cx
	mov	cl,n
	sub	cl,m
	call	factorial
	mov	fac,al
	mov	cl,n
	call	factorial
	mov	fac_n,al
	mov	cl,m
	call	factorial
	mov	fac_m,al
	mov	al,fac_m
	mul	fac
	mov	dx,ax
	xor	ax,ax
	mov	al,fac_m
	push dx
	xor dx,dx
	pop dx
	div	dx
	mov	resul,dx
	mov	ax,4c00h
	int	21h	;возврат управления операционной системе
start endp
end	start