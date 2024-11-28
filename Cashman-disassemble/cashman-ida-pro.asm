%include "bootloader.asm"

setup:
	mov	ax, RED
	mov	es, ax
	xor di, di
	mov ax, 0xffff
	mov	cx, 2000h
	rep stosw
	
	
	
draw:

	jmp draw

incbin "snapshot.bin" 

times (360*1024)-($-$$) db 0

