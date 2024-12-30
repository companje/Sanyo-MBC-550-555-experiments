%include "sanyo.asm"

draw_string:
  mov dx,BLUE
  mov bx,RED
  mov si,font
  mov cx,59
.lp
  movsw

  lodsw
  stosw
  push ds
  mov ds,bx
  mov [di-2],ax
  mov ds,dx
  mov [di-1],ah
  pop ds
  loop .lp
  ret

setup:
  mov ax,GREEN
  mov es,ax
  
  mov di,0
  call draw_string
  call draw_string
  
  hlt

font: incbin "data/8x4-nibble-font.bin"

text: 
times (180*1024)-($-$$) db 0

