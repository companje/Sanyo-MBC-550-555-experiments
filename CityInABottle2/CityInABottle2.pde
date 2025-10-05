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
//int prev_cells[] = new int[ROWS*COLS];
//int cells[] = new int[ROWS*COLS];
int R=0xf0000, G=0x0C000, B=0xf4000;
int xx, yy;
int fontOffset = 0;
byte al, bl, cl, dl, ah, bh, ch, dh;
int ax, bx, cx, dx, si, di;
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
byte xs, ys, zs;
byte x, y, a, b, d, s, prev_d;
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
int NUM=ROWS*COLS;

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

  //if (!doRender) loadCells("data2/frame117.bin");
}

void draw() {
  di = 0;
  for (int i=0; i<NUM; i++) { //i is not used as index
    draw_cell();
  }

  //for (di=NUM0; di<ROWS*COLS; di++) {
  //  draw_cell();
  //}
  setImageFromMemory(img);
  image(img, 0, 0, width, height);

  text(minX, 0, 40);
  text(maxX, 0, 80);
}

void draw_cell() {
  ax = di;
  ax >>= 1;
  ax >>= 1;
  x = (byte)(di % w);
  y = (byte)(di / w); 

  calc_ray_direction(); // into a,b

  s = b;         // use y_dir as background color
  ax = SCALE;
  X = ax;
  Y = ax;
  Z = ax;
  d = SCALE;  // max light

  raycast();

  ax = d;
  ax *= zs; //mul8
  ax /= w;
  ax -= s;
  ax >>= 3; //scale color /=8

  if (ax<0) ax=0;
  if (ax>16) ax=16;

  //cells[y*COLS+x] = ax; //value of SI in font table
}

void raycast() {
  do {
    zs = (byte)(Z >> 7);
    if (zs>=w) return; //geen enkele hit tot horizon
    xs = (byte)(X >> 7);
    ys = (byte)(Y >> 7);

    if (!hit()) {
      a = SCALE; // new dir to light
      b = SCALE; // new dir to light

      //texture
      al = (byte)t;
      al += xs;
      al &= ys;
      al &= zs;
      al &= 7;      //vervang evt door al %= 3;
      s = al;       //geen fog meer

      //light = Z/w
      ax = Z;
      ax /= w;      
      prev_d = d;
      d = (byte)ax;  

      if (prev_d < SCALE) break;
    }

    X += a;
    Y -= b;
    Z += SCALE;
  } while (true);
}


void calc_ray_direction() {
  al = SCALE;
  cl = 40;
  al /= cl;
  al *= x;
  al -= SCALE;
  a = al;

  al = y;
  al <<= 2;
  cl = SCALE; //cl = tmp
  cl -= al;
  b = cl;
}

boolean hit2() {
  return xs*xs+ys*ys<80;
  //zs%50>30 && (ys+110)%50<20 && (xs+t)%50<20;
}

boolean hit() {
  //sf = true;
  //if (true) return;

  ax = xs ;
  ax += t;
  cl = BUILDING_WIDTH;
  al = div8(ax, cl);
  bl = zs;
  cl = BUILDING_DEPTH;
  bl /= cl; //fixme.. swap before div8
  al ^= bl;

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

  return ax<0;
}

void mouseMoved() {
  t=mouseX;
}

void keyPressed() {
  if (keyCode==LEFT) vv-=4;
  if (keyCode==RIGHT) vv+=4;
  if (key=='r') doRender=!doRender;
}
