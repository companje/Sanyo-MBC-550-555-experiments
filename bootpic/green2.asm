org 0
cpu 8086

RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72

ROM equ 0xFE00
FONT equ 0xFF00

LINES_PER_ROW equ 4
COLS_PER_ROW equ 72

jmp setup

db 'Sanyo1.2',2,0,1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0

; row: db 0
; col: db 0

setup:
  call clear_green_channel
  mov al,5
  out 0x10,al

  push cs
  pop ds      ; ds=cs

  mov si, img
  mov bh,4 ; cols 
  mov bl,4 ; rows
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
rows_loop:
  push cx
  xor cx,cx
  mov cl,bh        ; cols (bh)
cols_loop:
  movsw
  movsw
  loop cols_loop
  add di,COLS*4 - 4*4
  pop cx
  loop rows_loop
  ret

clear_green_channel:
  mov ax,GREEN
  mov es,ax
  xor di,di
  mov cx,0x2000
  xor ax,ax
  rep stosw
  ret

img: 
  db 0,112,127,112,255,255,255,255,245,250,253,250,0,14,254,14
  db 56,28,7,0,255,127,255,255,253,250,245,255,28,56,224,0
  db 0,0,0,0,15,3,3,3,240,192,192,128,0,0,0,0
  db 0,0,0,0,3,7,63,127,192,176,212,234,0,0,0,0
  db 0,96,117,96,255,255,255,255,160,208,232,208,0,4,234,4
  db 48,24,7,0,255,127,127,191,232,208,224,215,8,16,224,0
  db 0,0,0,0,15,3,3,3,160,192,128,128,0,0,0,0
  db 0,0,0,0,3,7,63,127,128,144,196,226,0,0,0,0
  db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

  
%assign num $-$$
%warning num

times 368640-num db  0