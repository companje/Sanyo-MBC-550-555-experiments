float thrust = .1;
float idle_thrust = .05;
float friction = .95;
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Star> stars = new ArrayList();
//ArrayList<Enemy> enemies = new ArrayList();
float world_w=5000;
float world_h=5000;
PImage ship, img_enemy, bullet;
PImage star[] = new PImage[3];
PImage img_explosion;
int timeLastBullet;
float imgScale=.5;
import processing.sound.*;
SoundFile fire;
Player player = new Player();
PApplet app = this;

void setup() {
  smooth();
  size(800, 800);
  imageMode(CENTER);

  for (int i=0; i<10; i++) {
    stars.add(new Star(random(0, world_w), random(0, world_h)));
  }

  //player.set(); //world_w/2,world_h/2);


  ship = loadImage("ship.png");
  img_enemy = loadImage("enemy.png");
  bullet = loadImage("bullet.png");
  img_explosion = loadImage("explosion.png");
  fire = new SoundFile(this, "fire.mp3");

  for (int i=0; i<3; i++) star[i] = loadImage("star"+i+".png");

  //PVector enemypos = new PVector(random(-world_w/2, world_w/2), random(-world_h/2, world_h/2));
  //enemies.add(new Enemy(enemypos));
}

void update() {
  for (Particle p : stars) p.update();
  //for (Particle p : enemies) p.update();
  for (Particle p : bullets) p.update();
  player.update();

  //player.x = map(mouseX, 0, width, 0, world_w);
  //player.y = map(mouseY, 0, height, 0, world_h);

  //if (player.y<0) player.y+=world_h;


  //thrust = constrain(thrust+.05, 0, .6);


  while (bullets.size()>50) bullets.remove(0);
}

void draw() {
  update();
  background(0);
  frameRate(60);
  pushMatrix();
  //translate(width/2, height/2);


  scale(.2);
  //translate(width/2, height/2);

  noStroke();

  for (Particle p : stars) p.draw();
  //for (Particle p : enemies) p.draw();
  for (Particle p : bullets) p.draw();
  player.draw();
  noFill();
  stroke(255);
  rect(0, 0, width, height);
  popMatrix();

 
  app.textSize(20);
  app.text("frameRate="+int(frameRate)+"\nx="+int(player.x)+"\ny="+int(player.y)+"\ntop="+player.atTop+"\nbottom="+player.atBottom+"\nleft="+player.atLeft+"\nright="+player.atRight, 100, 100);
}

void keyPressed() {

  if (key == 'a' || key == 'A') {
    player.toAngle -= 0.3;
  }
  if (key == 'd' || key == 'D') {
    player.toAngle += 0.3;
  }
  if (key == 'w') {
    thrust = constrain(thrust+.05, 0, .6);
  }
  if (key == 's') {
    thrust = constrain(thrust-.05, 0, .3);
  }
  if (key == 'x') {
    if (millis()-timeLastBullet>32) {
      PVector gun = player.copy().add(PVector.fromAngle(player.angle).mult(100*imgScale));
      PVector gun_vel = PVector.fromAngle(player.angle).mult(20).limit(20);
      bullets.add(new Bullet(gun, gun_vel));
      fire.play();
    }
    timeLastBullet = millis();
  }

  if (key=='p') {
    noLoop();
  }
  if (key=='P') {
    loop();
  }
}

//void warp_world(Particle p) {
//  while (p.x>world_w/2) p.x -= world_w;
//  while (p.x<-world_w/2) p.x += world_w;
//  while (p.y>world_h/2) p.y -= world_h;
//  while (p.y<-world_w/2) p.y += world_h;
//}
