FONT equ 0xFF00
COLS equ 72
ROWS equ 50
NUM equ 4*COLS*ROWS
; STEP equ 5;  4608+4

setup:
  push cs
  pop ds
  mov ah,8   ; only in mame green segment=0x0800
  mov es,ax
  mov ax,FONT
  mov ds,ax
  xor di,di
  xor si,si

draw:
  ; inc si

  ; mov al,0xee

  cmp di,13000
  jb .s

  mov si,bp
  ; ; add si,[t]
  ; and si,3
  ; add si,176
  ; shl si,1
  ; shl si,1
  ; shl si,1
  movsw
  movsw
  jmp .q
.s:
  inc di
.q:

  ; movsb
  ; movsb

  add di,[cs:step]
  cmp di,NUM

  jle draw
  sub di,NUM

  inc bp

  ; xor si,si
  ; add si,bp

  inc word [cs:t]
  inc word [cs:step]

  

  jnz draw

 jmp draw

  ; jmp draw

  ; ; mov ax,FONT
  ; ; mov ds,ax
  ; mov si,64*8
  ; ; and si,255
  ; ; times 3 shl si,1
  ; ; add si,FONT

  ; mov ax,[ds:si]
  ; ; mov ax,0x5555
  ; mov [es:di],ax
  ; ; push si
  ; ; push di
  ; ; movsw
  ; ; movsw
  ; ; pop di
  ; ; pop si

  ; add di,STEP
  ; cmp di,NUM
  ; jl draw
  ; sub di,NUM
  ; jmp draw

; draw_cell:
; movsw
  ; movsw

  ; mov cx,3
  ; push cx
  ; push si
  ; push di
  ; mov cx,4
  ; .lp
  ; movsw
  ; movsw
  ; loop .lp
  ; pop di
  ; pop si
  ; pop cx

t: dw 0
step: dw 0

%assign num $-$$
%warning total num
times (180*1024)-num db 0



