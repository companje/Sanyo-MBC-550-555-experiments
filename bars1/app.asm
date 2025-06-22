org 0
; cpu 8086
BITS 16

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

jmp setup

offset: db 0
di_step: dw 1;  11 226; //160 ; increase step for di
frame: db 1
; effect: db 0
effect_ptr: dw fx_table
fx_table: db fx0,fx1,fx0,fx1,fx0,fx1,fx0,fx1,fx0,fx1,fx0,fx1,fx0,fx1,fx0,fx1

; intensity12: db -1, -1, -1, -1, 0, 0, 0,0, 0, 0, -1, -1, -1, -1 
; intensity12: db -1, -1, -1, -1, 0x55, 34, 0,0, 34, 0x55, -1, -1, -1, -1 
intensity12: db 0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1

fx1:
  mov al,y
  ; add al,y
  ; add al,t
  ret


setup:
  push cs
  pop ds
  call init_keyboard
  generate_sin_table
  call crt_setup
  xor di,di
  ; xor si,si
  xor bx,bx
  xor dx,dx
  inc t
draw:

  call calc_xy


  ; call fx1
mov al,255
; xor al,y

??????????

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
  test bp,511 ;1023  ; 8191
  jne .done2
  inc t
.done2:

 
;every x frame go the next effect
  test t,127 
  jnz .done3
  inc t
  inc byte [di_step]
  mov al,[di_step]
  mov [offset],al
  call clear_channel
  call next_channel
.done3:


;   test t,63
;   jnz .done4
;   call clear_channel
; .done4:


  ; call check_keys
  ; jne .done5
  ; inc byte [di_step]
; .done5:



  jmp draw


%macro sin 0
;   ; push bx
;   ; mov bx,sin_table
;   ; xlat
;   ; pop bx
  mov si,sin_table
  add si,ax
  lodsb
%endmacro

; sin:
;   mov si,sin_table
;   add si,ax
;   lodsb
;   ret



fx0:
  xor ah,ah
  mov al,x
  times 4 add al,[offset]
  shl al,1
  
  sin

  mov cl,al
  mov al,y
  add al,[offset]
  times 4 add al,[offset]
  shr al,1

  sin

  add al,cl
  times 1 add al,t
  mov cl,4
  shr al,cl
  ret


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

  mov al, 5
  out 10h, al 
  ret

init_keyboard:
  mov al,0
  out 0x3a,al           ; keyboard \force state/
  out 0x3a,al           ; keyboard \force state/
  mov al,0xFF
  out 0x3a,al           ; keyboard \reset/
  out 0x3a,al           ; keyboard \mode/
  mov al,0x37
  out 0x3a,al           ; keyboard \set command
  ret

check_keys:
  in al,0x3a        ; get keyboard status
  mov ah,al
  and al,0b00001000 ; keep only 1 for 'ctrl'
  ; mov [cs:key.ctrl],al
  test ah,2         ; keypressed flag is in ah, not in al anymore
  jz .return
  in al,0x38        ; get data byte from keyboard  
  ; mov [cs:key.code],al
  mov al,0x37
  out 0x3a,al       ; drop key?  
  or al,1           ; set zero flag to false to indicate a keypress
  ; mov ax,[cs:key]   ; ctrl status in ah, keycode in al, ZF low means a key was pressed
.return ret


sin_table: 


%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
