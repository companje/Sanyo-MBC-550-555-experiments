public class Player {
  Vector vel = new Vector();
  Vector pos = new Vector();
  int toAngle = -90;
  int angle = toAngle;
  int thrust = 100;

  void update() {
    angle = angle + (toAngle - angle) * 20 / 100;

    int m = thrust/10;
    if (m<10) m=10;
    if (m>50) m=50;

    vel.set(Vector.fromAngle(angle));
    vel.mult(m);
    vel.div(30);
    pos.add(vel);

    thrust *= 99;
    thrust /= 100;
    if (thrust<1) thrust=1;
    if (thrust>1000) thrust=1000;

    if (pos.x<0) pos.x+=world_w;
    if (pos.y<0) pos.y+=world_h;
    if (pos.x>world_w) pos.x-=world_w;
    if (pos.y>world_h) pos.y-=world_h;
  }

  void draw() {
    pushMatrix();
    fill(255);
    translate(width/2, height/2);
    rotate(radians(angle+90));
    image(img_ship, 0, 0, img_ship.width/2, img_ship.height/2);
    popMatrix();
  }
}
