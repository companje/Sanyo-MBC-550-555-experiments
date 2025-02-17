public class Bullet extends Particle {
  boolean active;

  void fire() {
    active = true;
    Vector dir = Vector.fromAngle(player.toAngle, 100).normalize();

    //pos
    set(dir);
    mult(60);
    add(player);

    //velocity
    velocity.set(dir);
    velocity.mult(10);
    velocity.add(player.velocity);
  }

  void update() {
    add(velocity);
    warp(this);
  }

  void draw() {
    float xx = -player.x+x+width/2;
    float yy = -player.y+y+height/2;

    if (yy>0 && yy<height && xx>0 &&  xx<width) { //in view
      if (active) {
        pushMatrix();
        translate(xx, yy);
        fill(255);
        rotate(velocity.heading()+HALF_PI);
        image(img_bullet, 0, 0, img_bullet.width/2, img_bullet.height/2);
        popMatrix();
      }
    } else {
      active = false;
    }
  }
}
