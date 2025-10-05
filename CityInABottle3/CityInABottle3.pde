import java.util.HashSet;
int minX=999999, maxX=-999999;
int minY=999999, maxY=-999999;
PImage img, img2;
PGraphics pg;
int COLS=80;
int ROWS=50;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
byte al, bl, cl, dl, ah, bh, ch, dh;
int ax, bx, cx, dx, si, di, es, ds;
byte w=(byte)COLS;
byte SCALE=127;
int X, Y, Z, t;
byte xs, ys, zs;
byte x, y, a, b, d, s, prev_d;
String patternFilename = "data/vertical-gradient-20x8.bin"; //met 60 kleuren is het wel veel mooier
int NUM = ROWS*COLS;
int dots = 0;
int vv = 0;

void setup() {
  size(640, 400);
  //size(800, 600);
  frameRate(60);
  background(0);
  textFont(loadFont("Dialog-18.vlw"));
  fill(255);
  noSmooth();
  noStroke();
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  loadBin(patternFilename, dots);
  es = G;
}

void draw() {
  di = 0;
  for (int i=0; i<NUM; i++) draw_cell(); //i is not used as index
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  text(minX+"..."+maxX, 10, 40);
  t=mouseX;
}

void draw_cell() {
  calc_xy_and_ray();

  s = b;       // use y_dir as background color
  ax = SCALE;
  X = ax;
  Y = ax;
  Z = ax;

  raycast();

  minX=min(s, minX);
  maxX=max(s, maxX);
  
  ax = d;
  ax *= zs; //mul8
  ax /= COLS;
  ax -= s;
  ax >>= 3; //scale color /=8

  //ax &= 15; //tmp
  if (ax<0) ax=1;
  if (ax>16) ax=16;

  ax += dots;
  si = ax;
  movsw();
  movsw();
}

void raycast() {
  d = SCALE;  // max light

  do {
    cl = 7;
    zs = (byte)(Z >> cl); //0..79
    if (zs>=COLS) break; // ???
    xs = (byte)(X >> cl); //-78..78
    ys = (byte)(Y >> cl); //-78..6

    if (!hit2()) {
      prev_d = d;
      d = zs; //light was Z/w, now Z/SCALE  

      if (d < SCALE) {
        //new dir
        a = SCALE;   //h-dir -127..127
        b = SCALE;   //v-dir -69..127

        //texture
        al = (byte)t;
        al += xs;
        al &= ys;
        al &= zs;
        al >>= 2;
        al &= 15;      //vervang evt door al %= 3;
        s = al;        //geen fog meer
      }

      if (prev_d < SCALE) break;
    }
    X += a;
    Y -= b;
    Z += SCALE;
  } while (true);
}

boolean hit2() { //xs=-78..78, ys=-78..6, zs=0..7
  //return hit();
  return ! (((xs+t)%5>-3 && (xs+t)%5<3) &&
    ((ys)%5>-2 && (ys)%5<2) && 
    (zs>10 && zs<15));
}

boolean hit() {
  //sf = true;
  //if (true) return;
  //final byte GROUND_PLANE    = 6;
  //final byte CITY_DISTANCE   = 34;
  //final byte AVENUE_WIDTH    = 27;
  //final byte AVENUE_PERIOD   = 99;
  //final byte BUILDING_WIDTH  = 9; //8 lukt niet
  //final byte BUILDING_DEPTH  = 8;
  //final byte BUILDING_HEIGHT = 45;


  ax = xs ;
  ax += t;
  cl = 9; //BUILDING_WIDTH;
  al = (byte)(ax/cl);

  bl = zs;
  //cl = BUILDING_DEPTH;
  bl >>= 3; //fixme.. swap before div8
  al ^= bl;

  ax = al;
  ax <<= 3; //*=8
  cl = 45; // BUILDING_HEIGHT;
  ax = ax%cl;

  stack.push(ax); //modifier
  stack.push((ax == 0) ? 0 : 1) ; //condition3 
  stack.push((zs <= 34 /*CITY_DISTANCE*/) ? 0 : 1); //condition1

  ax = xs;
  ax += t;
  ax %= 99; //AVENUE_PERIOD; was 99

  ax = (ax <= 27) ? 0 : 1; //condition2 AVENUE_WIDTH
  bx = stack.pop();
  ax &= bx;
  bx = stack.pop();
  ax &= bx;

  bx = stack.pop(); //combined modifier
  if (ax==0) bx=0; //modifier in bx. if conditions not met then 0 (no hit yet)

  ax = ys;
  ax -= 6; //GROUND_PLANE;
  ax += bx;

  return ax<0;
}

void mouseDragged() {
  t=mouseX;
}

void keyPressed() {
  if (key=='[') vv--;
  if (key==']') vv++;
}
