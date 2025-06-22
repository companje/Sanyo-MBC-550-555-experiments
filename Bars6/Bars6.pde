PImage img, img2;
PGraphics pg;
int COLS=64;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int S=0xf8000;
int channels[] = {R, G, B};
int il; //interlace
int di;
int es;
int bp;
int v;
int xx=3; //257;
int intensity12[] = { -1, -1, -1, -1, 0x55, 0, 0, 0, 0, 0, 0, 0x55, -1, -1, -1, -1 } ;
int t=0;
int offset;
int x, y;
int channel=0;
int NUM=COLS*200;

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(10);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
}

void draw() {
  for (int i=0; i<3000; i++) {
    di = (di+xx) % NUM;
    y = ((di>>8)<<2) | di&3;
    x = (di >> 2) & COLS;

    for (int cc=0; cc<3; cc++) { //color channel index
      channel = cc;
      effect();
      mem[channels[cc] + di] = al.get();
    }
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void effect() {
  al.set(channel);
  al.add(channel);
  al.add(channel);
  al.add(frameCount);
  sine256();
  int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  if (y < barY) al.set(0);
  else if (y > barY + 10) al.set(0);
  else al.set(255);
}
