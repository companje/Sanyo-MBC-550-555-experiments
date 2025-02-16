//public class Enemy extends Particle {
//  float maxspeed = 5;
//  float maxforce = .03;
//  boolean hit = false;
//  int timeExplosionStarted;

//  Enemy(PVector position) {
//    this.set(position);
//    this.velocity = new PVector();
//    this.acceleration = new PVector();
//  }

//  void update() {
//    //velocity.add(acceleration);
//    //velocity.limit(maxspeed);
//    //this.add(velocity);
//    //acceleration.mult(0);

//    //println("enemy", position);
//    //if (position.x<0) position.x+=world_w;
//    //if (position.x>world_w) position.x-= world_w;
//    //if (position.y<0) position.y+=world_h;
//    //if (position.y>world_h) position.y-= world_h;

//    if (!hit) {
//      seek(player);
//      println("seek");
//    }

//    for (Enemy e : enemies) {
//      if (e.dist(this)<100) e.explode();
//    }

//    if (hit) { // && millis()-timeExplosionStarted<4000) {
//      int n = (millis()-timeExplosionStarted) / 1000;
//      for (int i=0; i<10; i++) image(img_explosion, random(-10, 10)*5, random(-10, 10)*5);
//    }
//  }

//  void draw() {
//    pushMatrix();
//    translate(x, y);
//    scale(imgScale);
//    float h = velocity.heading()-HALF_PI;
//    rotate(h);
//    image(img_enemy, 0, 0);
//    popMatrix();
//  }

//  void seek(PVector target) {
//    PVector desired = PVector.sub(target, this);
//    desired.setMag(maxspeed);
//    PVector steer = PVector.sub(desired, velocity);
//    steer.limit(maxforce);  // Limit to maximum steering force
//    //return steer;
//    acceleration.add(steer);
//  }

//  void explode() {
//    if (!hit) {
//      hit = true;
//      timeExplosionStarted = millis();
//      println("BOOM!");
//    }
//  }
//}
