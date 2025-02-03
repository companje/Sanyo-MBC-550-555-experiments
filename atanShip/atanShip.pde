import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int ax, bx, cx, dx, si, di; //chars are 16 bit unsigned in Java
PImage img_ship[] = new PImage[24];
PImage img_star[] = new PImage[3];

int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int CENTER=COLS*LINES/2+COLS*4/2;

int mem[] = new int[10000]; //16 bits
int j=0; //increased by 2 for each dw()
int POS = dw(0);
int VEL = dw(0);
int ACC = dw(0);
int FORCE = dw(0);
int FORCES = dw(0);
int TMP = dw(0);
int ANGLE = dw(0);
int SPRITE_INDEX = dw(0);
int STARS=j+=2; //offset

int NUM_STARS=50;


void setup() {
  size(640, 400, P2D);
  colorMode(HSB);
  rectMode(CENTER);
  for (int i=0; i<24; i++) img_ship[i] = loadImage("ship-"+(((i+6)%24)+1)+".png");
  for (int i=0; i<img_star.length; i++) img_star[i] = loadImage("star-"+i+".png");

  mem[POS+0] = 73728/2;
  mem[POS+1] = 51200/2;

  mem[FORCE+0] = 100;
  mem[FORCE+1] = 100;

  init_stars();
}

void init_stars() {
  cx = NUM_STARS*2;
  do {
    bx = cx;
    mem[STARS+bx] = (int)random(0, 0xffff);
  } while (cx-->0);
}

void draw() {
  background(0);

  copy(FORCE, FORCES);
  limit(FORCE, 25);
  sub(FORCES, FORCE);
  scale(FORCES, 90);
  add(ACC, FORCE);
  add(VEL, ACC);
  mult(ACC, 0);
  add(POS, VEL);
  scale(VEL, 98);

  ax = mem[VEL+0]; //vx
  bx = mem[VEL+1]; //vy
  atan2();
  mem[ANGLE] = ax;
  mem[SPRITE_INDEX] = mem[ANGLE]/15;

  println(mem[SPRITE_INDEX]);

  draw_stars();
  draw_ship();
}

void keyPressed() {
  int step=500;
  if (key=='w') addForceFromAngle(mem[ANGLE], 5);
  if (key=='a') addForceFromAngle(mem[ANGLE]-90, 5);
  if (key=='d') addForceFromAngle(mem[ANGLE]+90, 5);
  if (key=='s') {
    mult(FORCES, 0);
    mult(VEL, 64);
    div(VEL, 100);
  }
}

void addForceFromAngle(int angle, int mag) {
  ax = angle;
  bx = mag;
  fromAngle();
  mem[FORCES+0] += ax;
  mem[FORCES+1] += bx;
}

void draw_stars() {
  cx = NUM_STARS*2;
  do {
    bx = cx;
    ax = mem[STARS+bx+0] - mem[POS+0]; //x
    bx = mem[STARS+bx+1] - mem[POS+1]; //y
    world2screen();
    calc_di_from_bx();
    draw_img(img_star[2]);


    cx--; //extra
  } while (cx-->0);
}

void draw_ship() {
  //ax = mem[POS+0]; //x
  //bx = mem[POS+1]; //y
  //world2screen(); //result in bx   (x//10, y//10)
  //calc_di_from_bx();
  set_cursor(16, 35);
  draw_img(img_ship[mem[SPRITE_INDEX]]);
}
