; %include "sanyo.asm"
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72
ROWS  equ 50

setup:
  push cs
  pop ds

  call clear_green
  mov al, 5
  out 10h, al           ; select address 0x1c000 as green video page

  xor di,di
  mov si,img
  call draw_spr

  mov cx,49
.lp:
  push cx
  mov si,img
  call draw_spr
  add di,288
  pop cx
  loop .lp

draw:
  jmp draw


clear_green:
  mov ax,GREEN
  call clear_channel
  ret

clear_channel:
  mov es,ax
  mov cx,COLS*ROWS*2
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_spr:
  push bx
  mov bx,[si]
  inc si
  inc si
  call draw_pic
  pop bx
  ret

draw_pic:
  push ax
  mov ax, RED
  call draw_channel
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
  call draw_channel
  pop ax
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_channel:
  push di
  mov es,ax
  xor cx,cx
  mov cl,bh        ; rows (bl)
.rows_loop:
  push cx
  xor cx,cx
  mov cl,bl        ; cols (bh)
.cols_loop:
  movsw
  movsw
  loop .cols_loop
  add di,COLS*4    ; one row down
  mov ah,0
  mov al,bl
  times 2 shl ax,1
  sub di,ax       ; di-=4*bh   ; bh cols to the left on the new row
  pop cx
  loop .rows_loop
  pop di
  ret

; ───────────────────────────────────────────────────────────────────────────


; img: incbin "16colors.png-dithered.spr"
; img: incbin "material16.png-dithered.spr"
img: incbin "material16-dit2.spr"


times (180*1024)-($-$$) db 0



