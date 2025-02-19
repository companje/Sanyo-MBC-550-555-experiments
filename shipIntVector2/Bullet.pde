public class Bullet {
  Vector vel = new Vector();
  Vector pos = new Vector();
  boolean active;

  void fire() {
    active = true;
    Vector dir = Vector.fromAngle(player.toAngle);

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
    float xx = -player.pos.x+pos.x+width/2;
    float yy = -player.pos.y+pos.y+height/2;

    if (yy>0 && yy<height && xx>0 &&  xx<width) { //in view
      if (active) {
        pushMatrix();
        translate(xx, yy);
        fill(255);
        //rotate(radians(vel.heading()));
        float m = radians(Vector.fromAngle(player.toAngle).heading());
        rotate(m);
        //rotate(radians(player.angle+90));

        image(img_bullet, 0, 0, img_bullet.width/2, img_bullet.height/2);
        popMatrix();
      }
    } else {
      active = false;
    }
  }
}
