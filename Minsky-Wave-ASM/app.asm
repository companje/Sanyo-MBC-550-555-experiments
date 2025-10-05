RED   equ 0xf000
GREEN equ 0x0800
BLUE  equ 0xf400
STEP equ 4608
COLS equ 72
ROWS equ 50
cos_table equ sin_table+64

setup:
push cs
pop ds
mov ax,GREEN
mov es,ax

call generate_sine_table


draw:
  push bp
  mov si,sin_table
  add si,bp
  and si,255
  call draw_wave

  call draw_wave
  pop bp
  inc bp
  jmp draw


draw_wave:
  mov cx,255
.x:
  push cx
  push si

  add si,cx
  lodsb

  mov bx,cx      ;x
  mov dl,al      ;y
  xor dh,dh
  shr dl,1

  call calc_bit_for_pixel
  xor [es:di],dl

  pop si
  pop cx

  loop .x
  ret

generate_sine_table:
  mov bp,1100
  mov si,1
  xor di,di
  mov cx,64
.a:
  push cx
  mov cx,404
  mov bx,2<<13
  mov ax,si
  xor dx,dx
  imul cx
  idiv bx

  push ax
  mov ax,bp
  xor dx,dx
  imul cx
  idiv bx
  sub si,ax
  pop ax
  add bp,ax

  mov cx,28
  mov ax,si
  imul cx
  mov cl,8
  shr ax,cl
  add al,128

  ;from here the qsin is repeated/flipped for sin and cos

  dec cx  ; cx was 8 here, now 7
.d:
  mov bx,cx
  dec bx
  push ax
  push di
  push cx
  mov cl,6
  shl bx,cl
  pop cx
  dec cx     ; because loop repeats unless 0 not including 0

  test cl,1  ; cx [5..1]
  jz .b
  neg di
  add bx,63  ; add bl equal bytes
.b:
  test cl,2
  jz .c
  not al
.c:
  mov [di+bx+sin_table],al
  pop di
  pop ax
  inc cx ; restore cx after decrease
  loop .d

;-------

  pop cx
  inc di
  loop .a 
  ret


; --------------------------------------------------

calc_bit_for_pixel:
  ;input BX,DX = x,y
  ;output DI = (y\4)*(4*COLS) + (y%4) + (x\8)*4
  ;output DL = 2^(7-(x % 8))
  ;or [es:di],dl  ; set pixel
  mov ax,dx        ; y
  mov cx,3
  and dx,cx        ; dx=y%4
  dec cl
  shr ax,cl        ; ax=y/4        
  mov di,dx        ; vram offset (dx=y%4)
  mov cx,4*COLS    
  mul cx           ; ax*=(4*COLS)
  add di,ax        ; di+=ax
  mov ax,bx        ; x
  mov dx,ax
  and dx,7         ; %=8
  mov cl,3
  shr ax,cl        ; /=8      
  dec cl
  shl ax,cl        ; *=4
  add di,ax        ; di+=(x/8)*4
  mov al,128       ; highest bit
  mov cl,dl        ; dl contains x%8
  shr al,cl        ; shift right number of bits to the correct pixel in char
  mov dl,al
  ret

sin_table:

%assign num $-$$
%warning total num
times (180*1024)-num db 0



