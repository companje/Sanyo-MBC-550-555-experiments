; GREEN equ 0x1c00
FONT equ 0xFF00
HSPACE equ 0
VSPACE equ 8*80*4
TOPLEFT equ HSPACE*4 + VSPACE
%define MAME

setup:
  push cs
  pop ds
  push bp
  push bp
  push bp

  call generate_sin_table
  call crt_init
  ; call clear_pages

  mov ah,8
  mov es,ax
  ; xor di,di
  ; mov ax,0
  ; xor ax,ax
  ; mov cx,-1
  pop ax ;ax=0
  pop di ;di=0
  mov cx,-1
  rep stosw

  mov ah,0x1c
  mov es,ax
  mov cx,-1
  pop ax
  rep stosw

  jmp switch

y: db 0

draw_frame:
  mov es,ax
  mov di,TOPLEFT
  ; mov ax,FONT
  ; mov ds,ax
  ; mov ax,-1
  xor bx,bx   ; bh=y, bl=x  [0..49]
  mov cx,34 ; rows
.row:
  mov byte [y],cl

  push cx
  mov cx,80
.col:
  ; pop cx
  ; mul cx
  ; push cx
  mov bx,sin_table
  mov al,cl
  xlat
  mov dl,al
  ; mov bx,sin_table ;+64
  mov al,[y]
  xlat
  add al,dl
  ; mul dl

;   xor al,cl
; mov bl,al
;   lea ax,[sin_table+bx]


; mov al,bl

  ; mov bl,cl
  ; lea ax,[sin_table+64+bx]

  ; mul dl

  ; mul byte [y]
  ; shr ax,1
  ; shr ax,1
  ; ; ror bx,1
  ; ; cbw
  ; ; mul cl
  ; mov bx,ax
  ; lea si,[sin_table+bx]
  ; lodsb
  ; push cx
  ;call sin
  ; pop cx

  add ax,bp
  and ax,31
  mov si,ax
  ; add ax,bp
  ; call sin
  ; xchg si,ax

  ; mov si,cx
  ; add si,bp

  times 3 shl si,1
  add si,font ; /////using incbin font otherwise remove this line and set segment to FONT

  movsw
  movsw

  inc bl
  ; pop ax ; restore row counter into ax
  loop .col
  pop cx
  add di,2*4*HSPACE
  inc bh
  loop .row

  inc bp
; and bp,31
;   add bp,[dir]
;   ; inc bp        ; next frame
;   cmp bp,63
;   jne .n
;   neg word [dir]
; .n:
;   or bp,bp
;   jnz .r
;   neg word [dir]

  ; and bp,63

;   cmp bp,179
;   jb .r
;   je .f
;   mov bp,176
;   jmp .r
; .f
;   mov bp,219

  ; and bp,255
.r
  ret

; dir: dw 1

switch:  
  ; %ifdef MAME
  mov ax,0x0800    ; 0x0800 in MAME
  ; %else
  ; mov ax,0x0C00    ; 0x0C00 on Sanyo
  ; %endif

  call draw_frame  ; draw offscreen
  mov al,4         ; switch buffer
  out 0x10,al

  mov ax,0x1c00    ; target segment
  call draw_frame  ; draw offscreen
  mov al,5         
  out 0x10,al      ; switch buffer

  jmp switch

  ; hlt

delay:
  ; mov cx,5000
  ; .delay: 
  ; aam
  loop delay
  ret

crt_init:
  mov al,1
  out 0x30,al
  mov al,0x50
  out 0x32,al
  ret

;   xor bx,bx
; .lp:
;   mov al,bl
;   out 0x30,al           ; address / register select
;   mov al,[iosys+bx]
;   out 0x32,al           ; data
;   inc bx
;   cmp bl,2 ;13
;   jne .lp
;   ret

; https://cpctech.cpcwiki.de/docs/hd6845s/hd6845sp.htm
; iosys: db 0x70,0x50,0x59,0x48,0x41,0x00,0x32,0x38,0x00,0x03,0x00,0x00,0x00;,0x00,0x00,0x00
; iosys: db 112,80,89,72,65,0,50,56,0,3,0,0,0,0,0,0
; crt80: db 0x65,0x50,0x53,0x48,0x69,0x02,0x64,0x64,0x00,0x03,0,0,0,0,0,0
; crt72: db 0x70,0x48,0x55,0x4A,0x41,0x00,0x32,0x38,0x00,0x03,0,0,0,0,0,0
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
              
font: incbin "vertical-gradient-256x8-hcenter.bin"

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

sin_table: 

; cos:
;   add al,64
; sin:
;   mov cl,6
;   mov dl,al        ; dl=angle 0..255
;   shr dl,cl        ; angle/6 = quadrant 0..3
;   mov dh,dl        ; dh=copy of quadrant
;   and dh,1         ; dh=1 if quadrant is odd 1 or 3
;   mov bl,dh        ; bl=dh
;   shl bl,cl        ; r = bl<<6
;   mov ch,dl        ; gt1
;   shr ch,1
;   sub bl,dh        ; s (0 or 63)
;   and al,63        ; i
;   xor al,bl        ; i^bl
;   mov bx,qsin
;   xlat
;   neg ch
;   xor al,ch
;   neg ch,
;   add al,ch
;   add al,128
;   ret

; ------------------------------------

; qsin: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126


%assign num $-$$
%warning total num
times (180*1024)-num db 0
