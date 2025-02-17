import processing.sound.*;

float world_w=2000;
float world_h=2000;
PImage img_ship, img_enemy, img_bullet, img_explosion;
PImage img_star[] = new PImage[3];
int timeLastBullet;
SoundFile fire;
Player player = new Player();
Bullet bullets[] = new Bullet[10];
Star stars[] = new Star[200];
PApplet app = this;

void setup() {
  smooth();
  size(800, 800);
  imageMode(CENTER);

  for (int i=0; i<stars.length; i++) stars[i] = new Star();
  for (int i=0; i<bullets.length; i++) bullets[i] = new Bullet();
  for (int i=0; i<3; i++) img_star[i] = loadImage("star"+i+".png");
  img_ship = loadImage("ship.png");
  img_enemy = loadImage("enemy.png");
  img_bullet = loadImage("bullet.png");
  img_explosion = loadImage("explosion.png");
  fire = new SoundFile(this, "fire.mp3");
}

void update() {
  for (Particle p : stars) p.update();
  for (Particle p : bullets) p.update();
  player.update();
}

void draw() {
  update();
  background(0);
  frameRate(60);
  pushMatrix();
  //translate(width/2, height/2);
  //scale(.5);
  //translate(-width/2, -height/2);
  noStroke();
  for (Particle p : stars) p.draw();
  player.draw();
  for (Particle p : bullets) p.draw();
  noFill();
  stroke(255);
  //rect(0, 0, width, height);
  popMatrix();
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    player.toAngle -= 20;
    player.thrust += 20;
  } else if (key == 'd' || key == 'D') {
    player.toAngle += 20;
    player.thrust += 20;
  } else if (key == 'w') {
    player.thrust += 50;
  } else if (key == 's') {
    player.thrust *= .8; 
  } else if (key == ' ') {
    if (millis()-timeLastBullet>100) {
      for (Bullet b : bullets) {
        if (!b.active) {
          b.fire();
          fire.play();
          timeLastBullet = millis();
          break;
        }
      }
    }
  }
}

void warp(Particle p) {
  if (p.y-player.y-world_h+height > 0) p.y-=world_h;
  if (p.y-player.y+height < 0) p.y+=world_h;
  if (p.x-player.x-world_w+width > 0) p.x-=world_w;
  if (p.x-player.x+width < 0) p.x+=world_w;
}
