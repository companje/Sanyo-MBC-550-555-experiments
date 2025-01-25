import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int ax, bx, cx;
PImage img[] = new PImage[24];
int angle;

int mem[] = new int[1000]; //16 bits
int POS=0;
int VEL=2;
int ACC=4;
int FORCE=6;
int FORCES=8;
int TMP=10;

void setup() {
  size(640, 400);
  colorMode(HSB);
  rectMode(CENTER);
  for (int i=0; i<24; i++) {
    img[i] = loadImage("ship-"+(((i+6)%24)+1)+".png");
  }

  mem[POS+0] = 73728/2;
  mem[POS+1] = 51200/2;
}

void draw() {
  background(0);

  copy(FORCE, FORCES);
  limit(FORCE, 25);
  sub(FORCES, FORCE);
  mult(FORCES, 90);
  div(FORCES, 100);
  add(ACC, FORCE);
  add(VEL, ACC);
  mult(ACC, 0);
  add(POS, VEL);
  mult(VEL, 98);
  div(VEL, 100);
  println(mem[X], mem[Y]);

  ax = mem[VEL+0]; //vx
  bx = mem[VEL+1]; //vy
  atan2();
  angle = ax;

  int sprite_index = angle/15;
  int wx = int(mem[X]/1024)*8;
  int wy = int(mem[Y]/1024)*8;
  image(img[sprite_index], wx, wy, 64, 64);
}

void keyPressed() {
  int step=500;
  if (key=='w') addForceFromAngle(angle, 5);
  if (key=='a') addForceFromAngle(angle-90, 5);
  if (key=='d') addForceFromAngle(angle+90, 5);
  if (key=='s') {
    mult(FORCES, 0);
    mult(VEL, 64);
    div(VEL, 100);
  }
}

void addForceFromAngle(int angle, int mag) {
  fromAngle(TMP, angle, mag);
  mem[FORCES+0] += mem[TMP+0]; //add force to accumulator
  mem[FORCES+1] += mem[TMP+1];
}
