%include "atan.asm"

v_mult:  ; bx contains address of 4 bytes vector  such as 'ship.vel', cx contains scaler such as 94 (*=.94)
  ; x-axis
  push cx      ; put extra scaler on the stack for second axis
  mov ax,[bx]
  cwd
  imul cx      ; ax*=94
  mov cx, 100
  idiv cx      ; ax/=100
  mov [bx],ax
  pop cx       ; restore scaler from stack for second axis

  ;y-axis
  mov ax,[bx+2]
  cwd
  imul cx      ; ax*=94
  mov cx, 100
  idiv cx      ; ax/=100
  mov [bx+2],ax
  ret

v_add: ; bx contains address of 4 bytes vector such as 'ship.pos', bp contains address of other 4 bytes vector
  ; x+=vx
  mov ax,[bx]
  add ax,[bp]
  mov [bx],ax
  ; y+=vy
  mov ax,[bx+2]
  add ax,[bp+2]
  mov [bx+2],ax
  ret

v_sub:
  ; ...
  ret

v_heading: ; bx contains address of 4 bytes vector
  mov ax,[bx]
  mov bx,[bx+2]
  call atan2
  ret

v_from_angle:
  ; ....
  ; angle = (angle + 360) % 360;

  ;   int q = angle / 90;
  ;   int r = angle % 90;

  ;   int c = (100 * (90 - r) + 45) / 9;  //cos
  ;   int s = (100 * r + 45) / 9;         //sin

  ;   int x = c;
  ;   int y = s;

  ;   if (q==1) {
  ;     x = -s;
  ;     y = c;
  ;   } else if (q==2) {
  ;     x = -x;
  ;     y = -y;
  ;   } else if (q==3) {
  ;     x = s;
  ;     y = -c;
  ;   }

  ;   return new Vec(x*mag, y*mag);
  ret

v_limit: ; bx contains address of 4 bytes vector, cx contains max_length. updates bx
;TEST ME
  mov ax,cx
  mul cx
  xchg ax,cx   ; cx now contains max*max
  mov ax,[bx]
  call v_mag_sq
  cmp ax,cx
  jle .ret
  mov cx,95
  call v_mult
  ; void limit(int max) {
  ;   while (magSq() > max*max) mult(95);
  ; }
.ret:
  ret

v_mag_sq:   ; bx contains address of 4 bytes vector, returns ax
;TEST ME
  mov ax,[bx]
  mul ax
  ret

; Vec copy() {  copy bx vector into bp ?
;     return new Vec(x, y);
;   }


