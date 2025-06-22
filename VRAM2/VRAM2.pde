PImage img, img2;
PGraphics pg;
int COLS=80;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int mem[] = new int[1024*1024];
int R=0xf0000, G=0x0C000, B=0xf4000;
int w=640,h=400,hd2=h/2,wd2=w/2;
int rgb[] = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255) };

void setup() {
  size(640, 400);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height); //img.width, img.height); //fbo
}

void draw() {
  clearAll();

  for (int i=0; i<12; i++) {
    pg.beginDraw();
    pg.clear();
    pg.fill(0, 255, 0);
    pg.rectMode(CORNER);
    pg.fill(rgb[2-(i%3)]);
    float x = sin(i*.1)*400;
    pg.rect(x, sin(frameCount*.125+i*.05)*hd2/2+hd2, w-2*x, 10);
    pg.endDraw();
    img2 = pg.get();
    img2.resize(img.width, img.height);
    setMemoryFromImage(img2);
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  if (key=='c') clearAll();
}
