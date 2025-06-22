COLS  equ 72
ROWS  equ 50
BYTES_PER_ROW equ 8*COLS  ; 25 lines
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400

%macro set_cursor 2
  mov di,(%1-1) * BYTES_PER_ROW + (%2-1) * 4   ; one based
%endmacro

%define row bh
%define col bl

setup:
  push cs
  pop ds

  call clear_green

  mov al, 5
  out 10h, al           ; select address 0x1c000 as green video page


draw:

  xor row,row
.for_row:
  xor col,col
.for_col:
  ;draw
  call calc_di_from_bx
  mov si,slash
  call draw_spr

  add col,4

call calc_di_from_bx
  mov si,slash
  call draw_spr

  add col,4

call calc_di_from_bx
  mov si,slash
  call draw_spr

  add col,4

call calc_di_from_bx
  mov si,slash
  call draw_spr

  add col,4

call calc_di_from_bx
  mov si,slash
  call draw_spr

  add col,4

call calc_di_from_bx
  mov si,slash
  call draw_spr

  add col,4

  ; cmp col,12*4
  ; jle .for_col

  ; add row,4
  ; cmp row,8*4
  ; jle .for_row

  hlt

  ; add di,4*4

  ; mov si,backslash
  ; add di,4*4*72-4*4
  ; call draw_spr

  ; mov si,slash
  ; add di,4*4
  ; call draw_spr

  ; add di,4*4

  ; inc bl
  ; cmp bl,5
  ; jne draw

  ; xor bl,bl
  
  ; test di,288
  ; jz draw
  ; add di,72*4*4

  jmp draw

calc_di_from_bx:  ; input bl,bh [0,0,71,49]
  mov ax,144      ; 2*72 cols
  mul bh          ; bh*=144 resultaat in AX
  shl ax,1        ; verdubbel AX
  mov di,ax       ; di=ax (=bh*288)
  shl bl,1        ; bl*=2
  shl bl,1        ; bl*=2
  mov bh,0
  add di,bx       ; di+=bl
  cmp di,0
  jl .clamp_top
  ret
.clamp_top
  xor di,di
  ret

draw_spr:
  push si
  push bx
  mov bx,[si]
  inc si
  inc si
  call draw_pic
  pop bx
  pop si
  ret

; ───────────────────────────────────────────────────────────────────────────

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

clear_green:
  mov ax,GREEN
  call clear_channel
  ret

clear_channel:
  mov es,ax
  mov cx,COLS*ROWS*2
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret

slash: incbin "data/slash.spr"
; backslash: incbin "data/backslash.spr"
         
%assign num $-$$
%warning total num
   
times (180*1024)-($-$$) db 0
