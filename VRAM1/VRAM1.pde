PImage img, img2;
PGraphics pg;
int COLS=80;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int mem[] = new int[1024*1024];
int R=0xf0000, G=0x0C000, B=0xf4000;

void setup() {
  size(640, 400);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height); //img.width, img.height); //fbo

  for (int i=0; i<500; i++) {
    mem[R+i] = 255;
  }
}

void draw() {
  //clearAll();

  pg.beginDraw();
  pg.clear();
  pg.fill(255, 0, 0);
  pg.rectMode(CENTER);
  pg.rect(mouseX+40, mouseY, 100, 100);
  pg.endDraw();
  img2 = pg.get();
  img2.resize(img.width, img.height);
  setMemoryFromImage(img2);

  pg.beginDraw();
  pg.clear();
  pg.fill(0, 0, 255);
  pg.rectMode(CENTER);
  pg.rect(mouseX-40, mouseY, 100, 100);
  pg.endDraw();
  img2 = pg.get();
  img2.resize(img.width, img.height);
  setMemoryFromImage(img2);

  pg.beginDraw();
  pg.clear();
  pg.fill(0, 255, 0);
  pg.rectMode(CENTER);
  pg.rect(mouseX, height-mouseY, 100, 100);
  pg.endDraw();
  img2 = pg.get();
  img2.resize(img.width, img.height);
  setMemoryFromImage(img2);

  
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  if (key=='c') clearAll();
}
