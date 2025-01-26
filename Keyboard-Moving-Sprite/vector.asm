%include "math.asm"

v_mult:  ; bx contains address of 4 bytes vector  such as 'ship.vel', cx contains scaler such as 94 (*=.94)
  mov ax,[bx]   ; x
  cwd
  imul cx
  mov [bx],ax

  mov ax,[bx+2] ; y
  cwd
  imul cx
  mov [bx+2],ax
  ret

v_div:  ;bx=address, cx=scaler
  mov ax,[bx]   ; x
  cwd
  idiv cx
  mov [bx],ax
  
  mov ax,[bx+2] ; y
  cwd
  idiv cx
  mov [bx+2],ax
  ret

v_scale:  ; cx=scaler (x100)
  mov ax, [bx]   ; x
  cwd
  imul cx
  push cx
  mov cx,100
  idiv cx
  pop cx
  mov [bx], ax

  mov ax, [bx+2]   ; y
  cwd
  imul cx
  push cx
  mov cx,100
  idiv cx
  pop cx
  mov [bx+2], ax
  ret

v_copy:    ; input bx=target,bp=source: copy vec bp into vec bx
  mov ax,[bp]
  mov [bx],ax
  mov ax,[bp+2]
  mov [bx+2],ax
  ret

v_add: ; bx contains address of 4 bytes vector such as 'ship.pos', bp contains address of other 4 bytes vector
  mov ax,[bx]
  add ax,[bp]     ; bx.x += bp.x
  mov [bx],ax
  mov ax,[bx+2]
  add ax,[bp+2]   ; bx.y += bp.y
  mov [bx+2],ax
  ret

v_sub:
  mov ax,[bx]
  sub ax,[bp]     ; bx.x -= bp.x
  mov [bx],ax
  mov ax,[bx+2]
  sub ax,[bp+2]   ; bx.y -= bp.y
  mov [bx+2],ax
  ret

v_heading: ; bx contains address of 4 bytes vector
  mov ax,[bx]
  mov bx,[bx+2]
  call atan2
  ret

v_from_angle: ; input: ax=angle, bx=mag, output: ax=x, bx=y
  mov cx,360
  add ax,cx
  cwd         ; dx=0
  idiv cx
  xchg ax,dx  ; ax now contains angle wrapped to 360
  mov cx,90
  cwd         ; dx=0
  idiv cx      ; dx now contains angle%90 (angle within quadrant)
  push ax     ; save quadrant 0,1,2,3 on the stack
  mov ax,dx   ; ax now contains angle within quadrant
  push dx     ; save copy of the angle within quadrant for later use
  call sin
  cwd         ; dx=0
  imul bx      ; ax = sin(ax)*mag
  mov cx,bx   ; cx = mag
  mov bx,ax   ; save ax into bx
  pop ax      ; restore angle within quadrant
  call cos
  cwd         ; dx=0
  imul cx      ; ax*=mag
  mov dx,ax   ; dx = cos()*mag
  pop cx      ; cx = quadrant 
  cmp cx,0
  je .q0
  cmp cx,1
  je .q1
  cmp cx,2
  je .q2
.q3: ;else
  mov ax,bx
  mov bx,dx
  neg bx 
  ret
.q2:
  mov ax,dx
  neg ax
  neg bx
  ret
.q1:
  mov ax,bx
  neg ax
  mov bx,dx
  ret
.q0:
  mov ax,dx
  ret

v_limit: ; [bx] input vector, cx=max_length. updates [bx]
  mov ax,cx              ; ax=cx=max_length

  cwd
  imul ax                ; ax*=ax
  mov [.maxSq],ax

  call v_mag_sq          ; ax now contains squared CUR length of [bx]
  mov [.lenSq],ax


  set_cursor 10,30
  mov ax,[.maxSq]
  println_ax

  set_cursor 11,30
  mov ax,[.lenSq]
  println_ax

  cmp word ax,[.maxSq]
  jle .done              ; no work needed

  mov ax,[bx]            ; x
  cwd
  imul word [.maxSq]     ; x*=maxSq
  idiv word [.lenSq]     ; x/=lenSq
  mov word [bx],ax

  mov ax,[bx+2]          ; y
  cwd
  imul word [.maxSq]     ; y*=maxSq
  idiv word [.lenSq]     ; y/=lenSq
  mov word [bx+2],ax
.done
  ret
.maxSq: dw 0
.lenSq: dw 0


v_mag_sq:   ; bx contains address of 4 bytes vector, destroys cx, returns ax
  mov ax,[bx]
  cwd
  imul ax
  mov cx,ax   ; use cx for tmp copy of x*x
  mov ax,[bx+2]
  cwd
  imul ax
  add ax,cx
  ret






