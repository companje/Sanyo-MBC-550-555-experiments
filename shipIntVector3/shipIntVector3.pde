import processing.sound.*;

int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines

Mem16 world_w = new Mem16(0);
Mem16 world_h = new Mem16(2);
Mem16 screen_w = new Mem16(4);
Mem16 screen_h = new Mem16(6);
Mem16 timeLastBullet = new Mem16(8);
Mem16 frameCounter = new Mem16(10);
Mem16 spriteIndex = new Mem16(12);
Mem16 toAngle = new Mem16(14);
Mem16 angle = new Mem16(16);
Mem16 thrust = new Mem16(18);
Mem16 tmp = new Mem16(20);
Mem16 tmp2 = new Mem16(22);

PImage img_enemy, img_bullet, img_explosion;
PImage img_ship[] = new PImage[24];
PImage img_star[] = new PImage[3];

SoundFile fire;
Player player = new Player();
Bullet bullets[] = new Bullet[10];
Star stars[] = new Star[200];
PApplet app = this;

void setup() {
  size(640, 400);
  imageMode(CENTER);

  world_w.set(2000);
  world_h.set(2000);
  screen_w.set(width);
  screen_h.set(height);
  
  toAngle.set(-90);
  toAngle.set(angle.get());
  thrust.set(100);
  

  for (int i=0; i<stars.length; i++) stars[i] = new Star();
  for (int i=0; i<bullets.length; i++) bullets[i] = new Bullet();
  //for (int i=0; i<3; i++) img_star[i] = loadImage("data/star"+i+".png");

  for (int i=0; i<24; i++) img_ship[i] = loadImage("ship-"+(((i+6)%24)+1)+".png");
  for (int i=0; i<img_star.length; i++) img_star[i] = loadImage("star-"+i+".png");

  //img_ship = loadImage("ship.png");
  img_enemy = loadImage("enemy.png");
  img_bullet = loadImage("bullet.png");
  img_explosion = loadImage("explosion.png");
  fire = new SoundFile(this, "fire.mp3");
}

void update() {
  frameCounter.inc();
  for (Star s : stars) s.update();
  for (Bullet b : bullets) b.update();
  player.update();
}

void draw() {
  update();
  background(0);
  frameRate(60);
  pushMatrix();
  noStroke();
  for (Star s : stars) s.draw();
  player.draw();
  for (Bullet b : bullets) b.draw();
  noFill();
  stroke(255);
  popMatrix();
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    toAngle.sub(15);
    thrust.add(20);
  } else if (key == 'd' || key == 'D') {
    toAngle.add(15);
    thrust.add(20);
  } else if (key == 'w') {
    thrust.add(50);
  } else if (key == 's') {
    thrust.mult(80);
    thrust.div(100);
  } else if (key == ' ') {
    if (frameCounter.get()-timeLastBullet.get()>5) {
      for (Bullet b : bullets) {
        if (!b.active) {
          b.fire();
          fire.play();
          timeLastBullet.set(frameCounter.get());
          break;
        }
      }
    }
  }
}

void warp(Vector p) {
  if (p.y-player.pos.y-world_h.get()+screen_h.get() > 0) p.y-=world_h.get();
  if (p.y-player.pos.y+screen_h.get() < 0) p.y+=world_h.get();
  if (p.x-player.pos.x-world_w.get()+screen_w.get() > 0) p.x-=world_w.get();
  if (p.x-player.pos.x+screen_w.get() < 0) p.x+=world_w.get();
}
