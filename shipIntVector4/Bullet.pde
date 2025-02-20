public class Bullet {
  Vector vel = new Vector();
  Vector pos = new Vector();
  boolean active;

  void fire() {
    active = true;
    Vector dir = Vector.fromAngle(toAngle.get());

    //pos
    pos.set(dir);
    pos.mult(6);
    pos.add(player.pos);

    //vel
    vel.set(dir);
    vel.add(player.vel);
  }

  void update() {
    pos.add(vel);
    warp(pos);
  }

  void draw() {
    float xx = -player.pos.x.get()+pos.x.get()+screen_w.get()/2;
    float yy = -player.pos.y.get()+pos.y.get()+screen_h.get()/2;

    if (yy>0 && yy<screen_h.get() && xx>0 &&  xx<screen_w.get()) { //in view
      if (active) {
        pushMatrix();
        translate(xx, yy);
        fill(255);
        float m = radians(Vector.fromAngle(toAngle.get()).heading());
        rotate(m);
        image(img_bullet, 0, 0, img_bullet.width/2, img_bullet.height/2);
        popMatrix();
      }
    } else {
      active = false;
    }
  }
}
