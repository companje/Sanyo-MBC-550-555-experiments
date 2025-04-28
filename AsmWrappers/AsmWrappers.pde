Sanyo sanyo = new Sanyo();
Ship ship = new Ship();
PApplet app = this;
int img_ship[] = new int[24];
int img_up; //abs address?
int img_first;

void setup() {
  size(640, 400);
  sanyo.setup();

  for (int i=0; i<24; i++) img_ship[i] = incbin("data/ship-"+(((i+6)%24)+1)+".spr");
  img_up = img_ship[18];
  img_first = img_ship[0];

  mov(ship.img_addr, img_up);

  mov(ax, 36);
  mov(dx, 3);
  mov(bx, ship.pos);
  v_set();

  mov(ship.vel.y, 0);
  mov(ship.vel.x, 0);

  mov(bx, ship.pos);
  mov(bp, ship.vel);
  v_add();
}

void draw() {
  //set_cursor(ship.pos.y.get(), ship.pos.x.get());
  //mov(si, img_ship[(frameCount/5)%24]);
  //draw_sprite();

  update_ship();
  
  draw_ship_static();

  sanyo.draw();
}

void keyPressed() {
  if (key == 'a' || key == 'A') on_key_a();
  else if (key == 'd' || key == 'D') on_key_d();
  else if (key == 'w') on_key_w();
  else if (key == 's') on_key_s();
}

void on_key_w() {
  mov(ax, ship.angle.get());
  addForceFromAngle();
  println(ship.forces);
}

void on_key_a() {
  mov(ax, ship.angle.get());
  sub(ax, 90);
  addForceFromAngle();
}

void on_key_d() {
  mov(ax, ship.angle.get());
  add(ax, 90);
  addForceFromAngle();
}

void on_key_s() {  // remmen
  mov(bx, ship.forces);
  //v_clear();
  mov(bx, ship.vel);
  mov(cx, 50);
  //v_scale();
}
