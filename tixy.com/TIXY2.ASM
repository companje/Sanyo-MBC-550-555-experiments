	org 0x100
setup:
	mov ax,0x0002
	int 0x10
	mov ax,0x3c00
	mov es,ax
	xor bp,bp
	mov dh,0	; t
draw:
	mov dl,0	; i
	mov bl,0	; y
	mov di,9*320+80	; view top left
repeatY:
	mov bh,0	; x
repeatX:
	push bp
	push bx
	xchg bx,bp
	mov bp,[bx+table]
	and bp,0xff
	or bp,0x100
	pop bx
	call bp
	pop bp

	push bx
	cmp al,0
	jge white
gray:
	mov bx,0xf400
	mov es,bx
	neg al
	call drawchar
	mov bx,0x3c00
	mov es,bx
	mov al,0
	call drawchar
	jmp nextchar
white:
	mov bx,0x3c00
	mov es,bx
	call drawchar
	mov bx,0xf400
	mov es,bx
	call drawchar

nextchar:
	pop bx
	add di,8
	inc dl		; i++
	inc bh		; x++
	cmp bh,16
	jl repeatX
	add di,192+320
	inc bl		; y++
	cmp bl,16
	jl repeatY

key:
	in al,0x38
	cmp al,0x1b
	je end
	mov ah,0
	sub al,0x30
	and al,7
	mov bp,ax

	inc dh		; t++
	jmp draw

end:
	mov ah,0
	int 0x16
	int 0x20

drawchar:
	push di
	push ax
	and al,15	; limit to 4 lower bits [0..15]
	mov cl,8
	mul cl		; ax=al*8

	mov si,ax
	add si,img
	movsw
	movsw
	movsw
	movsw
	add di,320-8
	mov si,ax
	add si,img+128
	movsw
	movsw
	movsw
	movsw
;sub di,320-8
	pop ax
	pop di
	ret

table:	db fx0,fx1,fx2,fx3,fx4,fx5,fx6,fx7

fx0:			; sierpinsky triangle
	mov al,bl
	add al,dh
	and al,bh
	lahf
	xchg ah,al
	and al,0x40
	ret

fx1:			; x*y+t
	mov al,bh
	mul bl
	add al,dh
	ret

fx2:			; noise from timer
	in al,0x22
	ret

fx3:
	in al,0x20	; 0x20 0x22 0x24 are timers
	ret

fx4:			; y-x
	mov al,bl
	sub al,bh
	ret

fx5:			; poging tot binary clock
	mov al,dh
	mov cl,bh
	mov ch,1
	shl ch,cl
	and al,ch
	shr al,1
	shr al,1
	shr al,1
	ret

fx6:			; x-y
	mov al,bh
	sub al,bl
	ret

fx7:
	mov al,-1
	ret
img:
	db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,128
	db 0,0,0,1,  0,0,0,192,  0,0,0,1,  0,0,0,192
	db 0,0,0,3,  0,0,128,224,  0,0,0,3,  0,0,128,224
	db 0,0,3,7,  0,0,224,240,  0,0,3,7,  0,0,224,240
	db 0,0,7,15,  0,128,240,248,  0,0,7,15,  0,128,240,248
	db 0,3,15,31,  0,224,248,252,  0,7,31,31,  0,240,252,252
	db 0,15,31,63,  128,248,252,254,  0,15,63,63,  128,248,254,254
	db 7,31,63,127, 240,252,254,255, 7,63,127,127, 240,254,255,255
	db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
	db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
	db 0,0,0,0,  128,0,0,0,  0,0,0,0,  128,0,0,0
	db 3,0,0,0,  224,0,0,0,  3,0,0,0,  224,0,0,0
	db 7,0,0,0,  240,128,0,0,  7,0,0,0,  240,128,0,0
	db 15,3,0,0,  248,224,0,0,  31,7,0,0,  252,240,0,0
	db 31,15,0,0,  252,248,128,0,  63,15,0,0,  254,248,128,0
	db 63,31,7,0,  254,252,240,0,  127,63,7,0,  255,254,240,0

