public class Player {
  Vector vel = new Vector();
  Vector pos = new Vector();


  void update() {
    tmp.set(toAngle.get());
    tmp.sub(angle.get());
    tmp.mult(20);
    tmp.div(100);
    tmp.add(angle.get());
    angle.set(tmp.get());

    //angle = angle + (toAngle - angle) * 20 / 100;

    tmp.set(angle.get());
    while (tmp.get()<0) tmp.add(360);
    tmp.mod(360);
    tmp.div(15);

    spriteIndex.set(tmp.get()); // ((angle + 360) % 360) / 15 );

    tmp.set(thrust.get());
    tmp.div(10);
    if (tmp.get()<10) tmp.set(10);
    if (tmp.get()>50) tmp.set(50);

    vel.set(Vector.fromAngle(angle.get()));
    vel.mult(tmp.get());
    vel.div(30);
    pos.add(vel);

    thrust.mult(99);
    thrust.div(100);

    if (thrust.get()<1) thrust.set(1);
    if (thrust.get()>500) thrust.set(500);

    if (pos.x.get()<0) pos.x.add(world_w.get());
    if (pos.y.get()<0) pos.y.add(world_h.get());
    if (pos.x.get()>world_w.get()) pos.x.sub(world_w.get());
    if (pos.y.get()>world_h.get()) pos.y.sub(world_h.get());
  }

  void draw() {
    set_row_col(16, 36);
    si.mov(img_up);
    draw_sprite();
    
    //img_ship[spriteIndex.get()]
    //draw_img(img_ship[spriteIndex.get()]);
  }
}
