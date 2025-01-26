
sin: ; ax in degrees
  push cx
  mov cx,100
  cbw
  imul cx
  add ax,45
  mov cx,9
  cbw
  idiv cx
  pop cx

cos: ; ax in degrees
  push cx;
  mov cx,ax
  mov ax,90
  sub ax,cx
  mov cx,100
  cbw
  imul cx
  add ax,45
  mov cx,9
  cbw
  idiv cx
  pop cx

atan2: ; input bx=y, ax=x
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



  ; mov word [debug.ax], ax
  ; mov word [debug.bx], bx
  ; mov word [debug.cx], cx
  ; mov word [debug.dx], dx

;   set_cursor 10,1
;   print "AX="
;   call write_number_word
;   print "   "

; ; 13441

;   call new_line  
;   print "CX="
;   mov ax,cx
;   call write_number_word
;   print "   "

  ; cmp cx,0
  ; je .error_x_0
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

%macro _atan2 2
  mov ax,%1
  mov bx,%2
  call __atan2
%endmacro

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


