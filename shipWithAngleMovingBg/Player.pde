public class Player extends Particle {
  float toAngle = -HALF_PI;
  float angle=toAngle;
  boolean atTop, atBottom, atLeft, atRight;

  Player() {
    velocity = new PVector();
    acceleration = new PVector();
  }

  void update() {
    angle = app.lerp(angle, toAngle, .2);

    player.velocity.add(player.acceleration);
    player.velocity.mult(friction);
    player.add(player.velocity);
    player.acceleration.mult(0);

    PVector force = PVector.fromAngle(angle).mult(thrust);
    acceleration.add(force);

    if (x<0) x+=world_w;
    if (y<0) y+=world_h;
    if (x>world_w) x-=world_w;
    if (y>world_h) y-=world_h;
  }

  void draw() {
    app.pushMatrix();
    app.fill(255);
    app.translate(width/2, height/2);
    app.scale(.5);
    app.rotate(angle+HALF_PI);
    app.image(ship, 0, -20);
    app.popMatrix();
  }
}
