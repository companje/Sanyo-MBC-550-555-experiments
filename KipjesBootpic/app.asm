%include "sanyo.asm"

setup:
  mov si, kipjes
  mov bh,25 ; cols 
  mov bl,44 ; rows
  call draw_pic
  hlt

draw_pic:
  mov ax, RED
  call draw_channel
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
  call draw_channel
  ret

draw_channel:
  mov es,ax
  xor di,di
  xor cx,cx
  mov cl,bl        ; rows (bl)
.rows_loop:
  push cx
  xor cx,cx
  mov cl,bh        ; cols (bh)
.cols_loop:
  movsw
  movsw
  loop .cols_loop
  add di,COLS*4 
  mov ax,0
  mov al,bh
  times 2 shl ax,1
  sub di,ax       ; di-=4*bh
  pop cx
  loop .rows_loop
  ret

%include "assets.asm"

times (180*1024)-($-$$) db 0

