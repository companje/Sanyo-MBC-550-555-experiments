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
int ax, bx, cx, dx;
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
int xs;
byte ys, zs;
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

  if (!doRender) loadCells("data2/frame117.bin");
}

void copyCells(int[] from, int[] to) {
  for (int i=0; i<to.length; i++) {
    to[i] = from[i];
  }
}

int countChangedCells(int[] a, int[] b) {
  int c=0;
  for (int i=0; i<a.length; i++) {
    if (a[i] != b[i]) c++;
  }
  return c;
}

ArrayList<Integer> getChangedIndexes(int[] a, int[] b) {
  ArrayList<Integer> r = new ArrayList();
  for (int i=0; i<a.length; i++) {
    if (a[i] != b[i]) r.add(i);
  }
  return r;
}


void draw() {
  //scale(4);
  //setCellGreen(5, 5, mouseX*4);
  //setImageFromMemory(img);
  //image(img, 0, 0, width, height);
  //fill(255);
  //scale(1/4.);
  //text(minX, 1, 40);
  //text(maxX, 1, 70);
  //if (true) return;

  //for (int j=0; j<500; j++) {
  //  renderInt();
  //  i+=get_primes()[mouseX]; //prime
  //  if (i>=n) i-=n;

  //  tp++;
  //  if (tp>=n) {
  //    tp=0;
  //    t++;
  //    if (t>2000) t=0;
  //  }
  //}

  if (doRender) {
    copyCells(cells, prev_cells);
    renderInt();
    //println(countChangedCells(prev_cells,cells));
    saveCells("data2/frame"+(t+1)+".bin");
    saveChangeMask("masks/frame"+(t+1)+".bin");
  }



  cellsToMem();
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  //saveGreen("frame"+frameCount+".bin");

  //for (Integer i : getChangedIndexes(prev_cells, cells)) {
  //  float x = (i % w) / 80. * width; 
  //  float y = (i / w) / 50. * height;
  //  fill(255, 0, 0);
  //  rect(x, y, 3, 3);
  //}


  //fill(255);
  //scale(.8);
  //text(minX, 20, 50);
  //text(maxX, 20, 80);
  //text(u+"", 20, 130);

  //t++;
  if (t>2000) t=0;
}



void renderInt() {
  for (i=0; i<ROWS*COLS; i++) {
    draw_cell();
  }
}

void draw_cell() {
  x = (byte)(i % w); //i is 16 bit!
  y = (byte)(i / w);


  al = SCALE;
  cl = 40;
  al /= cl;
  al *= x;
  al -= SCALE;
  a = al;

  //if (true) continue;

  al = y;
  al <<= 2;
  cl = SCALE; //c = tmp
  cl -= al;
  b = cl;


  s = b;
  d = SCALE;
  ah = 0; //for mul8
  ax = SCALE;
  ax *= t;
  X = ax;
  Y = SCALE;
  Z = SCALE*4; //was  //Z <<= 2;

  //zs = SCALE;

  raycast();

  //minX=min(zs, minX);
  //maxX=max(zs, maxX);


  //zs = mouseX;
  //println(zs);

  ax = d;
  ah = 0; 
  ax*=zs; //mul8
  ax/=w;
  ax-=s;
  ax>>=3; 
  //ax++;

  if (ax<0) ax=0;
  if (ax>16) ax=16;

  u.add(ax);



  cells[y*COLS+x] = ax; //value of SI in font table
}


//DEZE HEEFT BETERE RAMEN DAN CITY IN A BOTTLE 3


void raycast() {
  do {
    zs = (byte)(Z >> 7);

    if (zs>=w) return;

    xs = (X >> 7); //int
    ys = (byte)(Y >> 7); 

    hit(); //xs, (byte)ys, (byte)zs);
    //sf = true;
    if (!sf) {
      ah = 0;
      al = d;
      c = al; //last d

      //tex
      al = (byte)xs;
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

void hit2() {
  sf = (zs&xs) < 0;
}

void hit() { //int X, byte Y, byte Z) { //scaled
  ax = xs;
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

  //if (ax>=0) return 1;
  //else return 0;
}

void mouseMoved() {
  t=mouseX;
}

void keyPressed() {
  if (keyCode==LEFT) vv-=4;
  if (keyCode==RIGHT) vv+=4;
  if (key=='r') doRender=!doRender;
}
