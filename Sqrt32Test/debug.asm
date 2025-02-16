
draw_debug_info:
  
  set_cursor 1,1

  print "key: "
  mov ax,[key]
  println_ax_bin

  print "frame: "
  mov ax,[frame_count]
  println_ax

  print "x+: "
  mov ax,[ship.pos.x]  
  println_ax_unsigned

  print "y+: "
  mov ax,[ship.pos.y]
  println_ax_unsigned

  print "vx: "
  mov ax,[ship.vel.x]  
  println_ax

  print "vy: "
  mov ax,[ship.vel.y]
  println_ax

  ; print "vel.magSq: "
  ; mov ax,[ship.vel.magSq]
  ; println_ax_unsigned

  print "angle: "
  mov ax,[ship.angle] 
  println_ax

  ; print "index: "
  ; mov ax,[ship.sprite_index]
  ; println_ax

  ; print "img addr: "
  ; mov ax,[ship.img_addr]
  ; println_ax_hex

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

  ; print "DI: "
  ; mov ax,di
  ; println_ax_hex

  ret
