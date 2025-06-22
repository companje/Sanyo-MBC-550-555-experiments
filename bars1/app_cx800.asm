org 0
cpu 8086
COLS  equ 72
RED   equ 0xf000
GREEN equ 0x0800
BLUE  equ 0xf400


setup:
  push cs
  pop ds

  jmp draw

  ; di=offset
  ; ah=value/pattern
  ; al=channel_index (0,1,2 = R,G,B)
  ; mov al,1
  ; mov ah,255
  ; mov di,0
  ; call drawLine     ;(di, bl, );

  hlt

draw:

  mov cx,799
.lp_i:
  mov ax,cx
  and al,3
  cmp al,3
  jb .cont
  loop .lp_i
.cont:
  push cx

  mov bl,al   ; bl = cx&3 = 0..3
  mov ax,cx
  times 2 shr ax,1    ; al = ax = y = cx>>2 = 0..200
  push ax     ; store y 0..200 for calcColor
  

  ; calculate di
  mov di,ax
  and di,3       ; di = (y & 3)  
  times 2 shr ax,1    ; y>>2 = 0..100
  mov cx,288
  mul cx          ; ax now contains (y>>2)*288
  add di,ax       ; now di = (y >> 2) * 288 + (y & 3);


  ; calcColor(y, frameCount * 2, ch, bar * 10);
  ; al=ch_index
  ; ah=y
  ; bl=frame
  ; bh=offset
  pop ax      ; al now contains y = 0..200 again
  
  mov ah,al
  mov al,bl   ; channel index
  
  push bx
  mov bx,bp   ; bl = frame
  mov bh,0    ; bh = offset = 0 (in case of multiple bars)
  ; call calcColor
  
  mov al,bl ; frame for test

  pop bx


  ; di=offset
  ; ah=value/pattern
  ; al=channel_index (0,1,2 = R,G,B)
  mov ah,al   ; ah now contains the return value of calcColor for this channel
  mov al,bl    ; the channel index
  call drawLine     ;(di, bl, );

  pop cx
  loop .lp_i
; ---------

  inc bp
  ; pop cx
  jmp draw

drawLine:
  ; di=offset
  ; ah=value/pattern
  ; al=channel_index (0,1,2 = R,G,B)
  xchg al,ah
  mov bx,RED
  or ah,ah
  jz .wr
  mov bx,GREEN
  test ah,1
  jnz .wr
  mov bx,BLUE
.wr:
  mov es,bx
  mov cx,1    ; tmp: was COLS
.lp:
  stosb
  add di,3
  loop .lp
  ret

; ------------------------------------

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
  call sin

  mov cl,192
  mul cl      ; result in AX, regardless of original value AH
  mov cl,8
  shr ax,cl   ; >>=8     AL now contains barY (0..255 scaled to 0..192)

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
  mov bx,qsin
  xlat
  neg ch
  xor al,ch
  neg ch,
  add al,ch
  add al,128
  ret

; ------------------------------------

qsin: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126


%assign num $-$$
%warning total num

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
