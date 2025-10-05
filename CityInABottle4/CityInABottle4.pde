//DEZE HEEFT BETERE RAMEN DAN CITY IN A BOTTLE 3

import java.util.HashSet;
final byte GROUND_PLANE    = 6;
final byte CITY_DISTANCE   = 34;
final byte AVENUE_WIDTH    = 27;
final byte AVENUE_PERIOD   = 99;
final byte BUILDING_WIDTH  = 9;
final byte BUILDING_DEPTH  = 8;
final byte BUILDING_HEIGHT = 45;
HashSet<Integer> u = new HashSet<Integer>();
PImage img, img2;
PGraphics pg;
int COLS=80;
int ROWS=50;
int TOPLEFT=8*COLS*4;
int mem[] = new int[1024*1024*2];
int prev_cells[] = new int[ROWS*COLS];
int cells[] = new int[ROWS*COLS];
int R=0xf0000, G=0x0C000, B=0xf4000;
int xx, yy;
int fontOffset = 0;
byte al, bl, cl, dl, ah, bh, ch, dh;
int ax, bx, cx, dx, si, di, es, ds;
int w=COLS;
int step=1;
int i=0;
int t0=116;
int t=t0; //start time
int m=2;
int bp=0; //frame counter
int n=COLS*ROWS;
int primes[] = get_primes();
byte SCALE=127;

int X, Y, Z; 
//int xs;
byte xs, ys, zs;
byte x, y, a, b, d, s, c;
int minX=999999, maxX=-999999;
int minY=999999, maxY=-999999;
boolean doRender = true;
boolean sf, zf;
int vv=0;
String patternFilename = "data/vertical-gradient-20x8.bin"; //met 60 kleuren is het wel veel mooier
//String patternFilename = "data/vertical-gradient-64x8.bin"; //met 60 kleuren is het wel veel mooier
int maxColor = 15;
int colorMultiplier = 3; //amount of right shifts 1 for 64 colors, 3 for 15 colors
int tp=0;
int dots = 0;

void setup() {
  size(640, 400);
  //fullScreen();
  frameRate(60);
  background(0);
  textFont(loadFont("Dialog-32.vlw"));
  fill(255);
  //smooth();
  noSmooth();
  noStroke();

  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  loadBin(patternFilename, fontOffset);
}

void draw() {
  es = G;
  di = 0;
  for (i=0; i<ROWS*COLS; i++) {
    draw_cell();
  }
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  //saveFrame("out/line-######.png");
  t++;
}

void draw_cell() {
  calc_xy_and_ray();

  s = b;
  d = SCALE;
  ah = 0; //for mul8
  ax = SCALE;
  //ax *= t;
  X = ax;
  Y = SCALE;
  Z = SCALE*4; //was  //Z <<= 2;

  raycast();

  ax = d;
  ah = 0; 
  ax*=zs; //mul8
  ax/=w;
  ax-=s;
  ax>>=3; 

  if (ax<0) ax=0;
  if (ax>16) ax=16;

  ax += dots;
  si = ax;
  movsw();
  movsw();
}

void raycast() {
  do {
    zs = (byte)(Z >> 7);
    if (zs>=w) return;
    xs = (byte)(X >> 7); //int
    ys = (byte)(Y >> 7); 

    hit();
    if (!sf) {
      ah = 0;
      al = d;
      c = al; //last d

      //tex
      al = xs; //add t?
      al += t;
      al &= ys;
      al &= zs;
      al &= 7; //vervang later door al %= 3;
      s = al;

      ax = s;
      ax <<= 7;
      ax /= zs;
      s = (byte)ax;

      //s = (byte) (s * SCALE / zs); // fog
      a = SCALE; // new dir to light
      b = SCALE; // new dir to light

      ax = Z;
      ax /= w;   // d = Z / w
      d = (byte)ax;
      if (c < SCALE) return;
    }

    X += a;
    Y -= b;
    Z += SCALE;
  } while (true);
}

//void hit2() {
//  //ax = ys;
//  //ax -= 6; //GROUND_PLANE + mouseY;
//  //sf = ax<0;

//  hit();
//}

//void hit3() { //int X, byte Y, byte Z) { //scaled
//  ax = xs;
//  ax += t;
//  cl = 9;
//  al = (byte)(ax/cl); //div8(ax, cl);
//  bl = zs;
//  cl = 3; 
//  bl >>= cl; // bl/=8
//  al ^= bl;
//  ax = al;
//  ax <<= cl; // ax*=8
//  cl = 45;
//  ax = (byte)(ax%cl); //mod8(ax, cl);

//  stack.push(ax); //modifier

//  //stack.push((ax == 0) ? 0 : 1) ; //condition3
//  //stack.push(1);

//  stack.push((zs <= 34) ? 0 : 1); //condition1

//  //ax = xs;
//  //ax += t;
//  //ax %= 99;
//  //stack.push((ax <= 27) ? 0 : 1); //condition2
//  //stack.push(1);

//  //ax = 1; //stack.pop();
//  //bx = 1; //stack.pop();
//  //ax &= bx;
//  ax = 1;
//  bx = stack.pop();
//  ax &= bx;
//  bx = stack.pop(); //combined modifier

//  if (ax==0) bx=0; //modifier in bx. if conditions not met then 0 (no hit yet)


//  ax = ys;
//  ax -= 6;
//  ax += bx;

//  sf = ax<0;
//}


void hit() { //int X, byte Y, byte Z) { //scaled
  ax = xs;
  ax += t;
  cl = BUILDING_WIDTH;
  al = div8(ax, cl);
  bl = zs;
  cl = BUILDING_DEPTH;
  bl/=cl; //fixme.. swap before div8
  al^=bl;

  ax = al;
  ax <<= 3; //*=8
  cl = BUILDING_HEIGHT;
  ax = mod8(ax, cl);

  stack.push(ax); //modifier

  stack.push((ax != 0) ? 1 : 0) ; //condition3 

  stack.push((zs > CITY_DISTANCE) ? 1 : 0); //condition1

  ax = xs;
  ax += t;
  ax %= AVENUE_PERIOD;

  stack.push((ax > AVENUE_WIDTH) ? 1 : 0); //condition2

  ax = stack.pop();
  bx = stack.pop();
  ax &= bx;
  bx = stack.pop();
  ax &= bx;

  bx = stack.pop(); //combined modifier

  if (ax==0) bx=0; //modifier in bx. if conditions not met then 0 (no hit yet)

  ax = ys;
  ax -= GROUND_PLANE;
  ax += bx;

  sf = ax<0;
}
