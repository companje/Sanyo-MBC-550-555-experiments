PImage img, img2;
int si, di, bx, es;
PGraphics pg;
int COLS=72;
int W=COLS*4;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int colorTable[] = new int[256*4*4]; //256 colors, 4 line patterns per color, 3 color channels
int SPR = 0;

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);

  loadSprite("material16-dit2.spr",SPR);
}

void draw() {
 
  si = SPR;
  di = 0;
  drawSprite(); //draws sprite from SI to DI
  

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  //noLoop();
}


void keyPressed() {
  noLoop();
}
