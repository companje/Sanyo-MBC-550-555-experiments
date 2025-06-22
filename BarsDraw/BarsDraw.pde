PImage img, img2;
//int si, di;
PGraphics pg;
int COLS=72;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
}

void draw() {
  drawFrame(frameCount-1, true);
  drawFrame(frameCount, false);
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void drawFrame(int frame, boolean clear) {
  int NUM_BARS = 9;
  int BAR_HEIGHT = 5;
  int BAR_SPACING = 2;
  int NUM_RAINBOWS = 3;
  int RAINBOW_SPACING = 40;
  int SPEED = 2;

  for (int lz=0; lz<NUM_RAINBOWS; lz++) {
    for (int ly=0; ly<NUM_BARS; ly++) {

      al.mov(frame*SPEED + ly*BAR_SPACING + lz*RAINBOW_SPACING);
      sine256();
      al.set( (al.get() * 192) >> 8 ); //mul ah ; mov cl,8 ; shr cl

      for (int lx=0; lx<BAR_HEIGHT; lx++) {
        int ch = int(ly/3)%3;
        int y = int(lx+al.get());

        int di = (y>>2)*4*COLS+(y&3);

        int c = clear?0:255;
        for (int col=0; col<COLS; col++) {
          mem[channels[ch]+di] = c;
          di+=4;
        }
      }
    }
  }
}
