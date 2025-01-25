%include "sanyo.asm"
%include "vector.asm"

ship:
 .pos:
 .pos.x: dw 73728/2                ; 0..73728  (65536)
 .pos.y: dw 51200/2 + 2000         ; 0..51200  (=1024*50)
 .vel: 
 .vel.x: dw 96
 .vel.y: dw 0
 .vel.flags: dw 0
 .acc:
 .acc.x: dw 0
 .acc.y: dw 0
 .forces:
 .forces.x: dw 0
 .forces.y: dw 0
 .angle: dw 0
 .sprite_index: dw 0
 .img_addr: dw img_first
 .prev_di: dw 0

star:
 .x: dw 73728/2                ; 0..73728  (65536)
 .y: dw 51200/2                ; 0..51200  (=1024*50)


color: db Color.G
FRICTION equ 94
STEP equ 500

setup:
  xor bp,bp
  jmp draw

; ───────────────────────────────────────────────────────────────────────────

update_ship:
  ; force = forces.copy()
  ; force.limit(5)
  ; acc.add(force)
  ; forces.sub(force)
  ; forces.mult(90)

  mov bx,ship.vel    ; pointer to ship velocity
  mov cx,94
  call v_mult

  mov bx,ship.pos
  mov bp,ship.vel
  call v_add
  
  mov bx,ship.vel
  call v_heading   ; returns angle in ax
  mov [ship.angle],ax

  ; from angle to ship image frame address
  xor dx,dx
  mov bx,15
  idiv bx
  mov [ship.sprite_index],ax  ; sprite_index = angle/15 = 0..23
  mov bx,770
  mul bx
  add ax,img_first
  mov [ship.img_addr],ax

  ret

; ───────────────────────────────────────────────────────────────────────────

draw_stars:
  


; ───────────────────────────────────────────────────────────────────────────

draw_ship:
  call draw_stars

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx

  cmp [ship.prev_di],di  
  je .return             ; no screen update needed

  mov di,[ship.prev_di]
  
  ; mov bx,0x0808  ; rows,cols
  ; call fill_rect_black

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx
  mov [ship.prev_di],di

  mov si,[ship.img_addr]
  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen ; ax and bx are already set by pop bx, pop ax
  call calc_di_from_bx
  call draw_spr

.return
  ret

; ───────────────────────────────────────────────────────────────────────────

draw:
  push cs
  pop ds   ; make sure DS is set to CS for data lookups like [ship.pos.x]

  call update_ship
  call draw_ship
  call draw_debug_info

  call check_keys
  jnz on_key
  ;else

  call _wait
  inc bp

  jmp draw          ; this code is only getting called when no key is pressed

; ───────────────────────────────────────────────────────────────────────────

draw_debug_info:
  set_cursor 12,45
  print "frame: "
  mov ax,bp
  call write_number_word     ; draw frame counter
  print "  "

  set_cursor 13,45
  print "vx: "
  mov ax,[ship.vel.x]  
  call write_signed_number_word
  print "  "

  set_cursor 14,45
  print "vy: "
  mov ax,[ship.vel.y]
  call write_signed_number_word     ; draw vy
  print "  "

  set_cursor 15,45
  print "angle: "
  mov ax,[ship.angle]  ; # handig om angle van 0 tot 360 te laten lopen ipv -180...180  
  call write_signed_number_word     ; draw frame counter
  print "    "

  set_cursor 16,45
  print "index: "
  mov ax,[ship.sprite_index]  ; # handig om angle van 0 tot 360 te laten lopen ipv -180...180  
  call write_signed_number_word     ; draw frame counter
  print "    "

  set_cursor 17,45
  print "img addr: "
  mov ax,[ship.img_addr]
  call write_signed_number_word     ; draw frame counter
  print "    "

  ret

; ───────────────────────────────────────────────────────────────────────────


on_key:
  set_cursor 2,10
  mov ax,[key]
  call write_binary_word
  cmp ax,'w'
  je on_key_w
  cmp ax,'a'
  je on_key_a
  cmp ax,'s'
  je on_key_s
  cmp ax,'d'
  je on_key_d
.done
  jmp draw  ; no ret here because onkey is called by jnz

; ───────────────────────────────────────────────────────────────────────────

on_key_w:
  sub word [ship.vel.y], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_a:
  sub word [ship.vel.x], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_s:
  add word [ship.vel.y], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_d:
  add word [ship.vel.x], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

print_msg:
  set_cursor 1,10
  call write_string
  ret

; ───────────────────────────────────────────────────────────────────────────

_wait:
  DELAY EQU 250
  mov cx,DELAY
  .lp aam
  loop .lp
  ret

; ───────────────────────────────────────────────────────────────────────────

world2screen:  ; input (ax,bx) = (world.x, world.y)   ; screen (row,col)
  ; WORLD:
  ;   0..73728  (65536) -> col
  ;   0..51200  (=1024*50) -> row
  ; SCREEN (ROW,COL):
  ;   0..49 (row)
  ;   0..71 (col)
  mov cl,10
  shr bx,cl   ; //bl=row 0..49
  shr ax,cl   ; 
  mov bh,al   ; //bh=col 0..71
  xchg bh,bl
  ret

; ───────────────────────────────────────────────────────────────────────────

; FIXME
img_NONE: incbin "data/ship-24.spr"

img_first:
img_right:
img7: incbin "data/ship-7.spr" ;right
img8: incbin "data/ship-8.spr"
img9: incbin "data/ship-9.spr"
img_down_right:
img10: incbin "data/ship-10.spr" ;down-right
img11: incbin "data/ship-11.spr"
img12: incbin "data/ship-12.spr"
img_down:
img13: incbin "data/ship-13.spr" ;down
img14: incbin "data/ship-14.spr"
img15: incbin "data/ship-15.spr"
img_down_left:
img16: incbin "data/ship-16.spr" ;down-left
img17: incbin "data/ship-17.spr"
img18: incbin "data/ship-18.spr"
img_left:
img19: incbin "data/ship-19.spr" ;left
img20: incbin "data/ship-20.spr"
img21: incbin "data/ship-21.spr"
img_up_left:
img22: incbin "data/ship-22.spr" ;up-left
img23: incbin "data/ship-23.spr"
img24: incbin "data/ship-24.spr"
img_up:
img1: incbin "data/ship-1.spr" ;up
img2: incbin "data/ship-2.spr"
img3: incbin "data/ship-3.spr"
img_up_right:
img4: incbin "data/ship-4.spr" ;up-right
img5: incbin "data/ship-5.spr"
img6: incbin "data/ship-6.spr"



times (180*1024)-($-$$) db 0



