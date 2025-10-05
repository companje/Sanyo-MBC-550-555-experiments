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
  mov [Y],ax
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

;   add di,288+6
;   cmp di,14400
;   jl .c
;   sub di,14400
; .c:

  pop cx
  ret

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

  call hit2
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
  mov al,[t]
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

hit2:
  ; mov al,[ys]
  ; sub al,6 ; GROUND_PLANE
  ; ret
  jmp hit.bxdone

hit: ; city in a bottle hitTest
  ; xor ax,ax
  mov al,[xs]
  cbw ; !!
  add ax,[t]
  mov cl,9
  div cl

  mov bl,[zs]
  mov cl,3
  shr bl,cl
  xor al,bl

  cbw
  ; xor ah,ah
  shl ax,cl ; *=8, cl is still 3
  mov cl,45
  div cl   ; remainder % in ah
  
;?????
; cbw nodig hier ???
  xchg al,ah  ; al=ah
  cbw
  ; xor ah,ah   ; ah=0
;?????
  push ax ; modifier

  or ax,ax ; c3: ax==0 ? 0 : 1
  mov ax,0 ; don't affact flag
  jz .c3done
  inc ax ; mov ax,1
.c3done:
  push ax ; condition3

  cmp byte [zs],34 ; condition 1 (CITY_DISTANCE)
  jle .c1done
  mov ax,0 ; don't affact flag
  inc ax
.c1done:
  push ax ; condition 1

  ;ah always 0 here
  ; mov al,[xs]
  ; cbw
  ; add ax,[t]
  ; mov cl,99
  ; div cl
  ; xchg al,ah ; remainder now in al
  ; cbw ; ?
  ; ; xor ah,ah
  ; cmp ax,27 ; condition 2 AVENUE_WIDTH
  ; mov ax,0 ; don't affact flag
  ; jle .c2done
  ; inc ax

  mov ax,1 ; condition 2 always on: no streets between buildings

.c2done:
  ; push ax ; condition 2  ; overbodig
  ; pop ax ; condition 2   ; overbodig
  pop bx
  and ax,bx
  pop bx
  and ax,bx

  pop bx ; combined modifier
  or ax,ax
  jnz .bxdone 
  xor bx,bx  ; if (ax==0) bx=0
.bxdone:
  ; mov al,[ys]
  ; sub al,6 ; GROUND_PLANE
  ; ret
  ; mov ah,0
  mov al,[ys]
  cbw ; !!!!!!!!!! belangrijk omdat al negatief kan zijn. extend sign into ah
  sub ax,6 ; GROUND_PLANE
  ; add ax,bx
  ; or ax,ax  ; if SF (ax<0) then hit
  ret

; hit3:
; boolean hitTest(float X, float Y, float Z, float t) {
;   //return Z%50>30 && (Y+110)%50<20 && X%50<20;
;   float x=(X+100)%50;
;   float y=(Y+110)%50;
;   float z=Z;
;   //Z near=62 ... far=98 
;   return x>20 && y<20 && z>80;   



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
t: dw 0
w: db COLS
xs: db 0 ; now byte
ys: db 0 ; 
zs: db 0 ; 

dots: incbin "data/vertical-gradient-20x8.bin"

%assign num $-$$
%warning total num
times (180*1024)-($-$$) db 0



