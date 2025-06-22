; GREEN equ 0x1c00
FONT equ 0xFF00
HSPACE equ 15
TOPLEFT equ HSPACE*4

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

  jmp switch

  hlt

delay:
  mov cx,5000
  .delay: 
  ; aam
  loop .delay
  ret

draw_frame:
  mov es,ax
  mov di,TOPLEFT
  mov ax,FONT
  mov ds,ax
  mov ax,-1
  xor bx,bx   ; bh=y, bl=x  [0..49]
  mov cx,50 ; rows
.row:
  push cx
  mov cx,50
.col:
  mov si,bp
  times 3 shl si,1
  movsw
  movsw
  inc bl
  loop .col
  pop cx
  add di,2*4*HSPACE
  inc bh
  loop .row
  inc bp
  and bp,255

  ; mov ax,bx
  ; mov cx,80*4*25 ; 4*80*25rows
  ; rep stosw
  ret

clear_pages:
  mov ax,0x0800
  call clear_page
  mov ax,0x0c00
  call clear_page
  mov ax,0x1c00
  call clear_page
  mov ax,0x2c00
  call clear_page
  mov ax,0x3c00
  call clear_page
  ret

clear_page:
  mov es,ax
  xor di,di
  mov ax,0
  mov cx,8000
  rep stosw
  ret

  hlt

; https://cpctech.cpcwiki.de/docs/hd6845s/hd6845sp.htm
iosys: db 0x70,0x50,0x59,0x48,0x41,0x00,0x32,0x38,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00
; iosys: db 112,80,89,72,65,0,50,56,0,3,0,0,0,0,0,0
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
              
            
times (180*1024)-($-$$) db 0
