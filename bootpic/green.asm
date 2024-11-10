org 0
cpu 8086

RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72

ROM equ 0xFE00
FONT equ 0xFF00

; CHAR_SIZE equ 8        ; Aantal bytes per karakter in de font-tabel
; ROW_OFFSET equ 4*COLS-4  ; Offset naar de volgende rij voor de onderste helft van een karakter

LINES_PER_ROW equ 4
COLS_PER_ROW equ 72

jmp setup

db 'Sanyo1.2',2,0,1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0

row: db 0
col: db 0

setup:
  mov al,5
  out 0x10,al ; set video page green to 1C00:0000. Needed to get MAME and Sanyo on the same 'page'
  ; in MAME wordt hierdoor de achtergrond groen. Op de sanyo zwart.
  ; dus misschien even clear screen hier doen voor rood,groen en blauw.

  call clear_screen

  ; call blue_bg
  ; call rom_to_vram
  ; call green_bg

  call draw_moving_block_animation    

  hlt



draw_moving_block_animation:
  mov ax,GREEN
  mov es,ax
  xor di,di
  add di,40
  mov cx,3000
.1
  call move_block_down
  
  push cx
  mov cx,5000
  call delay_nops
  pop cx

  loop .1
  ret

delay_nops:
  nop
  loop delay_nops
  ret

clear_screen:
  mov ax,GREEN
  mov es,ax
  xor di,di
  mov cx,0x2000
  xor ax,ax
  rep stosw
  ret


move_block_right:
  sub di,4
  mov ax,0
  stosw
  stosw
  mov ax,0xffff
  stosw
  stosw
  ret

move_block_down:
  push di
  sub di,4*COLS
  mov ax,0
  stosw
  stosw
  pop di
  mov ax,0xffff
  stosw
  stosw
  add di,4*COLS-4
  ret

draw_pic:
  push cs
  pop ds
  mov ax,GREEN
  mov es,ax
  lea si,img
  xor di,di
  mov cx,192  ; eerst kijken hoe ik de image data in de bootsector kan tonen. daarna pas diskaccess
  rep movsb
  ret

blue_bg:
  mov ax,BLUE
  push ax
  pop es
  mov di,0
  mov cx,0x4000
  mov al,255
  rep stosb
  ret

red_bg:
  mov ax,RED
  push ax
  pop es
  mov di,0
  mov cx,0x4000
  mov al,255
  rep stosb
  ret

green_bg:
  mov ax,GREEN
  push ax
  pop es
  mov di,0
  mov cx,0x4000
  mov al,255
  rep stosb
  ret

rom_to_vram:
  mov ax,ROM   ; ROM start
  mov ds,ax       ; DS source segment
  xor si,si       ; si=0
  mov ax,GREEN
  mov es,ax       ; ES dest segment
  xor di,di       ; di=0
  mov cx, 0x4000  ; 8000 bytes (0x4000 in hexadecimal)
  rep movsb       ; Kopieer CX bytes van DS:SI naar ES:DI
  
  ret

img: 
  incbin "beker.pic"

%assign num $-$$

times 368640-num db  0