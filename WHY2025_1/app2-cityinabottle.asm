COLS  equ 80
ROWS  equ 50
GREEN equ 0x1C00
NUM   equ ROWS*COLS
SCALE equ 127

setup:
  push cs
  pop ds
  call init_video

draw:
  xor di,di
  mov cx,NUM ;/ 2 ; /2 for speed
.lp:
  call draw_cell
  loop .lp

  inc word [t]
  xor di,di
  jmp draw


  hlt

init_video:
  mov al, 5
  out 10h, al
  mov al,1
  out 0x30,al
  mov al,COLS
  out 0x32,al
  mov ax,GREEN
  mov es,ax
  ret

calc_xy_and_ray:
  mov ax,di
  mov cl,2
  shr ax,cl
  mov bl,COLS
  div bl
  mov [x],ah
  mov [y],al

  ;calc x-ray 
  push ax
  xchg al,ah  ; al=x
  inc cx      ; cx is now 3
  mul cl
  sub al,SCALE
  mov [a],al

  ;calc y-ray
  pop ax  ; al=y
  dec cx  ; cx is now 2
  shl al,cl ; *=4
  mov cl,SCALE ;
  sub cl,al ; flip vertical
  mov [b],cl

  ret


constrain16:
  and al,15 ;tmp
  ret
  
  cmp al,16
  jb .a
  mov al,16  ; tmp to indicate
.a:
  cmp al,0
  ja .r
  mov al,0
.r: ret


draw_cell:
  push cx
  call calc_xy_and_ray

  mov cl,[b]
  mov [s],cl  ; background
  mov ax,SCALE
  mov [d],al  ; byte
  mov [X],ax
  mov [Y],ax ;
  mov [Z],ax


  call raycast

  xor ah,ah
  mov al,[d]     ; d set by raycast
  imul byte [zs]  ; zs set by raycast
  mov cl,COLS
  idiv cl
  sub al,[s]
  
  mov cl,3
  shr al,cl ; scale color /=8
  xor ah,ah ; important!

  call constrain16

  add ax,dots
  mov si,ax
  movsw
  movsw

  call interlace

  pop cx
  ret

interlace:
  add di,320+24     ; 288+56
  cmp di,16000
  jl .c
  sub di,16000
.c: ret

raycast:
  push cx
  mov byte [d],SCALE
.do:
  mov cl,7
  ;Z
  mov ax,[Z]
  shr ax,cl   ; Z>>7   = ax/=SCALE
  mov [zs],al
  cmp al,COLS
  jge .r      ; if ((Z>>7)>=w) return

  ; X
  mov ax,[X]
  shr ax,cl
  mov [xs],al ; now byte
  ; Y
  mov ax,[Y]
  shr ax,cl
  mov [ys],al ; byte

  call hit
  ; call hit_just_ground_plane
  js .h ; not SF: if !hit()
  mov al,[d]
  mov [prev_d],al
  mov al,[zs]
  mov [d],al

  mov cl,SCALE
  cmp [d],cl
  jnb .v
  ; new dir
  mov [a],cl
  mov [b],cl
  ;tex
  mov ax,[t]
  add al,[xs]
  and al,[ys]
  and al,[zs]
  and al,7
  mov [s],al
.v:
  cmp [prev_d],cl
  jb .r

.h:
  xor ah,ah
  mov al,[a]
  add [X],ax
  mov al,[b]
  sub [Y],ax
  add word [Z],SCALE

  jmp .do
.r: 
  pop cx
  ; mov al,[d]
  ; hlt
  ; mov byte [zs],100
  ; mov byte [d],100
  ret



hit: ; city in a bottle hitTest
  ; mov ax,0
  ; jmp .gnd


  cmp byte [zs],34   ; CITY_DISTANCE
  jbe .gnd

  mov ah,0
  mov al,[xs]
  add ax,[t]
  mov cl,9 ; BUILDING_WIDTH
  div cl
  mov bl,[zs]
  ; push ax
  ; mov cl,8
  ; div cl
  ; mov bx,ax
  mov cl,3
  shr bl,cl
  ; pop ax
  xor al,bl
  mov ah,0


  or al,al
  jz .f1

  mov cl,8
  mul cl
  mov cl,45 ;BUILDING_HEIGHT
  div cl

  mov al,ah ; al now contains ax%45
  mov ah,0

.f1:
  or al,al
  jz .gnd

  mov bx,ax
  mov al,[xs]
  add ax,[t]
  mov cl,99 ; AVENUE_PERIOD
  div cl
  mov al,ah
  mov ah,0
  sub al,27 ; AVENUE_WIDTH

  ; cmp al,0
  or al,al
  jbe .gnd
  mov ax,bx

.gnd:
  add al,[ys]
   ; toch gek want ander gedrag wanneer ik ax gebruik
  ; cbw ; !!!!!!!!!! belangrijk omdat al negatief kan zijn. extend sign into ah
  sub al,6 ; GROUND_PLANE
  ret

  

x: db 0
y: db 0
a: db 0  ; Ray direction in world space
b: db 0  ; Ray direction in world space
c: db 0
s: db 0
d: db 0
prev_d: db 0
X: dw 0  ; World space coordinates
Y: dw 0  ; World space coordinates
Z: dw 0  ; World space coordinates
t: dw 160
w: db COLS
xs: db 0 ; now byte
ys: db 0 ; 
zs: db 0 ; 

dots: incbin "data/vertical-gradient-20x8.bin"

%assign num $-$$
%warning total num
times (180*1024)-($-$$) db 0



