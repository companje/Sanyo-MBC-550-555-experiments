public class Player extends Particle {
  int toAngle = -90;
  int angle = toAngle;
  int thrust = 6;

  void update() {
    angle = (int)lerp(angle, toAngle, .2);

    Vector dir = Vector.fromAngle(angle, 100).normalize();

    velocity.set(dir);
    velocity.mult(constrain(thrust/10., 1, 12));
    add(velocity);

    thrust *= 99;
    thrust /= 100;
    thrust = constrain(thrust, 1, 1000);

    if (x<0) x+=world_w;
    if (y<0) y+=world_h;
    if (x>world_w) x-=world_w;
    if (y>world_h) y-=world_h;
  }

  void draw() {
    pushMatrix();
    fill(255);
    translate(width/2, height/2);
    //scale(.5);
    //rotate(radians(angle+90));
    rotate(velocity.heading()+HALF_PI);

    image(img_ship, 0, -10, img_ship.width/2, img_ship.height/2);
    popMatrix();
  }
}
