
class Ship {
  Vec pos = new Vec("pos");
  Vec prev = new Vec("prev");
  Vec vel = new Vec("vel");
  Vec acc = new Vec("acc");
  Vec force = new Vec("force");
  Vec forces = new Vec("forces");
  Mem16 angle = mem16().set(15);
  Mem16 img_addr = mem16();
  Mem16 sprite_index = mem16();
}

void update_ship() {
  mov(bx, ship.prev);
  mov(bp, ship.pos);
  v_copy();             //previous position of ship

  mov (bx, ship.force);
  mov (bp, ship.forces);
  v_copy();             // force = forces.copy()

  mov(bx, ship.force);
  mov(ax, 25);
  v_limit();            // force.limit(25)

  mov(bx, ship.forces);
  mov(bp, ship.force);
  v_sub();              // forces -= force

  mov(bx, ship.forces);
  mov(cx, 90);
  v_scale();            // forces *= 0.90

  mov(bx, ship.acc);
  mov(bp, ship.force);
  v_add();              // acceleration += forces

  mov(bx, ship.vel);
  mov(bp, ship.acc);
  v_add();              // velocity += acceleration

  mov (bx, ship.acc);
  v_clear();

  mov(bx, ship.pos);
  mov(bp, ship.vel);
  v_add();              // position += velocity

  mov(bx, ship.vel);
  mov(cx, 98);
  v_scale();            // velocity *= .98


  //.begin_angle:
  mov(bx, ship.vel);
  //call v_if_zero
  //jz .end_angle
  if (v_if_zero()) {
    v_heading();
    mov(ship.angle, ax); // angle = heading(velocity)

    //calc sprite index from angle in ax
    xor(dx, dx);
    mov(bx, 15);
    idiv(bx); // sprite_index = angle/15 (range 0..23)
    mov(ship.sprite_index, ax);
    mov(bx, 770);
    mul(bx);                   // img_addr = (668+2 bytes per image * sprite_index)
    add(ax, img_first);        // img_addr += img_first (offset)
    mov(ship.img_addr, ax);
  }
  //.end_angle:
}

void draw_ship_static() {
  mov(di, 8784);
  mov(si, ship.img_addr);
  draw_sprite();
}
