RED   equ 0xf000
GREEN equ 0x0800
BLUE  equ 0xf400

setup:
  push cs
  pop ds
  mov ah,8   ; only in MAME green segment=0x0800
  mov es,ax

draw: 
  mov cx,2<<13
  mov bx,[d]
  
  mov ax,[y]
  cwd
  imul bx
  idiv cx

  push ax
  
  mov ax,[x]
  cwd
  imul bx
  idiv cx

  sub [y],ax ; y-=b
  pop ax
  add [x],ax ; x+=a

  mov cl,5
  mov bx,[x]
  sar bx,cl  
  add bx,[ox]

  inc cl ; aspect ratio
  mov dx,[y]
  sar dx,cl
  add dx,[oy]
 
  call calc_bit_for_pixel
  or [es:di],dl

  inc bp
  and bp,1023
  jnz draw

  inc word [d]
  mov word [x],31 ; 306
  call next_channel
  mov [ox],di
  and word [ox],511
  mov [oy],si
  and word [oy],255

  jmp draw

d: dw 551
x: dw 31 ;306
y: dw 1
ox: dw 288
oy: dw 100

next_channel:
  push es
  pop ax
  ; xor ax,0x400
  cmp ax,RED
  jne .b
  mov ax,GREEN
  jmp .c2
.b:
  cmp ax,BLUE
  je .rd
  mov ax,BLUE
  jmp .c2
.rd:
  mov ax,RED
.c2:
  push ax
  pop es
  ret


calc_bit_for_pixel:
  ; input: BX = x, DX = y
  ; output: DI = offset, DL = bitmask
  mov cx, 3
  push cx
  mov ax, dx         ; AX = y
  and dx, cx         ; DX = y % 4
  mov di, dx         ; DI = y % 4
  dec cx             ; CX = 2
  shr ax, cl         ; AX = y / 4
  mov cx, 288
  mul cx             ; AX *= 288
  add di, ax         ; DI += line offset

  mov ax, bx         ; AX = x
  and bx, 7          ; BX = x % 8
  pop cx             ; CX = 3
  shr ax, cl         ; AX = x / 8
  dec cx
  shl ax, cl         ; AX *= 4
  add di, ax         ; DI += column offset

  mov dl, 80h        ; DL = 0b10000000
  mov cl, bl         ; BL = x % 8
  shr dl, cl         ; DL = bitmask

  ret

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

; ; ------------------------------------

; qsin: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126


%assign num $-$$
%warning total num
times (180*1024)-num db 0



