%include "sanyo.asm"
%include "vector.asm"

ship:
 .pos:
 .pos.x: dw 73728/2              ; 0..73728  (65536)
 .pos.y: dw 51200/2 - 10000      ; 0..51200  (=1024*50)
 .prev:
 .prev.x: dw 73728/2              ; 0..73728  (65536)
 .prev.y: dw 51200/2 - 10000      ; 0..51200  (=1024*50)
 .vel: 
 .vel.x: dw 0
 .vel.y: dw 0
 .vel.flags: dw 0
 .vel.magSq: dw 0
 .acc:
 .acc.x: dw 0
 .acc.y: dw 0
 .forces:             ; accumulated forces over time
 .forces.x: dw 0
 .forces.y: dw 0
 .force:              ; force for this frame derived from accumulated forces
 .force.x: dw 0
 .force.y: dw 0
 .angle: dw 0
 .sprite_index: dw 0
 .img_addr: dw img_first
 .prev_di: dw 0

debug:
  .ax: dw 0
  .bx: dw 0
  .cx: dw 0
  .dx: dw 0

frame_count: dw 0
color: db Color.G
FRICTION equ 94
STEP equ 1000
FRAME_DELAY EQU 1
NUM_STARS equ 50
stars: times (2*NUM_STARS) dw 0  ; 50 stars at 0,0

; debug_test:
;   mov ax,16
;   call sqrt
;   println_ax
;   println "done"
;   hlt

setup:
  ; call debug_test
  ; hlt
  call init_stars
  xor bp,bp
  jmp draw

; ───────────────────────────────────────────────────────────────────────────

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

draw:
  push cs
  pop ds   ; make sure DS is set to CS for data lookups like [ship.pos.x]

  call update_ship

  call draw_stars


  call draw_ship_static
  ; call draw_debug_info

  call _wait
  inc word [frame_count]

  call check_keys
  jnz on_key

  jmp draw          ; this code is only getting called when no key is pressed


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

; ───────────────────────────────────────────────────────────────────────────

update_ship:

  mov bx,ship.prev
  mov bp,ship.pos
  call v_copy             ; previous position of ship

  mov bx,ship.force
  mov bp,ship.forces
  call v_copy             ; force = forces.copy()

  mov bx,ship.force
  mov cx,1
  call v_limit            ; force.limit(25)

  mov bx,ship.forces
  mov bp,ship.force
  call v_sub              ; forces -= force

  mov bx,ship.forces
  mov cx,90
  call v_scale            ; forces *= 0.90

  mov bx,ship.acc
  mov bp,ship.force
  call v_add              ; acceleration += forces

  mov bx,ship.vel
  mov bp,ship.acc
  call v_add              ; velocity += acceleration

  mov bx,ship.acc
  mov cx,0
  call v_mult             ; acceleration = 0

  mov bx,ship.pos
  mov bp,ship.vel
  call v_add              ; position += velocity

  mov bx,ship.vel
  mov cx,98
  call v_scale            ; velocity *= .98

  mov bx,ship.vel
  mov cx,100
  call v_limit            ; max velocity

  mov bx,ship.vel
  call v_mag_sq
  mov [ship.vel.magSq],ax

  mov bx,ship.vel
  call v_heading   
  mov [ship.angle],ax     ; angle = heading(velocity)

  xor dx,dx
  mov bx,15
  idiv bx                 ; sprite_index = angle/15 (range 0..23)
  mov [ship.sprite_index],ax   
  mov bx,770
  mul bx                  ; img_addr = (668+2 bytes per image * sprite_index)
  add ax,img_first        ; img_addr += img_first (offset)
  mov [ship.img_addr],ax

  ret

; ───────────────────────────────────────────────────────────────────────────

draw_ship_static:
  mov di,8784
  mov si,[ship.img_addr]
  call draw_spr
  ret

draw_ship:
  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx

  cmp [ship.prev_di],di  
  ; je .return             ; no screen update needed >>>  DISABLED because ship on fixed position

  mov di,[ship.prev_di]

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx
  cmp di,0
  jg .ok
  mov di,0
.ok
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

draw_debug_info:
  
  set_cursor 1,1

  print "key: "
  mov ax,[key]
  println_ax_bin

  print "frame: "
  mov ax,[frame_count]
  println_ax

  print "x: "
  mov ax,[ship.pos.x]  
  println_ax

  print "y: "
  mov ax,[ship.pos.y]
  println_ax

  print "vx: "
  mov ax,[ship.vel.x]  
  println_ax

  print "vy: "
  mov ax,[ship.vel.y]
  println_ax

  print "vel.magSq: "
  mov ax,[ship.vel.magSq]
  println_ax_unsigned

  print "angle: "
  mov ax,[ship.angle] 
  println_ax

  print "index: "
  mov ax,[ship.sprite_index]
  println_ax

  print "img addr: "
  mov ax,[ship.img_addr]
  println_ax_hex

  print "force.x: "
  mov ax,[ship.force.x]
  println_ax

  print "force.y: "
  mov ax,[ship.force.y]
  println_ax

  print "forces.x: "
  mov ax,[ship.forces.x]
  println_ax

  print "forces.y: "
  mov ax,[ship.forces.y]
  println_ax

  print "DI: "
  mov ax,di
  println_ax_hex

  ret

; ───────────────────────────────────────────────────────────────────────────


on_key:
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
  add word [ship.forces.y], -STEP

  ; mov ax,[ship.angle]
  ; mov bx,1    ; magnitude
  ; call v_from_angle
  ; add word [ship.forces.x], ax
  ; add word [ship.forces.y], bx

  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_a:
  add word [ship.forces.x], -STEP

  ; mov ax,[ship.angle]
  ; sub ax,90   ; angle
  ; mov bx,1    ; magnitude
  ; call v_from_angle
  ; add word [ship.forces.x], ax
  ; add word [ship.forces.y], bx

  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_d:
  add word [ship.forces.x], STEP

  ; mov ax,[ship.angle]
  ; add ax,90   ; angle
  ; mov bx,1    ; magnitude
  ; call v_from_angle
  ; add word [ship.forces.x], ax
  ; add word [ship.forces.y], bx

  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_s:
  add word [ship.forces.y], STEP

  ;;;;;;;;;;;;; remmen:

  ; mov bx,ship.forces
  ; mov cx,0
  ; call v_mult

  ; mov bx,ship.vel
  ; mov cx,50
  ; call v_scale

  jmp on_key.done
  ; ───────────────────────────────────────────────────────────────────────────


_wait:
  mov cx,FRAME_DELAY
  .lp aam
  loop .lp
  ret

; ───────────────────────────────────────────────────────────────────────────

world2screen:  ; input (ax,bx) = (world.x, world.y)   ; screen (row,col) ; output (bx)
  ; WORLD:
  ;   0..73728  (65536) -> col
  ;   0..51200  (=1024*50) -> row
  ; SCREEN (ROW,COL):
  ;   0..49 (row)
  ;   0..71 (col)
  push cx
  mov cl,10
  shr bx,cl   ; //bl=row 0..49
  shr ax,cl   ; 
  dec cl
  dec cl      ; cl=8
  shl bx,cl   
  ; mov bh,al   ; //bh=col 0..71
  ; xchg bh,bl
  or bx,ax
  pop cx
  ret

; ───────────────────────────────────────────────────────────────────────────

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


; %assign num $-$$
; %warning total num

times (180*1024)-($-$$) db 0



