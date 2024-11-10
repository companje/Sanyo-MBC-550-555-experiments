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
  mov al,5
  out 0x10,al ; set video page green to 1C00:0000. Needed to get MAME and Sanyo on the same 'page'
  call clear_green_channel ; needed for MAME

  push cs
  pop ds      ; ds=cs

  lea si, img
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
  incbin "snapshot.bin"

%assign num $-$$
%warning num

times 368640-num db  0