org 0
cpu 8086
COLS  equ 16
RED   equ 0xf000
GREEN equ 0x0800
BLUE  equ 0xf400
NUM equ 200*COLS

setup:
  push cs
  pop ds

  mov al,1
  out 0x30,al      ; set address
  mov al,COLS      
  out 0x32,al      ; set value
  
  mov bx,GREEN
  mov es,bx
  mov si,1000

draw:

  mov ax,di
  times 2 shr ax,1
  and al,0x3f

  times 4 shl al,1

  add ax,bp
  
  times 5 shr al,1
  mov bx,intensity12
  xlat

  mov [es:di],al


  out 0x3a,al

  add di,si

  cmp di,NUM
  jb draw
  sub di,NUM
  inc bp
  and bp,255 ;254

  inc cx
  test cx,2047
  jnz draw
  ; inc si
  add si,13
  and si,8191


  call clear_channel
  call next_channel

  jmp draw


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

intensity12: db -1,-1,-1,0,0,0,0,0,-1,-1,-1
; intensity12: db -1,-1,-1,0x55,0,0,0,0x55,-1,-1,-1

%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
