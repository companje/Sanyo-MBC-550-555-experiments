%include "sanyo.asm"
%include "debug.asm"
%include "vector.asm"
%include "stars.asm"
%include "ship.asm"

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

debug_test:
  set_cursor 1,1

  mov ax,-15
  call addForceFromAngle

  mov bx,ship.force
  mov bp,ship.forces
  call v_copy             ; force = forces.copy()

  mov bx,ship.force
  ; mov ax,25
  ; call v_limit            ; force.limit(25)
  call v_mag_sq

  mov bx,ship.forces
  mov bp,ship.force
  call v_sub              ; forces -= force

  call v_println ; bx
  xchg bx,bp
  call v_println ; bp

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
  call v_clear

  mov bx,ship.pos
  mov bp,ship.vel
  call v_add              ; position += velocity

  mov bx,ship.vel
  mov cx,98
  call v_scale            ; velocity *= .98


; ----------------------------------

  ; mov bx,ship.vel
  ; mov cx,100
  ; call v_limit            ; max velocity

  ; mov bx,ship.vel
  ; call v_mag_sq
  ; mov [ship.vel.magSq],ax  ;USED for debug

;------ mov bx,ship.force
;------   mov cx,0
;------   call v_mult             ; ///force is altijd maar tijdelijk
  
  ; print "FORCES: "
  ; mov bx,ship.forces 
  ; call v_println

  ; print "FORCE: "
  ; mov bx,ship.force
  ; call v_println

  ; print "POS: "
  ; mov bx,ship.pos 
  ; call v_println_unsigned

  println "done"
  hlt

setup:
  ; call debug_test
  ; hlt

  call init_stars
  xor bp,bp
  jmp draw


; ───────────────────────────────────────────────────────────────────────────

addForceFromAngle:  ; input ax = current angle + rel angle
  mov cx,5    ; magnitude

  ; mov ax,0 ; TMP

  mov bx,ship.force
  call v_from_angle_mag

  mov bx,ship.forces
  mov bp,ship.force
  call v_add  ; [bx]+=[bp]

  mov bx,ship.force
  call v_clear         ; FORCE wordt hier gebruikt als tmp variabele
   

  ret

; ───────────────────────────────────────────────────────────────────────────

draw:
  push cs
  pop ds   ; make sure DS is set to CS for data lookups like [ship.pos.x]

  call update_ship

  call draw_stars
  call draw_ship_static
  call draw_debug_info

  ; call _wait
  inc word [frame_count]

  call check_keys
  jnz on_key

  jmp draw          ; this code is only getting called when no key is pressed


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
  mov ax,[ship.angle]
  call addForceFromAngle
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_a:
  mov ax,[ship.angle]
  sub ax,90
  call addForceFromAngle
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_d:
  mov ax,[ship.angle]
  add ax,90
  call addForceFromAngle
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_s:   ;;;;;;;;;;;;; remmen:  
  mov bx,ship.forces
  call v_clear

  mov bx,ship.vel
  mov cx,50
  call v_scale

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



