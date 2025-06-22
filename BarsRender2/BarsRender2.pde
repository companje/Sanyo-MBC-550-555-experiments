// Dit werkt goed maar zelfs 1 kolom is op de Sanyo te traag
PImage img, img2;
int di, bp, ci, es;
PGraphics pg;
int COLS=64;
int W=COLS*4;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int step=10;
int offset=30;
int y = 0;
int x = 0;

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
}

void fx_bar() {
  al.mov(ci);
  al.add(ci);
  al.add(ci);
  al.add(bp);
  al.add(bp);
  al.add(offset);
  sine256();
  int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  al.set(0);
  if (y < barY) return;
  if (y > barY + 10) return;
  al.set(255);
}

void fx_multibar() {
  al.set(0);
  for (int bar = 1; bar <= 3; bar++) {
    offset = bar*bar*10;
    if (al.get()==0) fx_bar();
  }
}


void render() {
  di++;
  if ((di&3)==0) di+=W-4;

  if (di>50*W) {
    di-=50*W;

    if (ci==0) es=G;
    else if (ci==1) es=B;
    else if (ci==2) {
      es=R;
      ci=-1;
      bp++;
    }
    ci++;
  }

  y = (di >> 8) << 2 | di & 3;
  x = di&63;
  fx_multibar();

  for (int i=0; i<COLS*4; i+=4) mem[es + di + i] = al.get();
}

void draw() {
  for (int i=0; i<600; i++) render();
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}
