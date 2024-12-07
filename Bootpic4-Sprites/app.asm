%include "sanyo.asm"

%macro draw_sprite 1
  mov bp,%1
  call _draw_sprite
%endmacro

size equ 0
w equ 0
h equ 1
pos equ 2
x equ 2
y equ 3
vel equ 4
vx equ 4
vy equ 5
frame equ 6
frames equ 7
framesize equ 8
img_data equ 9


_draw_sprite:
  mov bx,[bp+pos]
  call calc_di_from_bx
  mov si,[bp+img_data]
  mov cl,[bp+framesize]
  mov byte al,[bp+frame]
  mul cl
  add si,ax
  mov bx,[bp+size]
  call draw_pic
  call next_frame
  ret

next_frame:
  inc byte [bp+frame]
  mov cl,[bp+frames]
  cmp byte [bp+frame],cl
  jb .done
  mov byte [bp+frame],0
.done
  ret

; ───────────────────────────────────────────────────────────────────────────

setup:
  jmp draw

; ───────────────────────────────────────────────────────────────────────────


draw:
  call _wait


  draw_sprite donut
  draw_sprite stars
  draw_sprite sqr_ani
  draw_sprite walk_fw
  draw_sprite walk_bw
  draw_sprite stand
  draw_sprite walk_left
  draw_sprite walk_right
  draw_sprite flower
  draw_sprite explode
  draw_sprite creep
  draw_sprite bouncer


  jmp draw


; ───────────────────────────────────────────────────────────────────────────

draw4x12:               ; bx should be zero when called
  push bx
  call calc_di_from_bx
  mov bh,4              ; width in cols (1 col = 8px)
  mov bl,4              ; height in rows (1 row = 4px)
  call draw_pic
  pop bx
  add bl,4
  cmp bl,4*8
  jl draw4x12
  mov bl,0
  add bh,4
  cmp bh,4*12
  jl draw4x12
  ret       

; ───────────────────────────────────────────────────────────────────────────

calc_di_from_bx:  ; input bl,bh [0,0,71,49]
  mov ax,144      ; 2*72 cols
  mul bh          ; bh*=144 resultaat in AX
  shl ax,1        ; verdubbel AX
  mov di,ax       ; di=ax (=bh*288)
  shl bl,1        ; bl*=2
  shl bl,1        ; bl*=2
  mov bh,0
  add di,bx       ; di+=bl
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_pic:          ; DI=offset, [BH,BL]=rows,cols
  mov ax, RED
  call draw_channel
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
  call draw_channel
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_channel: 
  push di
  mov es,ax
  xor cx,cx  
  mov cl,bh        ; rows (bh)
.rows push cx
  xor cx,cx
  mov cl,bl        ; cols (bl)
.cols times 2 movsw
  loop .cols
  add di,COLS*4-4*4
  pop cx
  loop .rows
  pop di
  ret 

; ───────────────────────────────────────────────────────────────────────────

_wait:
  push cx
  mov cx,5000
.lp 
  aam
  loop .lp
  pop cx
  ret

; ───────────────────────────────────────────────────────────────────────────

%include "assets.asm"

; times (180*1024)-($-$$) db 0

