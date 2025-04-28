init_stars:
  mov cx,NUM_STARS*2   ; *2 for both x and y
.lp
  mov bx,cx
  mov ax,[setup+bx]   ; use setup and draw instructions as seed
  mov [rnd.seed],ax
  call rnd
  mov [cs:bx+stars],ax
  loop .lp
  ret

; ───────────────────────────────────────────────────────────────────────────

undraw_and_draw_star:    ; now ax=x, bx=y   location of star in world coords
  mov es,cx

  push cx

  ; undraw star
  push ax
  push bx
    sub ax,[ship.prev.x]
    sub bx,[ship.prev.y]
    call world2screen
    call calc_di_from_bx
    mov ax,0
    stosw
    stosb
  pop bx
  pop ax

; draw star new position
  push ax
  push bx
    sub ax,[ship.pos.x]
    sub bx,[ship.pos.y]
    call world2screen
    call calc_di_from_bx
    mov ax,[draw_stars.shape]
    stosw
    stosb
  pop bx
  pop ax

  pop cx
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_stars:  ; call 3 times, for every color channel
  mov cx,NUM_STARS
  mov si,stars

.lp

  mov ax,0b0001000000000000
  or cx,cx
  jp .l1
  mov ax,0b0011100000010000
.l1
  mov [.shape],ax
  lodsw
  xchg bx,ax
  lodsw
  xchg bx,ax     ; now ax=x, bx=y

  push cx
  mov cx,RED
  call undraw_and_draw_star
  mov cx,GREEN
  call undraw_and_draw_star
  mov cx,BLUE
  call undraw_and_draw_star
  pop cx


.next
  loop .lp
  ret
  .shape dw 0


