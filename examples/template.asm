model small
.stack	100h
.data

<��।������ ��६�����>

.code
start:
	mov	ax,@data
	mov	ds,ax

<��� �ணࠬ��>

exit:
	mov	ax,4c00h
	int	21h	;������ �ࠢ����� ����樮���� ��⥬�
end	start

