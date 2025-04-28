import processing.sound.*;

int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int RED   = 0xf000;
int GREEN = 0x1c00;
int BLUE  = 0xf400;

Mem16 world_w = new Mem16();
Mem16 world_h = new Mem16();
Mem16 screen_w = new Mem16();
Mem16 screen_h = new Mem16();
Mem16 timeLastBullet = new Mem16();
Mem16 frameCounter = new Mem16();
Mem16 spriteIndex = new Mem16();
Mem16 toAngle = new Mem16();
Mem16 angle = new Mem16();
Mem16 thrust = new Mem16();
Mem16 tmp = new Mem16();
Mem16 tmp2 = new Mem16();
int img_up;

PImage img_enemy, img_bullet, img_explosion;
PImage img_ship[] = new PImage[24];
PImage img_star[] = new PImage[3];
PImage img;

//SoundFile fire;
Player player = new Player();
Bullet bullets[] = new Bullet[10];
Star stars[] = new Star[200];
PApplet app = this;

int NUM_STARS = stars.length;  //2 words per star

void setup() {
  size(640, 400);
  //imageMode(CENTER);

  img = createImage(COLS*8, 200, RGB); //72*8=576

  world_w.set(1000);
  world_h.set(1000);
  screen_w.set(width);
  screen_h.set(height);

  angle.set(-90);
  toAngle.set(-90);
  thrust.set(100);

  img_up = incbin("data/ship-1.spr");
  println(img_up);
  println(mem8(32));
  println(mem8(33));


  ds.mov(0);
  di.mov(0);
  si.mov(img_up);

  //for (int i=0; i<400; i++) {
  //  RED.set(i, img_up.get(i));
  //}

  for (int i=0; i<stars.length; i++) stars[i] = new Star();
  for (int i=0; i<bullets.length; i++) bullets[i] = new Bullet();
  for (int i=0; i<img_ship.length; i++) img_ship[i] = loadImage("ship-"+(((i+6)%24)+1)+".png");
  for (int i=0; i<img_star.length; i++) img_star[i] = loadImage("star-"+i+".png");

  img_enemy = loadImage("enemy.png");
  img_bullet = loadImage("bullet.png");
  img_explosion = loadImage("explosion.png");
  //fire = new SoundFile(this, "fire.mp3");
}

void update() {
  frameCounter.inc();
  for (Star s : stars) s.update();
  for (Bullet b : bullets) b.update();
  player.update();
}

void draw() {
  update();
  
  //background(0);
  //frameRate(60);
  //pushMatrix();
  //noStroke();
  //for (Star s : stars) s.draw();
  //player.draw();
  //for (Bullet b : bullets) b.draw();
  //noFill();
  //stroke(255);
  //popMatrix();

  //ax.mov(RED);
  //es.mov(ax);
  //di.mov(0);
  //ax.mov(-1);
  //for (int i=0; i<40; i++) {
  //  stosw();
  //}

  //ds.mov(0);
  player.draw();

  //ax.mov(GREEN);
  //es.mov(ax);
  //di.mov(0);
  //ax.mov(-1);
  //for (int i=0; i<100; i++) stosw();

  //BLUE.setWord(0,-1);
  //BLUE.setWord(2,-1);

  setImageFromMemory(img);
  image(img, 0, 0, width, height);

  //noLoop();
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    toAngle.sub(20);
    thrust.add(40);
  } else if (key == 'd' || key == 'D') {
    toAngle.add(20);
    thrust.add(40);
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
          //fire.play();
          timeLastBullet.set(frameCounter.get());
          break;
        }
      }
    }
  }
}

void warp(Vector p) {
  if (p.y.get()-player.pos.y.get()-world_h.get()+screen_h.get() > 0) p.y.sub(world_h.get());
  if (p.y.get()-player.pos.y.get()+screen_h.get() < 0) p.y.add(world_h.get());
  if (p.x.get()-player.pos.x.get()-world_w.get()+screen_w.get() > 0) p.x.sub(world_w.get());
  if (p.x.get()-player.pos.x.get()+screen_w.get() < 0) p.x.add(world_w.get());
}
