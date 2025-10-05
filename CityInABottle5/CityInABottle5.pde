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
int t0=0;
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
  //size(800, 600);
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
    draw_cell(i);
  }
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  //saveFrame("out/line-######.png");
  //t=360;
  //t=mouseX;
  t=frameCount%400 + 100;
  //t++;
  //if (t>100) t=0;
  //println(mouseX);
  println(frameCount, countChangedCells(cells,prev_cells));
}

void draw_cell(int i) {
  calc_xy_and_ray();

  s = b;
  ah = 0; //for mul8
  ax = SCALE;
  d = (byte)ax; //byte
  X = ax;
  Y = ax; //SCALE;
  Z = ax; //SCALE*4; //was  //Z <<= 2;

  raycast();

  ax = d;
  ah = 0; 
  ax*=zs; //mul8
  ax/=w;
  ax-=s;
  ax>>=3; 

  if (ax<0) ax=0;
  if (ax>16) ax=16;
  //ax&=15;


  prev_cells[i] = cells[i];
  cells[i] = ax;

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
      al %= 3;
      s = al;

      ax = s;
      ax <<= 7;
      ax /= zs;
      s = (byte)ax;

      a = SCALE; // new dir to light / ground shadows
      b = SCALE;
      
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



void hit() {
  ax = 0;

  if (zs > CITY_DISTANCE) { //34
    ax = xs;
    ax += t;
    cl = BUILDING_WIDTH; //9
    al = div8(ax, cl);
    bl = zs;
    //cl--; //now 8    //cl = BUILDING_DEPTH; //8
    bl>>=3;
    al^=bl;
    ax = al;

    if (ax!=0) {
      ax <<= 3; //*=8
      ax *= cl;
      cl = BUILDING_HEIGHT; //45
      ax = mod8(ax, cl);
    }

    if (ax!=0) {
      bx = ax;
      ax = xs;
      ax += t;
      cl = AVENUE_PERIOD; //99 
      ax %= cl; 
      ax -= AVENUE_WIDTH; //27
      if (ax>0) ax=bx;
    }
  }

  //gnd
  ax += ys;
  ax -= GROUND_PLANE;
  sf = ax<0;
}
