COLS  equ 72
ROWS  equ 50
BYTES_PER_ROW equ 8*COLS  ; 25 lines
RED   equ 0xf000
GREEN equ 0xc000
BLUE  equ 0xf400

%macro set_cursor 2
  mov di,(%1-1) * BYTES_PER_ROW + (%2-1) * 4   ; one based
%endmacro

%macro crt_param 2
  push ax
  mov al,%1
  out 0x30,al
  mov al,%2
  out 0x32,al
  pop ax
%endmacro

jmp setup

HOR_TOTAL equ 0
HOR_DISPL equ 1
HOR_SYNC  equ 2
SYNC_WIDTH equ 3
VERT_TOTAL equ 4
VERT_ADJ equ 5
VERT_DISPL equ 6
ILACE_SKEW equ 7
MAX_ADDR equ 8
CURS_START equ 9

crt: db  112, 72, 89, 72, 65, 0, 50, 56, 0, 3, 0,0,0,0,0,0
;         |   |   |   |   |   |  |   |   |  |__Cursor Start Raster
;         |   |   |   |   |   |  |   |   |__Maximum Raster Address
;         |   |   |   |   |   |  |   |__Interlace and Skew
;         |   |   |   |   |   |  |__Vertical Displayed    
;         |   |   |   |   |   |__Vertical Total Adjust     
;         |   |   |   |   |__Vertical Total               
;         |   |   |   |__Sync Width                       
;         |   |   |__Horizontal Sync Position             
;         |   |__Horizontal Displayed                      
;         |__Horizontal Total                              


setup:
  push cs
  pop ds

  call crt_init

  
  crt_param HOR_DISPL,20
  crt_param VERT_DISPL,12



  mov ax,0b1000000110000001

.lp:
  ; push ds
  ; push ax
  ; mov ax,0xff00
  ; mov ds,ax
  ; pop ax
  ;   mov si,8

  ; lodsw
  ; hlt
  ; pop ds


  ; mov bx,RED
  ; mov es,bx
  ; mov di,0
  ; mov cx,0x1000
  ; rep stosw

  mov bx,GREEN
  mov es,bx
  mov di,0
  mov cx,0x1000
  rep stosw
  
  rol ax,1

mov bx,BLUE
  mov es,bx
  mov di,0
  ; add di,8
  mov cx,0x1000
  rep stosw

  ror ax,1

mov bx,RED
  mov es,bx
  mov di,0
  ; add di,4
  mov cx,0x1000
  rep stosw

  rol ax,1


  push ax
  inc dl
  mov al,dl
  call sin

  ; mov bx,sin_table
  ; xlat 


  mov dh,al
  add dh,40

  pop ax

  crt_param HOR_DISPL,dh


  ; and dl,31

  ; mov bx,BLUE
  ; mov es,bx
  ; mov di,2
  ; mov cx,0x1000
  ; rep stosw
  ; rol ax,1

  ; crt_param 1,dl
  ; crt_param 6,dl
  ; crt_param 1,dl
;   inc dl
;   and dl,127
; or dl,7
  mov cx,5000
  .w:
  nop
  loop .w

  ; neg ax
  jmp .lp


  ; mov ax,BLUE
  ; mov es,ax
  ; mov di,0
  ; mov ax,0b1010101010101010
  ; times 5 stosw




;   mov cx,80
; .lp2:
;   mov al,6
;   out 0x30,al
;   mov al,cl
;   out 0x32,al
;   loop .lp2

  ; push cx
  ; mov cx,1000
  ; .wait: 
  ; aam 
  ; loop .wait
  ; pop cx
  ; loop change
  ; jmp xx

  hlt
  
crt_init:
  xor bx,bx
  .lp:
  mov al,bl
  out 0x30,al           ; address / register select
  mov al,[crt+bx]
  out 0x32,al           ; data
  inc bx
  cmp bl,13
  jne .lp
  ret

;   mov cx,5

; .lp:
;   mov si,slash
;   or di,di
;   jp .cont
;   mov si,backslash
; .cont:
;   call draw_spr

;   add di,4*4

;   inc bl
;   cmp bl,5
;   jne .lp

;   xor bl,bl
;   add di,4*4*72
  

  ; test di,
;   jz .lp
; add di,72*4*4

  loop .lp


  ; inc bl
  ; cmp bl,15
  ; jl .lp
  ; inc bh
  ; cmp bh,15
  ; jl .lp


  
  ; push dx
  ; mov al,dl                ; al=index
  ; xor ah,ah               ; ah=0
  ; mov cl,16
  ; div cl                  ; calculate x and y from i
  ; xchg ax,bx              ; bh=x, bl=y
  ; pop dx


  hlt


  


  ; loop .lp

  ; grid4x4 0,0
  ; mov si,slash
  ; call draw_spr

  ; grid4x4 1,0
  ; mov si,backslash
  ; call draw_spr

  ; grid4x4 1,1
  ; mov si,backslash
  ; call draw_spr



  hlt

draw_spr:
  push bx
  mov bx,[si]
  inc si
  inc si
  call draw_pic
  pop bx
  ret

draw_pic:
  push ax
  mov ax, RED
  call draw_channel
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
  call draw_channel
  pop ax
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_channel:
  push cx
  push di
  mov es,ax
  xor cx,cx
  mov cl,bh        ; rows (bl)
.rows_loop:
  push cx
  xor cx,cx
  mov cl,bl        ; cols (bh)
.cols_loop:
  movsw
  movsw
  loop .cols_loop
  add di,COLS*4    ; one row down
  mov ah,0
  mov al,bl
  times 2 shl ax,1
  sub di,ax       ; di-=4*bh   ; bh cols to the left on the new row
  pop cx
  loop .rows_loop
  pop di
  pop cx
  ret


; crt_init:
;   xor bx,bx
;   .lp:
;   mov al,bl
;   out 0x30,al           ; address / register select
;   mov al,[iosys+bx]
;   out 0x32,al           ; data
;   inc bx
;   cmp bl,13
;   jne .lp


;   call clear_pages

;   xor t,t

;   ; mov ax,0x0c00
;   ; mov bx,1
;   ; call draw_frame
  
  

;   ; mov ax,0x2c00
;   ; mov bx,0
;   ; call draw_frame

;   ; mov ax,0x3c00
;   ; mov bx,0
;   ; call draw_frame


; switch:  
;   mov ax,0x1c00
;   mov bx,0b01010101
;   call draw_frame

;   mov al,5
;   out 0x10,al
;   call delay


;   mov ax,0x0800
;   mov bx,-1
;   call draw_frame

;   mov al,4
;   out 0x10,al
;   call delay

;   ; mov cx,500
;   ; mov ax,0xf400
;   ; mov es,ax
;   ; xor di,di
;   ; mov ax,-1
;   ; rep movsw

;   ; mov cx,500
;   ; mov ax,0xf000
;   ; mov es,ax
;   ; xor di,di
;   ; mov ax,0x7f
;   ; rep movsw

;   jmp switch

;   hlt

; delay:
;   mov cx,5000
;   .delay: 
;   ; aam
;   loop .delay
;   ret

; fx0:
;   mov al,x
;   mul y
;   add al,t
;   ; add al,t
;   ; call sin

;   ; mov dl,al
;   ; mov al,y
;   ; ; shr al,1
;   ; ; shr al,1
;   ; add al,t
;   ; call sin
;   ; add al,dl

;   ; mov dl,al
;   ; sub al,t

;   ret

; draw_frame:
;   xor i,i
;   mov es,ax
;   mov di,TOPLEFT
;   mov ax,-1
;   xor bx,bx   ; bh=y, bl=x  [0..49]
;   mov cx,50 ; rows
; .row:
;   push cx
;   mov cx,50
;   xor x,x
; .col:
;   call fx0

;   and ax,7
;   shl al,1
;   shl al,1
;   add ax,intensity
;   mov si,ax
;   movsw
;   movsw

;   inc i
;   inc x
;   loop .col
;   pop cx
;   add di,2*4*HSPACE
;   inc y
;   loop .row
;   inc t

;   ret

; clear_pages:
;   mov ax,0x0800
;   call clear_page
;   ; mov ax,0x0c00
;   ; call clear_page
;   mov ax,0x1c00
;   call clear_page
;   ; mov ax,0x2c00
;   ; call clear_page
;   ; mov ax,0x3c00
;   ; call clear_page
;   ret

; clear_page:
;   mov es,ax
;   xor di,di
;   mov ax,0
;   mov cx,8000
;   rep stosw
;   ret


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

; calc_isqrt_xx_yy: ; isqrt_table[i] = sqrt(x^2+y^2)
;     push dx
;     push di
;     mov di,isqrt_table      ; di=isqrt_table[0]
;     add di,dx               ; di+=i
;     mov al,x
;     inc al
;     mul al                  ; x*x
;     xchg ax,cx
;     mov al,y
;     inc al
;     mul al                  ; y*y
;     add ax,cx               ; + 
;   .isqrt:  ; while((L+1)^2<=y) L++; return L
;     xchg cx,ax              ; cx=y
;     xor ax,ax               ; ax=L=0
;   .loop:
;     inc ax
;     push ax
;     mul ax
;     cmp ax,cx
;     pop ax
;     jl .loop
;     dec ax
;   .end_isqrt:
;     mov [di],al             ; store al
;     pop di
;     pop dx
;     ret

; ; https://cpctech.cpcwiki.de/docs/hd6845s/hd6845sp.htm
; iosys: db 0x70,0x50,0x59,0x48,0x41,0x00,0x32,0x38,0x00,0x03,0,0,0,0,0,0

; crt80: db 0x65,0x50,0x53,0x48,0x69,0x02,0x64,0x64,0x00,0x03,0,0,0,0,0,0
; crt72: db 0x70,0x48,0x55,0x4A,0x41,0x00,0x32,0x38,0x00,0x03,0,0,0,0,0,0
; ;           |    |    |    |    |    |    |    |    |    |__Cursor Start Raster Register (R10) (3 / 3)
; ;           |    |    |    |    |    |    |    |    |__Maximum Raster Address Register    (R9) (0 / 0)
; ;           |    |    |    |    |    |    |    |__Interlace and Skew Register (R8)   (0x64=100 / 0x38=56)   
; ;           |    |    |    |    |    |    |__Vertical Displayed Register      (R6) V:(0x64=100 / 0x32=50)
; ;           |    |    |    |    |    |__Vertical Total Adjust Register        (R5) V:(0x02=2   / 0x00=0)
; ;           |    |    |    |    |__Vertical Total Register                    (R4) V:(0x41=65  / 0x69=105)
; ;           |    |    |    |__Sync Width Register                             (R3)   (0x48=72  / 0x4a=74)
; ;           |    |    |__Horizontal Sync Position Register                    (R2) H:(0x53=83  / 0x55=85)
; ;           |    |__Horizontal Displayed Register                             (R1) H:(0x48=72  / 0x50=80)
; ;           |__Horizontal Total Register                                      (R0) H:(0x65=101 / 0x70=112)
              
intensity: db 0,0,0,0,136,0,34,0,170,0,170,0,170,17,170,68,170,85,170,85,85,238,85,187,119,255,221,255,255,255,255,255

sin_table: ;31 bytes, (output -15..15 index=0..31)
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0  

; db 0,0,1,1,2,3,3,4,5,5,6,7,7,8,8,9,10,10,11,12,12,13,13,14,15,15,16,17,17,18,18,19,20,20,21,21,22,23,23,24,24,25,26,26,27,27,28,28,29,30,30,31,31,32,32,33,33,34,35,35,36,36,37,37,38,38,39,39,40,40,41,41,42,42,43,43,44,44,45,45,45,46,46,47,47,48,48,48,49,49,50,50,50,51,51,52,52,52,53,53,53,54,54,54,55,55,55,56,56,56,57,57,57,57,58,58,58,58,59,59,59,59,60,60,60,60,60,61,61,61,61,61,61,62,62,62,62,62,62,62,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,62,62,62,62,62,62,62,62,61,61,61,61,61,60,60,60,60,60,59,59,59,59,58,58,58,58,57,57,57,57,56,56,56,55,55,55,54,54,54,53,53,53,52,52,52,51,51,50,50,50,49,49,48,48,48,47,47,46,46,45,45,45,44,44,43,43,42,42,41,41,40,40,39,39,38,38,37,37,36,36,35,35,34,34,33,32,32,31,31,30,30,29,29,28,27,27,26,26,25,25,24,23,23,22,22,21,20,20,19,19,18,17,17,16,15,15,14,14,13,12,12,11,10,10,9,9,8,7,7,6,5,5,4,3,3,2,2,1,0,0,0,-1,-1,-2,-3,-3,-4,-5,-5,-6,-6,-7,-8,-8,-9,-10,-10,-11,-11,-12,-13,-13,-14,-15,-15,-16,-16,-17,-18,-18,-19,-20,-20,-21,-21,-22,-23,-23,-24,-24,-25,-26,-26,-27,-27,-28,-28,-29,-30,-30,-31,-31,-32,-32,-33,-33,-34,-34,-35,-36,-36,-37,-37,-38,-38,-39,-39,-40,-40,-41,-41,-42,-42,-43,-43,-44,-44,-44,-45,-45,-46,-46,-47,-47,-48,-48,-48,-49,-49,-50,-50,-50,-51,-51,-51,-52,-52,-53,-53,-53,-54,-54,-54,-55,-55,-55,-56,-56,-56,-56,-57,-57,-57,-58,-58,-58,-58,-59,-59,-59,-59,-60,-60,-60,-60,-60,-61,-61,-61,-61,-61,-61,-62,-62,-62,-62,-62,-62,-62,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-63,-62,-62,-62,-62,-62,-62,-62,-62,-61,-61,-61,-61,-61,-60,-60,-60,-60,-60,-59,-59,-59,-59,-59,-58,-58,-58,-57,-57,-57,-57,-56,-56,-56,-55,-55,-55,-54,-54,-54,-53,-53,-53,-52,-52,-52,-51,-51,-51,-50,-50,-49,-49,-49,-48,-48,-47,-47,-46,-46,-46,-45,-45,-44,-44,-43,-43,-42,-42,-41,-41,-40,-40,-39,-39,-38,-38,-37,-37,-36,-36,-35,-35,-34,-34,-33,-33,-32,-31,-31,-30,-30,-29,-29,-28,-28,-27,-26,-26,-25,-25,-24,-23,-23,-22,-22,-21,-20,-20,-19,-19,-18,-17,-17,-16,-16,-15,-14,-14,-13,-12,-12,-11,-11,-10,-9,-9,-8,-7,-7,-6,-5,-5,-4,-4,-3,-2,-2,-1,0,0,

; slash: incbin "data/slash.spr"
; backslash: incbin "data/backslash.spr"
         
%assign num $-$$
%warning total num
   
times (180*1024)-($-$$) db 0
