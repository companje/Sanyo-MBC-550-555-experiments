class Enemy {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxspeed = 5;
  float maxforce = .03;
  boolean hit = false;
  int timeExplosionStarted;

  Enemy(PVector position) {
    this.position = position;
    this.velocity = new PVector();
    this.acceleration = new PVector();
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.setMag(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    //return steer;
    acceleration.add(steer);
  }

  void explode() {
    if (!hit) {
      hit = true;
      timeExplosionStarted = millis();
      println("BOOM!");
    }
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    seek(player.position);
    scale(imgScale);
    float h = velocity.heading()-HALF_PI;
    rotate(h);
    image(img_enemy, 0, 0);
    popMatrix();
  }
}
