org 100h
cpu 8086

RED   equ 0xf000

red_bg:
  mov ax,RED
  push ax
  pop es
  mov di,0
  mov cx,0x4000
  mov al,255
  rep stosb
  hlt