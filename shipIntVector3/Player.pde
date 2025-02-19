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
    tmp.add(360);
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
    if (thrust.get()>1000) thrust.set(1000);

    if (pos.x<0) pos.x+=world_w.get();
    if (pos.y<0) pos.y+=world_h.get();
    if (pos.x>world_w.get()) pos.x-=world_w.get();
    if (pos.y>world_h.get()) pos.y-=world_h.get();
  }

  void draw() {
    pushMatrix();
    fill(255);
    //translate(screen_w.get()/2, screen_h.get()/2);
    //rotate(radians(angle+90));
    //image(img_ship, 0, 0, img_ship.width/2, img_ship.height/2);
    
    set_cursor(16, 35);
    draw_img(img_ship[spriteIndex.get()]);

    popMatrix();
  }
}
