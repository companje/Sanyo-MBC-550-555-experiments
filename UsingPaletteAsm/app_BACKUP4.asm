RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72
ROWS  equ 50
; TOP   equ 9*4*COLS+20*4    ; row=9,col=20
STEP equ 4+4608; //9+288; //5+COLS*4; //4 ; +COLS*4
NUM equ COLS*4*ROWS

; %define t bp
%define i di
%define x bh
%define y bl

jmp setup

setup:
  push cs
  pop ds
  call generate_sin_table

  call clear_green      ; only needed in MAME
  mov al, 5
  out 10h, al           ; select address 0x1c000 as green video page

  mov di,0
 
draw:
  
  mov ax,di
  mov cx,COLS*4
  div cx

  mov x,al
  mov y,dl

  add al,[t]
  xor ah,ah

  mov si,sin_table
  add si,ax
  lodsb

  xor ah,ah
  add al,y

  add si,ax


  mov cl,4
  shr al,cl
  xor dx,dx
  mov cl,12
  mul cl
  xor ah,ah

  mov si,img
  add si,ax




.nx2:


  call draw_cell

  ;*****************
  add di,STEP
  cmp di,NUM
  jb .n1
  sub di,NUM
  inc bp

  test bp,127
  jnz .n1
  inc byte [t]

  test byte [t],31
  jnz .n1
  inc byte [effect]

.n1:
  jmp draw

t: db 1
effect: db 1
sin_t: db 0
cos_t: db 0
xct: db 0
yst: db 0

; ───────────────────────────────────────────────────────────────────────────

draw_cell:        ; draw 8x4px (12 bytes) from SI to DI
  ; push di
  ; push di
  ; push di
  mov bx,di       ; dit zou sneller kunnen zijn dan push/pop. Wel meer bytes.
  mov ax,RED
  mov es,ax
  movsw
  movsw
  mov ah,GREEN>>8 ; save 1 byte because AL is already 0
  mov es,ax
  ; pop di
  mov di,bx
  movsw
  movsw
  mov ah,BLUE>>8
  mov es,ax
  ; pop di
  mov di,bx
  movsw
  movsw
  mov di,bx
  ; pop di
  ret

; ───────────────────────────────────────────────────────────────────────────

clear_all:
  mov ax,RED
  call clear_channel
  mov ax,BLUE
  call clear_channel

clear_green:
  mov ax,GREEN

clear_channel:
  mov es,ax
  mov cx,COLS*4*ROWS
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret

; ───────────────────────────────────────────────────────────────────────────

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

; ───────────────────────────────────────────────────────────────────────────

img: incbin "material16x4-dit2.pal"
; img: incbin "material-grey-dit2.pal"
; img: incbin "yyyy-dit2.pal"
sin_table: 

%assign num $-$$
%warning total num
times (180*1024)-num db 0



