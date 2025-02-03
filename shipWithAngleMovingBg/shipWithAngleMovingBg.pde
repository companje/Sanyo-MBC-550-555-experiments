float toAngle = -HALF_PI, angle=toAngle;
float thrust = .1;
float idle_thrust = .05;
float friction = .95;
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Star> stars = new ArrayList();
ArrayList<Enemy> enemies = new ArrayList();
float world_w=5000;
float world_h=5000;
PImage ship, img_enemy, bullet;
PImage star[] = new PImage[3];
int timeLastBullet;
float imgScale=.5;
import processing.sound.*;
SoundFile fire;
Player player = new Player();


void setup() {
  smooth();
  size(800, 800);
  player.position = new PVector(width/2, height/2);
  player.velocity = new PVector();
  player.acceleration = new PVector();
  
  for (int i=0; i<250; i++) {
    stars.add(new Star(random(-width*2, width*2), random(-height*2, height*2)));
  }
  ship = loadImage("ship.png");
  img_enemy = loadImage("enemy.png");
  bullet = loadImage("bullet.png");
  for (int i=0; i<3; i++) star[i] = loadImage("star"+i+".png");
  //ship.resize(64,64);
  imageMode(CENTER);
  fire = new SoundFile(this, "fire.mp3");
  PVector enemypos = new PVector(random(-world_w/2, world_w/2), random(-world_h/2, world_h/2));
  enemies.add(new Enemy(enemypos));
}

void draw() {
  background(0);
  frameRate(60);
  translate(width/2, height/1.4);
  //scale(.3);
  //translate(ox,oy);
  noStroke();

  for (Enemy e: enemies) e.update();
  
  for (Enemy e: enemies) {
    for (Bullet b: bullets) {
      if (e.position.dist(b.position)<100) e.explode(); 
    }
  }
  
  
  angle = lerp(angle, toAngle, .2);
  player.velocity.add(player.acceleration);
  player.velocity.mult(friction);
  player.position.add(player.velocity);
  player.acceleration.mult(0);

  if (player.position.x>world_w/2) {
    player.position.x -= world_w;
    for (Star s : stars) s.x -= world_w;
    for (Enemy e : enemies) e.position.x -= world_w;
  }

  if (player.position.x<-world_w/2) {
    player.position.x += world_w;
    for (Star s : stars) s.x += world_w;
    for (Enemy e : enemies) e.position.x += world_w;
  }

  if (player.position.y>world_h/2) {
    player.position.y -= world_h;
    for (Star s : stars) s.y -= world_h;
    for (Enemy e : enemies) e.position.y -= world_h;
  }

  if (player.position.y<-world_w/2) {
    player.position.y += world_h;
    for (Star s : stars) s.y += world_h;
    for (Enemy e : enemies) e.position.y += world_h;
  }

  for (Enemy e: enemies) {
    e.seek(player.position);
  }

  pushMatrix();
  translate(-player.position.x, -player.position.y);

  //draw stars
  for (Star s : stars) {
    pushMatrix();
    translate(s.x, s.y);
    fill(s.c);
    //rect(0, 0, s.s, s.s);
    scale(imgScale);
    image(star[(int)map(s.s, 2, 6, 0, 3)], 0, 0);
    popMatrix();
  }
  
  //enemies
  for (Enemy e: enemies) e.draw();
  
  popMatrix();

  
  //draw bullets
  for (Bullet b : bullets) {
    pushMatrix();
    b.position.add(b.velocity);
    translate(b.position.x - player.position.x, b.position.y - player.position.y);
    fill(255);
    //ellipse(0, 0, 3, 3);
    float h = b.velocity.heading()+HALF_PI;
    rotate(h);
    scale(imgScale);
    image(bullet, 0, 0);
    popMatrix();
  }

  while (bullets.size()>50) bullets.remove(0);

  // Draw airplane
  pushMatrix();
  //translate(position.x, position.y);
  rotate(angle+HALF_PI);
  rectMode(CENTER);
  fill(255);
  //rect(0, 0, 40, 20);
  //rect(20, 0, 20, 1);
  scale(imgScale);
  image(ship, 0, 0);
  popMatrix();


  PVector force = PVector.fromAngle(angle).mult(thrust);
  //force.z = -.1;
  //PVector force = PVector.fromAngle(angle).mult(idle_thrust);
  player.acceleration.add(force);

  for (Star s : stars) {
    float mindist=500;
    float maxdist=1000;
    if (dist(s.x, s.y, player.position.x, player.position.y)>maxdist) {
      do {
        s.x = player.position.x+random(-width*2, width*2);
        s.y = player.position.y+random(-height*2, height*2);
        //s.z = position.z;
        //s.c = #ff0000;
      } while (dist(s.x, s.y, player.position.x, player.position.y)<mindist);
    }
  }
  
  
}

void keyPressed() {

  if (key == 'a' || key == 'A') {
    toAngle -= 0.3;
  }
  if (key == 'd' || key == 'D') {
    toAngle += 0.3;
  }
  if (key == 'w') {
    thrust = constrain(thrust+.05, 0, .6);
  }
  if (key == 's') {
    thrust = constrain(thrust-.05, 0, .3);
  }
  if (key == ' ') {
    if (millis()-timeLastBullet>32) {
      PVector gun = player.position.copy().add(PVector.fromAngle(angle).mult(100*imgScale));
      PVector gun_vel = PVector.fromAngle(angle).mult(20).limit(20);
      bullets.add(new Bullet(gun, gun_vel));
      fire.play();
    }
    timeLastBullet = millis();
  }
}
