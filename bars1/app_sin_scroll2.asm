org 0
cpu 8086
COLS  equ 64
RED   equ 0xf000
GREEN equ 0x0800
BLUE  equ 0xf400


setup:
  push cs
  pop ds
  push cs
  pop es

  xor bp,bp

  mov cx,255
  mov di,sin_table
  xor ax,ax
.sin_loop: 
  push ax
  push cx
  call sin
  stosb
  pop cx
  pop ax
  inc ax
  loop .sin_loop


  mov al,1
  out 0x30,al      ; set address
  mov al,COLS      
  out 0x32,al      ; set value
  
  mov ax,RED
  mov es,ax
  xor di,di
  xor bx,bx

draw:
  mov ax,di
  mov cl,8    ; /255
  shr ax,cl
  mov cl,2    ; *4
  shl ax,cl
  mov cx,ax   ; keep copy of ax
  mov ax,di
  and ax,3
  or ax,cx    ; al now contains y 0..199

  ; add ax,bp
  add al,[frame]
  xor ah,ah
  
push bx
mov bx,sin_table
xlat

times 4 shr al,1
mov bx,intensity12
xlat
pop bx

  mov [es:di],al


  ; xchg ah,al ; al is now 0, ah is now y

  ; push bx
  ; push cx
  ; push dx
  ; mov bx,0x0101
  ; mov ah,al
  ; xor al,al
  ; ; al=ch_index
  ; ; ah=y
  ; ; bl=frame
  ; ; bh=offset
  ; call calcColor
  



  inc bp
  and bp,511
  or bp,bp
  jnz .cont
  inc byte [frame]
.cont:



  add di,257
  cmp di,12800
  jb draw
  sub di,12800
  jmp draw

  hlt

frame: db 0

intensity12: db 0,34,34,136,170,85, 238, 187, 119, 221,255,255
; intensity: db 0,0,0,0,136,0,34,0,170,0,170,0,170,17,170,68,170,85,170,85,85,238,85,187,119,255,221,255,255,255,255,255

calcColor:
  ; al=ch_index
  ; ah=y
  ; bl=frame
  ; bh=offset

  xchg ch,ah ; keep y in ch
  add al,al   ; ...
  add al,al   ; al = 3*ch_index
  add al,bl   ; +=frame
  add al,bh   ; +=offset
  
  ; call sin
  push bx
  mov bx,sin_table
  xlat
  pop bx

  mov cl,192
  mul cl      ; result in AX, regardless of original value AH
  mov cl,8
  shr ax,cl   ; >>=8    AL now contains barY (0..255 scaled to 0..192)

  cmp ch,al
  jl .zero
  add al,10
  cmp ch,al
  jg .zero
  mov al,255
  ret
.zero
  xor al,al
  ret

; ------------------------------------

cos:
  add al,64
sin:
  ;ax,bx,cx,dx are all affected
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
  ret

; ------------------------------------

qsin_table: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126

sin_table: 


%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
