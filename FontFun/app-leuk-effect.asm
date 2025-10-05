FONT equ 0xFF00
COLS equ 72
ROWS equ 50
NUM equ 4*COLS*ROWS
STEP equ 1 ;4608+4

setup:
  push cs
  pop ds
  mov ah,8   ; only in mame green segment=0x0800
  mov es,ax
  mov ax,FONT
  mov ds,ax
  xor di,di

draw:
  ; inc si

  mov al,0xee
  movsb    ; hierdoor komt het leuke effect. dit had stosb moeten zijn

  add di,STEP
  cmp di,NUM
  jl draw
  sub di,NUM
  jmp draw

  ; jmp draw
  ; inc bp

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

t: db 0

%assign num $-$$
%warning total num
times (180*1024)-num db 0



