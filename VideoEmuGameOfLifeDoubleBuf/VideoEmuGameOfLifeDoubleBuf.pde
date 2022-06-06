int DS = 0x0c000;
int ES = 0x1c000;
int ROWS = 50;
int COLS = 72;
int mem[] = new int[1024*1024];
PImage img = createImage(576, 200, RGB);

void setup() {
  size(576, 400);
  frameRate(50);
  init();
}

void init() {
  int shape[] = {10, 0, 11, 0, 12, 0, 10, 1, 11, 2};
  for (int i=0; i<shape.length; i+=2)
    setDot(shape[i], shape[i+1], true);
}

void setDot(int x, int y, boolean c) {
  x+=COLS % COLS;
  y+=ROWS % ROWS;
  setDot(y*COLS+x, c);
}

void setDot(int i, boolean c) {
  for (int j=0; j<4; j++)
    mem[ES + i*4 + j] = c ? 255 : 0;
}

boolean getDot(int x, int y) {
  x+=COLS % COLS;
  y+=ROWS % ROWS;
  return mem[DS + (y*COLS+x)*4]!=0;
}

int countNeighbours(int x, int y) {
  int n=0;
  int nb[][] = { {-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1} };
  for (int[] b : nb) {
    int xx = (x+b[0]+COLS) % COLS;
    int yy = (y+b[1]+ROWS) % ROWS;
    if (getDot(xx, yy)) n++;
  }
  return n;
}

void clr() {
  for (int y=0; y<ROWS; y++)
    for (int x=0; x<COLS; x++)
      setDot(x, y, false);
}

void rnd() {
  for (int y=0; y<ROWS; y++)
    for (int x=0; x<COLS; x++)
      setDot(x, y, random(1)<.2);
}

void nextgen() {
  //swap
  int tmp=DS;
  DS=ES;
  ES=tmp;

  for (int y=0; y<ROWS; y++) {
    for (int x=0; x<COLS; x++) {
      boolean alive = getDot(x, y);
      int n = countNeighbours(x, y);
      setDot(x, y, (!alive && n==3) || (alive && (n==2||n==3)) );
    }
  }
}

void draw() {
  nextgen();
  image(getVRAM(), 0, 0, width, height);
}

PImage getVRAM() {
  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*img.width/2+(y%4)+int(x/8)*4;
      img.pixels[j] = color(0, (mem[ES+i] & bit)>0 ? 255 : 0, 0);
    }
  }
  img.updatePixels();
  return img;
}

void keyPressed() {
  if (key=='i') init();
  if (key=='r') rnd();
  if (key==' ') nextgen();
  if (key=='c') clr();
  redraw();
}
