public class Bullet extends Particle {

  Bullet(PVector position, PVector velocity) {
    this.set(position);
    this.velocity = velocity;
  }

  void update() {
    this.add(velocity);

    //warp_world(this);
  }

  void draw() {
    float h = velocity.heading()+HALF_PI;
    app.pushMatrix();
    app.translate(x - player.x, y - player.y);
    app.fill(255);
    app.rotate(h);
    app.scale(imgScale);
    app.image(bullet, 0, 0);
    app.popMatrix();
  }
}
