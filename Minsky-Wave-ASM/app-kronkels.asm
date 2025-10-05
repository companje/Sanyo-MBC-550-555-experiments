; RED   equ 0xf000
; GREEN equ 0x800 ; 1c00 ; 0x1c00
; BLUE  equ 0xf400
; COLS  equ 72
; ROWS  equ 50
STEP equ 4608
; NUM equ COLS*4*ROWS

COLS equ 72
ROWS equ 50
GREEN equ 0x1c00

setup:
  mov ax,GREEN
  mov es,ax

  mov al,5
  out 0x10,al    ; 0x1c00

  xor di,di

push cs
pop ds

xor ax,ax
xor bp,bp

; mov cx,3600
draw:

  mov ax,bp
  inc bp

  and ax,3

  shl ax,1
  shl ax,1
  ; inc cl
  ; shr al,cl
  mov si,dash
  add si,ax
  movsw
  movsw
  ; loop draw
  cmp di,14400
  jl draw
  xor di,di
  jmp draw

hlt

dash: 
db 3,12,48,192
db 192,48,12,3

circle:
db 7,56,64,128
db 128,64,56,7
db 128+64+32,16+8+4,2,1
db 1,2,16+8+4,128+64+32

; block:
; db 255,128,128,131
; db 255,1,1,193
; db 131,128,128,255
; db 193,1,1,255
; db 255,255,240,240
; db 255,255,0,0
; db 0,0,255,255
; db 15,15,255,255


; 60,255,255,60,60,195,195,60,195,0,0,195,195,60,60,195

; stc
; pushf
; .lp1:
; ; mov si,data
; ; mov al,3
; stosb
; ; popf
; rcl al,1
; rcl al,1
; ; pushf
; loop .lp1

; mov si,data
; movsw
; movsw
; add di,COLS*4-8
; mov si,data
; movsw
; movsw
; mov si,data
; movsw
; movsw

;   hlt


;   pushf
; .lp:
;   stosb
;   popf
;   rcl al,1
;   rcl al,1
;   ; rcl al,1
;   ; rcl al,1


;   ; rcr al,1
;   ; rcr al,1


;   pushf
;   cmp di,14400
;   jb .lp

;   ; and di,4095
;   xor di,di
;   ; mov di,0
;     ; mov al,3

;   jmp .lp

; hlt

; toggle_dir:
;   times 4 db 0xd0
;   ret


; 00000011
; 00001100
; 00110000
; 11000000


;   push cs
;   pop ds

; cmc
; les  bp,[bx] ; es di ffff:ffff
; ; lea  di,[bx] ; es di ffff:0210

; looping:
;         ;do stuff here
;         inc     bx ;if decrementing instead, parity check must be reversed
;         jpo     looping


; ; hlt

;   mov al,5
;   out 0x10,al    ; 1c00
;   mov al, 0x34
;   out 0x26, al
;   mov al, ticks & 0xff
;   out 0x20, al        ; lobyte
;   mov al, ticks >> 8
;   out 0x20, al        ; hibyte

;   mov ax,BLUE
;   mov es,ax
;   mov di,0
 
;   xor ax,ax

; draw:
;   mov al,[es:bp+0xc000]
;   inc bp
;   ; in al,0x20
;   ; push ds
;   ; mov ax,0xFF00
;   ; mov ds,ax
;   ; mov si,di
;   ; lodsb
;   ; pop ds
;   and al,1
;   shl al,1
;   shl al,1
  

;   mov si,data
;   add si,ax

;   movsw
;   movsw

;   ; add di,STEP
;   cmp di,NUM
;   jb draw
;   ; sub di,NUM
;   ; jmp draw
;   .hlt jmp .hlt

clear_green:
  mov ax,GREEN

clear_channel:
  mov es,ax
  mov cx,COLS*4*ROWS
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret



%assign num $-$$
%warning total num
times (180*1024)-num db 0



