atan: ; cx=z, return value in ax, bx destroyed, cx destroyed, dx destroyed
  mov cx,ax   ; z

  hlt
  
  int3

  cmp cx,111
  ja .if_z_gt_scale  ; if (z>111)

  cmp cx,-111        ; if (z<-111) 
  jb .if_z_lt_minus_scale


  ;else
  xor dx,dx           ; dx=0 (prevent overflow) 
  imul ax              ; ax *= ax  (z*z)
  mov bx,333
  xor dx,dx           ; dx=0 (prevent overflow) 
  idiv bx             ; ax /= 333   Taylor-benadering
  mov bx,ax
  mov ax,111
  sub ax,bx          ; ax-=111
  mov bx,180
  xor dx,dx           ; dx=0 (prevent overflow) 
  imul bx             ; ax*=180
  xor dx,dx           ; dx=0 (prevent overflow) 
  imul cx             ; ax*=z
  mov bx,111
  xor dx,dx           ; dx=0 (prevent overflow) 
  idiv bx             ; ax/=111
  mov bx,314
  xor dx,dx           ; dx=0 (prevent overflow) 
  idiv bx             ; ax/=314
  ret

.if_z_gt_scale:
  mov ax, 12321       ; 12321 = 111*111 (squared scale)
  xor dx,dx           ; dx=0 (prevent overflow) 
  idiv cx             ; ax/=z

  call atan          ; recursion
  mov bx,ax
  mov ax,90
  sub ax,bx
  ret

.if_z_lt_minus_scale:
  mov ax, 12321      ; 12321 = 111*111 (squared scale)
  xor dx,dx           ; dx=0 (prevent overflow) 
  idiv cx             ; ax/=z
  call atan          ; recursion
  mov bx,ax
  mov ax,-90
  sub ax,bx
  ret



; int atan2(int y, int x) {
;   if (x!=0) {
;     ax = y;
;     ax *= 111;
;     ax /= x;
;     ax = atan(ax);
;   }
;   if (x < 0 && y >= 0) ax+=180;
;   else if (x < 0 && y < 0) ax-=180;
;   else if (x == 0 && y > 0) ax=90;
;   else if (x == 0 && y < 0) ax=-90;
;   return ax;
; }


; ───────────────────────────────────────────────────────────────────────────
