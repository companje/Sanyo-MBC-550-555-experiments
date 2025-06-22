%macro next_effect 0
  
%endmacro

%macro generate_sin_table 0
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
%endmacro
