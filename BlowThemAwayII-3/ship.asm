update_ship:

  mov bx,ship.prev
  mov bp,ship.pos
  call v_copy             ; previous position of ship

  mov bx,ship.force
  mov bp,ship.forces
  call v_copy             ; force = forces.copy()

  mov bx,ship.force
  mov cx,2
  call v_limit            ; force.limit(25)

  mov bx,ship.forces
  mov bp,ship.force
  call v_sub              ; forces -= force

  mov bx,ship.forces
  mov cx,98
  call v_scale            ; forces *= 0.90

  mov bx,ship.acc
  mov bp,ship.force
  call v_add              ; acceleration += forces

  mov bx,ship.force
  mov cx,0
  call v_mult             ; ///force is altijd maar tijdelijk


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
  mov [ship.vel.magSq],ax  ;USED for debug

.begin_angle:
  mov bx,ship.vel
  call v_if_zero
  jz .end_angle
  call v_heading   
  mov [ship.angle],ax     ; angle = heading(velocity)

  ;calc sprite index from angle in ax
  xor dx,dx
  mov bx,15
  idiv bx                 ; sprite_index = angle/15 (range 0..23)
  mov [ship.sprite_index],ax   
  mov bx,770
  mul bx                  ; img_addr = (668+2 bytes per image * sprite_index)
  add ax,img_first        ; img_addr += img_first (offset)
  mov [ship.img_addr],ax
.end_angle:

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
