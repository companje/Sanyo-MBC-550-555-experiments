org 0
cpu 8086
COLS equ 72

setup:
  push cs
  pop ds
  mov ax,0x0800  ; GREEN
  mov es,ax

  call circle
  hlt

; ------------------------------------
circle:
  ; push cx ; radius
  ; push cx ; radius
  mov cx,255     ; for x=0 to 255
  .lp:
  mov al,cl
  push cx
  call sin       ; al=sin(al)
  pop cx
  ; shr al,1       ; al/=2

  ; pop cx ; radius
  ; div cx ; default 255. divide by 0..255

  xor ah,ah      ; ah=0
  push ax        ; save x on stack


  mov al,cl
  push bx
  push cx
  call cos       ; al=cos(al)
  pop cx
  pop bx

  ; pop cx ; radius
  ; div cx

  shr al,1       ; al/=2
  xor ah,ah      ; ah=0
  
  mov dx,ax      ; y
  pop bx ; pop x value from ax on stack into bx

  push cx
  call calc_bit_for_pixel
  pop cx
  or [es:di],dl  ; set pixel
  loop .lp
  ret  

; ------------------------------------

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

; ------------------------------------

cos:
  add al,64
sin:
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
  mov bx,qsin
  xlat
  neg ch
  xor al,ch
  neg ch,
  add al,ch
  add al,128
  ret

; ------------------------------------

qsin: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126

%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
