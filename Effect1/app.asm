; GREEN equ 0x1c00
FONT equ 0xFF00
HSPACE equ 15
TOPLEFT equ HSPACE*4

%define t dh
%define i bp
%define x bh
%define y bl
isqrt_table    equ 1000  

setup:
  push cs
  pop ds



crt_init:
  xor bx,bx
  .lp:
  mov al,bl
  out 0x30,al           ; address / register select
  mov al,[iosys+bx]
  out 0x32,al           ; data
  inc bx
  cmp bl,13
  jne .lp


  call clear_pages

  xor t,t

  ; mov ax,0x0c00
  ; mov bx,1
  ; call draw_frame
  
  

  ; mov ax,0x2c00
  ; mov bx,0
  ; call draw_frame

  ; mov ax,0x3c00
  ; mov bx,0
  ; call draw_frame


switch:  
  mov ax,0x1c00
  mov bx,0b01010101
  call draw_frame

  mov al,5
  out 0x10,al
  call delay


  mov ax,0x0800
  mov bx,-1
  call draw_frame

  mov al,4
  out 0x10,al
  call delay

  ; mov cx,500
  ; mov ax,0xf400
  ; mov es,ax
  ; xor di,di
  ; mov ax,-1
  ; rep movsw

  ; mov cx,500
  ; mov ax,0xf000
  ; mov es,ax
  ; xor di,di
  ; mov ax,0x7f
  ; rep movsw

  jmp switch

  hlt

delay:
  mov cx,5000
  .delay: 
  ; aam
  loop .delay
  ret

fx0:
  mov al,x
  mul y
  add al,t
  ; add al,t
  ; call sin

  ; mov dl,al
  ; mov al,y
  ; ; shr al,1
  ; ; shr al,1
  ; add al,t
  ; call sin
  ; add al,dl

  ; mov dl,al
  ; sub al,t

  ret

draw_frame:
  xor i,i
  mov es,ax
  mov di,TOPLEFT
  mov ax,-1
  xor bx,bx   ; bh=y, bl=x  [0..49]
  mov cx,50 ; rows
.row:
  push cx
  mov cx,50
  xor x,x
.col:
  call fx0

  and ax,7
  shl al,1
  shl al,1
  add ax,intensity
  mov si,ax
  movsw
  movsw

  inc i
  inc x
  loop .col
  pop cx
  add di,2*4*HSPACE
  inc y
  loop .row
  inc t

  ret

clear_pages:
  mov ax,0x0800
  call clear_page
  ; mov ax,0x0c00
  ; call clear_page
  mov ax,0x1c00
  call clear_page
  ; mov ax,0x2c00
  ; call clear_page
  ; mov ax,0x3c00
  ; call clear_page
  ret

clear_page:
  mov es,ax
  xor di,di
  mov ax,0
  mov cx,8000
  rep stosw
  ret


sin: ; sine function
    call wrap
    push bx
    add al,15 ; sin(-15) = sin_table[0]
    mov bx,sin_table
    xlat 
    pop bx
    ret

wrap: ; while (al>15) al-=15; while (al<-15) al+=15
    cmp al,15
    jg .sub16
    cmp al,-15
    jl .add16
    ret
  .sub16:
    sub al,31
    jmp wrap
  .add16:
    add al,31
    jmp wrap

limit: ; if (al>15) al=15; else if (al<-15) al=-15;
    cmp al,15
    jg .pos16
    cmp al,-15
    jnl .ret
    mov al,-15
    ret
  .pos16:
    mov al,15
  .ret:
    ret

calc_isqrt_xx_yy: ; isqrt_table[i] = sqrt(x^2+y^2)
    push dx
    push di
    mov di,isqrt_table      ; di=isqrt_table[0]
    add di,dx               ; di+=i
    mov al,x
    inc al
    mul al                  ; x*x
    xchg ax,cx
    mov al,y
    inc al
    mul al                  ; y*y
    add ax,cx               ; + 
  .isqrt:  ; while((L+1)^2<=y) L++; return L
    xchg cx,ax              ; cx=y
    xor ax,ax               ; ax=L=0
  .loop:
    inc ax
    push ax
    mul ax
    cmp ax,cx
    pop ax
    jl .loop
    dec ax
  .end_isqrt:
    mov [di],al             ; store al
    pop di
    pop dx
    ret

; https://cpctech.cpcwiki.de/docs/hd6845s/hd6845sp.htm
iosys: db 0x70,0x50,0x59,0x48,0x41,0x00,0x32,0x38,0x00,0x03,0,0,0,0,0,0
crt80: db 0x65,0x50,0x53,0x48,0x69,0x02,0x64,0x64,0x00,0x03,0,0,0,0,0,0
crt72: db 0x70,0x48,0x55,0x4A,0x41,0x00,0x32,0x38,0x00,0x03,0,0,0,0,0,0
;           |    |    |    |    |    |    |    |    |    |__Cursor Start Raster Register (R10) (3 / 3)
;           |    |    |    |    |    |    |    |    |__Maximum Raster Address Register    (R9) (0 / 0)
;           |    |    |    |    |    |    |    |__Interlace and Skew Register (R8)   (0x64=100 / 0x38=56)   
;           |    |    |    |    |    |    |__Vertical Displayed Register      (R6) V:(0x64=100 / 0x32=50)
;           |    |    |    |    |    |__Vertical Total Adjust Register        (R5) V:(0x02=2   / 0x00=0)
;           |    |    |    |    |__Vertical Total Register                    (R4) V:(0x41=65  / 0x69=105)
;           |    |    |    |__Sync Width Register                             (R3)   (0x48=72  / 0x4a=74)
;           |    |    |__Horizontal Sync Position Register                    (R2) H:(0x53=83  / 0x55=85)
;           |    |__Horizontal Displayed Register                             (R1) H:(0x48=72  / 0x50=80)
;           |__Horizontal Total Register                                      (R0) H:(0x65=101 / 0x70=112)
              
intensity: db 0,0,0,0,136,0,34,0,170,0,170,0,170,17,170,68,170,85,170,85,85,238,85,187,119,255,221,255,255,255,255,255

sin_table: ;31 bytes, (output -15..15 index=0..31)
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0  
         
%assign num $-$$
%warning total num
   
times (180*1024)-($-$$) db 0
