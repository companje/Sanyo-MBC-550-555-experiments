; ───────────────────────────────────────────────────────────────────────────

xy_from_angle: ; input: ax=angle, (no magnitude!) output: ax:dx = x:y
  push ax      ; save angle
  call sin
  xchg dx,ax
  pop ax       ; restore angle
  call cos
  ret

; ───────────────────────────────────────────────────────────────────────────

angle_wrap: ; makes any angle positive within 0..360
  or ax,ax
  jge .done
  add ax,360
  jmp angle_wrap
.done
  ret

; ───────────────────────────────────────────────────────────────────────────

sin: ; ax in degrees (pos or neg), returns sin(ax) -100..100
  push bx
  mov bx,.lut
  call angle_lookup
  pop bx
  ret
.lut: 
  db 0,25,50,70,86,96,100,96,86,70,50,25,0,-25,-50,-70,-86,-96,-100,-96,-86,-70,-50,-25,0

; ───────────────────────────────────────────────────────────────────────────

cos: ; ax in degrees (pos or neg), returns sin(ax) -100..100
  push bx
  mov bx,.lut
  call angle_lookup
  pop bx
  ret
.lut: 
  db 100,96,86,70,50,25,0,-25,-50,-70,-86,-96,-100,-96,-86,-70,-49,-25,0,25,49,70,86,96,100

; ───────────────────────────────────────────────────────────────────────────

angle_lookup: ; bx=lookup table, ax=angle (>=0) 0..360, result in ah
  call angle_wrap ; makes angle between 0..360
  push dx
  push bx
  cwd ; clear dx (always 0 because angle wrap makes ax positive)
  mov bx,15    ; ax/=15
  div bx
  pop bx
  xlat
  cbw ; clear ah, except the sign if al is negative
  pop dx
  ret

; ───────────────────────────────────────────────────────────────────────────

atan2: ; input bx,ax=y,x, output ax=angle
  cmp ax,0
  jnz .x_not_0
  cmp bx,0
  jl .y_lte_0
  mov ax,90
  jmp .ret

.y_lte_0:
  mov ax,-90
  jmp .ret

.x_not_0:
  push ax
  push ax   ; keep a copy of x
  mov ax,bx
  mov cx,111
  cwd       ; dx=0
  imul cx
  pop cx;   ; restore x

  cwd
  idiv cx   ; ax/=x
  cwd
  call atan
  pop cx;   ; restore x
  cmp cx,0
  jl .x_lt_0
  jmp .ret

.x_lt_0:
  cmp bx,0
  jge .y_gte_0
  sub ax,180
  jmp .ret

.y_gte_0:
  add ax,180
  jmp .ret

.ret:
  cmp ax,0
  jl .add360
  ret
.add360:
  add ax,360
  ret
.error_x_0
  set_cursor 1,1
  print "Division Error in atan2: x=0"
  hlt

; ───────────────────────────────────────────────────────────────────────────

atan: ; cx=z, return value in ax, bx destroyed, cx destroyed, dx destroyed
  mov cx,ax           ; z
  cwd
  cmp cx,111
  jg .z_gt_scale      ; if (z>111)
  cmp cx,-111         ; if (z<-111) 
  jl .z_lt_minus_scale
  cwd
  imul ax             ; ax *= ax  (z*z)
  mov bx,333     
  idiv bx             ; ax /= 333   Taylor-benadering
  cwd
  mov bx,ax
  mov ax,111
  sub ax,bx           ; ax-=111  
  mov bx,180
  imul bx             ; ax*=180 
  imul cx             ; ax*=z
  mov bx,111
  idiv bx             ; ax/=111
  mov bx,314
  cwd
  idiv bx             ; ax/=314
  cwd
  ret

.z_gt_scale:
  mov ax,12321        ; 12321 = 111*111 (squared scale)
  idiv cx             ; ax/=z
  call atan           ; recursion
  mov bx,ax
  mov ax,90
  sub ax,bx
  ret

.z_lt_minus_scale:
  mov ax,12321        ; 12321 = 111*111 (squared scale)
  idiv cx             ; ax/=z
  call atan           ; recursion
  mov bx,ax
  mov ax,-90
  sub ax,bx
  ret

; ───────────────────────────────────────────────────────────────────────────

__atan2:
  push ax
  push bx
  print "atan2(x="
  call write_signed_number_word
  print ",y="
  pop ax
  push bx
  call write_signed_number_word
  print ")="
  pop bx
  pop ax
  call atan2
  call write_signed_number_word
  mov al,' '
  call write_char
  call new_line
  ret

; ───────────────────────────────────────────────────────────────────────────

rnd:
  push bx
  push cx
  push dx
  mov cx, 16
.lp
  mov ax,[.seed]
  xor dx, dx           ; DX wordt gebruikt om het nieuwe bit te berekenen
  mov bx, ax           ; Kopieer de huidige waarde van AX naar BX
  ; shr bx, 0            ; Feedback van het laagste bit (bit 0)
  xor dl, bl           ; Voeg de laagste bit aan DX toe

  shr bx, 1            ; Feedback bit 1
  xor dl, bl

  push cx
  mov cl,4
  shr bx, cl           ; Feedback bit 4
  xor dl, bl

  mov cl,15 
  shr bx, cl           ; Feedback bit 15
  xor dl, bl

  shl ax, 1            ; Verschuif de registerwaarde in AX
  or ax, dx            ; Voeg de berekende bit toe

  pop cx
  loop .lp        ; Herhaal totdat CX 0 is

  mov [.seed],ax
  pop dx
  pop cx
  pop bx
  ret
  .seed dw 0B400h
