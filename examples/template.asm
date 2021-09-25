model small
.stack	100h
.data

<определение переменных>

.code
start:
	mov	ax,@data
	mov	ds,ax

<код программы>

exit:
	mov	ax,4c00h
	int	21h	;возврат управления операционной системе
end	start

