org 0
; cpu 8086
bits 16

COLS  equ 64
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
NUM equ 200*COLS

%define t dh
%define i dl
%define x bh
%define y bl

%include "macros.asm"

setup:
  push cs
  pop ds
  generate_sin_table
  call crt_setup
  xor di,di
  xor bx,bx
  xor dx,dx
  
draw:
  call calc_xy

  mov al,x
  add al,[offset]
  shl al,1
  mov bx,sin_table
  xlat
  mov cl,al

  mov al,y
  add al,[offset]
  shr al,1
  xlat
  add al,cl

  add al,t

  mov cl,4
  shr al,cl

  push bx
  mov bx,intensity12
  xlat
  pop bx
  
  mov [es:di],al


;update di (many times per frame)
  mov ax,[di_step]
  xor ah,ah
  add di,ax
  cmp di,NUM
  jl .done1
  sub di,NUM
.done1:

;every x cycles increase the [frame] number
  inc bp
  test bp,511  ;1023  ; 8191
  jne .done2
  inc t
.done2:

  test t,63
  jnz .done4
  call clear_channel
.done4:

;every x frame go the next effect
  test t,31
  jnz .done3
  inc t
  inc byte [di_step]
  mov al,[di_step]
  ; times 4 shl al,1
  mov [offset],al
  call next_channel
.done3:


  jmp draw

offset: db 0
di_step: db 11; 226; //160 ; increase step for di
frame: db 1

intensity12: db -1, -1, -1, -1, 0x55, 34, 0,0, 34, 0x55, -1, -1, -1, -1 

next_channel:
  push es
  pop ax
  ; xor ax,0x400
  cmp ax,RED
  jne .b
  mov ax,GREEN
  jmp .c2
.b:
  cmp ax,BLUE
  je .rd
  mov ax,BLUE
  jmp .c2
.rd:
  mov ax,RED
.c2:
  push ax
  pop es
  ret

clear_channel:
  push di
  push cx
  push ax
  xor di,di
  mov cx,NUM/2
  mov ax,0
  rep stosw
  pop ax
  pop cx
  pop di
  ret

calc_xy:
  mov ax,di
  times 2 shr ax,1
  and al,0x3f
  mov x,al
  mov ax,di
  mov cl,8    ; /255
  shr ax,cl
  mov cl,2    ; *4
  shl ax,cl
  mov cx,ax   ; keep copy of ax
  mov ax,di
  and ax,3
  or ax,cx    ; al now contains y 0..199
  mov y,al
  ret

qsin_table: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126

; ------------------------------------

crt_setup:
  mov al,1
  out 0x30,al      ; set address
  mov al,COLS      
  out 0x32,al      ; set value

  mov ax,GREEN
  mov es,ax
  call clear_channel

  mov al,5
  out 10h,al 
  ret

sin_table: 


%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
