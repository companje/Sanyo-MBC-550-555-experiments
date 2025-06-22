//import java.util.ArrayDeque;
//ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
//byte slash[];
PImage img, img2;
//int si, di;
PGraphics pg;
int COLS=64;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int il; //interlace
int di;
int es;
int v;
int xx=1;
//int intensity12[] = { 0, 0, 0, 0, 34, 34, 136, 170, 85, 238, 187, 119, 221, 255, 255, 255 };

int intensity12[] = { -1, -1, -1, -1, 0x55, 0, 0, 0, 0, 0, 0, 0x55, -1, -1, -1, -1 } ;


int t;
int xoff, yoff;

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(500);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  es = R;
}

int calcColor(int y, int frame, int ch_index, int offset) {
  al.set(ch_index);
  al.add(ch_index);
  al.add(ch_index);
  al.add(frame);
  al.add(offset);
  sine256();
  int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  if (y < barY) return 0;
  if (y > barY + 10) return 0;
  return 255;
}

void drawLine(int di, int ch, int v) {
  for (int i = 0; i < COLS*4; i+=4) { //was i<COLS*4
    mem[channels[ch] + di + i] = v;
  }
}

void draw() {
  for (int i=0; i<1000; i++) fast_draw();
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void fast_draw() {
  di+=xx;

  if (di>=12800) {
    di-=12800;
    t++;
    t=t&8191; //4095; //1023;
  }

  if (t==0 || keyPressed) {
    nextEffect();
  }

  int y = (di>>8)<<2 | di&3;
  int x = (di >> 2) & 0x3F;

  x+=xoff;
  y+=yoff;

  //al.set(x);

  al.set(x<<1);
  sine256();
  int v = al.get();
  al.set(y>>1);
  sine256();

  al.add(v);
  al.add(t>>5);


  mem[es + di] = intensity12[al.get()>>4]; //(int)random(255);
}

void nextEffect() {
  xx%=255;
  xx++ ; // (int)random(255);
  //es ^= 0x4000;

  //if (es==B) es=G;
  //else es=B;

  xoff = xx;
  yoff = xx;


  //if (random(1)<.4) {
  for (int i=0; i<14400; i++) {
    mem[es + i] = 0;
  }
  //}


  if (es==R) es=G;
  else if (es==G) es=B;
  else es=R;
}
