org 0

COLS  equ 64
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
NUM equ 200*COLS

%define y bl

; deze werkt maar is nog steeds te traag.
; ik render 1 kolom. Misschien kan het nog slimmer 
; als ik alleen recent gewijzigde pixels update
; en een klein beetje daarboven en er onder.





jmp setup

ci: db 0
offset: dw 0

setup:
  push cs
  pop ds
  call generate_sin_table
  call crt_setup
  xor di,di
  xor bp,bp
 
draw:
  inc di
  test di,3         ; if ((di&3)==0)
  jnz .c1
  add di,COLS*4-4   ; di+=W-4;
.c1:
  cmp di,NUM
  jb .nx1
  sub di,NUM

  cmp byte [ci], 2
  je  .set_r
  cmp byte [ci], 1
  je  .set_b
  mov ax, GREEN
  jmp .set_es
.set_b:
  mov ax, BLUE
  jmp .set_es
.set_r:
  inc bp
  mov ax, RED
  mov byte [ci], -1
.set_es:
  mov es, ax
  inc byte [ci]
.nx1:
  call calc_y
  call fx_multibar

BAR_WIDTH equ 1
BAR_START equ 32-BAR_WIDTH/2

  add di,BAR_START*4
  mov cx,BAR_WIDTH
.row:
  stosb
  add di,3
  loop .row
  sub di,BAR_WIDTH*4

  sub di,BAR_START*4


  jmp draw

; ------------------------------------

fx_multibar:
  xor ax,ax
  mov cx,3
.lp:
  push cx

  push ax
  mov ax,cx
  mul cx
  mov cx,10
  mul cx
  mov [offset],ax
  pop ax
  or ax,ax
  jnz .nx2

  push cx
  call fx_bar
  pop cx
.nx2:
  pop cx
  loop .lp

  ret

; ------------------------------------

fx_bar:
  mov ax,[offset]
  times 3 add al,[ci]
  times 3 add ax,bp
  xor ah,ah
  
  mov si,sin_table
  add si,ax
  lodsb

  add ax,bp
; xor dx,dx
  mov cx,192
  mul cx
  mov cl,8
  shr ax,cl
  mov dl,al   ; int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  mov al,0
  cmp y,dl    ; if (y < barY) return;
  jb .r
  add dl,10
  cmp y,dl    ; if (y > barY + 10) return;
  ja .r
  mov al,255
.r: 
  ret

; ------------------------------------

clear_channel:
  ; push di
  ; push cx
  ; push ax
  xor di,di
  mov cx,NUM/2
  mov ax,0
  rep stosw
  ; pop ax
  ; pop cx
  ; pop di
  ret

; ------------------------------------

calc_y:
  ; mov ax,di
  ; times 2 shr ax,1
  ; and al,0x3f
  ; mov x,al
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

; ------------------------------------

generate_sin_table:   ; convert quart sine table to full sine table
  push cs
  pop es
  mov di,sin_table
  xor ax,ax
  mov cx,255
.sin_loop:
  push ax
  push cx
  ; call sin
  mov cl,6
  mov dl,al        ; dl=angle 0..255
  shr dl,cl        ; angle/6 = quadrant 0..3
  mov dh,dl        ; dh=copy of quadrant
  and dh,1         ; dh=1 if quadrant is odd 1 or 3
  mov bl,dh        ; bl=dh
  shl bl,cl        ; r = bl<<6
  mov ch,dl        ; gt1
  shr ch,1
  sub bl,dh        ; s (0 of 63)
  and al,63        ; i
  xor al,bl        ; i^bl
  mov bx,qsin_table
  xlat
  neg ch
  xor al,ch
  neg ch,
  add al,ch
  add al,128
  ; end call sin
  stosb
  pop cx
  pop ax
  inc ax
  loop .sin_loop
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

sin_table: 


%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
