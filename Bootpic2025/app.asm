; %include "sanyo.asm"
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72
ROWS  equ 50

jmp setup

fill_red:
  mov bx,RED
  call fill_channel
  ret
fill_green:
  mov bx,GREEN
  call fill_channel
  ret
fill_blue:
  mov bx,BLUE
  call fill_channel
  ret

fill_channel: ;ax=pattern
  mov es,bx
  mov cx,COLS*ROWS*2
  xor di,di
  rep stosw
  ret

fill_white:
  mov ax,0xffff
  call fill_red
  call fill_green
  call fill_blue
  ret

fill_pink:
  mov ax,0xffff
  call fill_red
  mov ah,0b01010101
  mov al,0b10101010
  call fill_green
  call fill_blue
  ret

fill_pink2:
  mov ax,0xffff
  call fill_red
  mov ah,0b11001100
  mov al,0b00110011
  call fill_green
  call fill_blue
  ret

fill_pink3:
  mov ax,0xffff
  call fill_red
  mov ah,0b00010001
  mov al,0b01000100
  call fill_green
  call fill_blue
  ret

fill_pink4:
  mov ax,0xffff
  call fill_red
  mov ah,0b11110111
  mov al,0b01111111
  call fill_green
  call fill_blue
  ret

clear_red:
  mov ax,RED
  call clear_channel
  ret

clear_green:
  mov ax,GREEN
  call clear_channel
  ret

clear_blue:
  mov ax,BLUE
  call clear_channel
  ret

clear_screen:
  call clear_red
  call clear_green
  call clear_blue
  ret

clear_channel:
  mov es,ax
  mov cx,COLS*ROWS*2
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret

setup:
  call clear_screen
  mov al, 5
  out 10h, al           ; select address 0x1c000 as green video page

  ; call fill_white

  mov ax,GREEN
  mov es,ax

draw:
  in al,0x10
  stosb
  out 0x10,al

  cmp di,ROWS*COLS*4
  jb draw
  xor di,di

;   call fill_pink4

;   mov cx,10000
; .delay: loop .delay

;   call clear_screen

;   mov cx,50000
; .delay2: loop .delay2

  jmp draw

  ; mov di,0
  ; mov si,img
  ; call draw_spr
  hlt

; img: incbin "16colors.png-dithered.spr"

times (180*1024)-($-$$) db 0



