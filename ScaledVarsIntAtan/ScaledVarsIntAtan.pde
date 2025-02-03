int SCALER = 10;
Vec position = new Vec();
Vec velocity = new Vec();
Vec acceleration = new Vec();
Vec forces = new Vec();
int angle;
PImage imgShip[] = new PImage[23];
PImage imgStar[] = new PImage[3];
Vec stars[] = new Vec[250];
int world_w=5000;
int world_h=5000;

void setup() {
  size(800, 600);
  for (int i=0; i<imgShip.length; i++) imgShip[i] = loadImage("ship-"+i+".png");
  for (int i=0; i<imgStar.length; i++) imgStar[i] = loadImage("star-"+i+".png");
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Vec(SCALER*(int)random(-width, width), SCALER*(int)random(-height, height));
    stars[i].s = i % imgStar.length;
    stars[i].c = color(255);
  }
}

void updatePlayer() {
  Vec force = forces.copy();
  force.limit(5);
  forces.sub(force);
  forces.scale(90); // 90%
  acceleration.add(force);
  velocity.add(acceleration);
  if (velocity.magSq() != 0) angle = myAtan2(velocity.y, velocity.x);
  acceleration.mult(0);
  position.add(velocity);
  velocity.scale(98); // 98%
  //println(position);
  
  //TODO: rekening houden met position in 16bit bereik. testen met shorts ipv ints?
}

void updateStars() {
  for (Vec s : stars) {
    float mindist=500 * SCALER;
    float maxdist=1000 * SCALER;
    if (dist(s.x, s.y, position.x, position.y)>maxdist) {
      do {
        //TODO: de loop zou hier weg kunnen door fromAngle te gebruiken denk ik
        //dan een random magnitude tussen minimale en maximale waarde
        //en dan kun je ook de sterren in ongeveer de vliegrichting plaatsen
        //met een min en max angle. Stuk eleganter allemaal.
        s.x = position.x + SCALER*(int)random(-width, width);
        s.y = position.y + SCALER*(int)random(-height, height);
      } while (dist(s.x, s.y, position.x, position.y)<mindist);
    }
  }
}

void draw() {
  updatePlayer();
  updateStars();
  background(0);
  translate(width/2, height/2);

  //draw stars
  for (Vec s : stars) {
    pushMatrix();
    translate(-position.x / SCALER, -position.y / SCALER); // Terugschalen naar pixels
    translate(s.x / SCALER, s.y / SCALER);
    scale(2);
    image(imgStar[s.s], 0, 0);
    popMatrix();
  }
  tint(255);

  //draw player
  pushMatrix();
  int frame = (angle/15 + imgShip.length + 6) % imgShip.length;
  image(imgShip[frame], -32, -32, 64, 64);
  //rotate(radians(angle+90));
  //triangle(0, -10, 10, 10, -10, 10);
  popMatrix();
}

void keyPressed() {
  if (key == 'w') forces.add(Vec.fromAngle(angle, 5));
  if (key == 'a') forces.add(Vec.fromAngle(angle - 90, 5));
  if (key == 'd') forces.add(Vec.fromAngle(angle + 90, 5));
  if (key == 's') {
    forces.mult(0);
    velocity.scale(64);
  }
}
