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
  add bx,288

  inc cl ; aspect ratio
  mov dx,[y]
  sar dx,cl
  add dx,100
 
  call calc_bit_for_pixel
  or [es:di],dl

  inc bp
  test bp,1023
  jz draw

  call next_channel
  inc word [d]
  ; inc word [x]
  ; inc word [y]

  mov ax,[d]
  mov bx,-10000
  mov dx,10000
  call wrap
  mov [d],ax

  mov ax,[x]
  mov bx,-8500
  mov dx,8500
  call wrap
  mov [x],ax

  mov ax,[y]
  mov bx,-6000
  mov dx,6000
  call wrap
  mov [y],ax

  jmp draw

d: dw 0
x: dw 100
y: dw 1

clamp:
  cmp ax, bx
  jl .too_low       ; AX < BX → clamp to BX
  cmp ax, dx
  jg .too_high      ; AX > DX → clamp to DX
  ret
.too_low:
  mov ax, bx
  ret
.too_high:
  mov ax, dx
  ret

; input:
;   AX = waarde om te wrappen
;   BX = minimum waarde (ondergrens)
;   DX = maximum waarde (bovengrens)
; output:
;   AX = gewrapte waarde binnen [BX, DX]

wrap:
  push cx

  mov cx, dx
  sub cx, bx        ; cx = DX - BX
  inc cx            ; cx = bereikgrootte

  sub ax, bx        ; AX = offset t.o.v. ondergrens
  cwd               ; tekenextensie voor IDIV
  idiv cx           ; AX = AX mod bereikgrootte
                    ; (rest in AX, quotiënt in AX overschreven, rest blijft in DX)
  cmp dx, 0
  jge .no_adjust
  add dx, cx        ; als rest negatief → maak positief

.no_adjust:
  mov ax, dx        ; AX = positieve rest
  add ax, bx        ; terug naar originele schaal

  pop cx
  ret


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



