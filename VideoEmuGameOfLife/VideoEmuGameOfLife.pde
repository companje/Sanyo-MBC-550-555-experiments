int RED = 0xf0000;
int GREEN = 0x0c000;
int BLUE = 0xf4000;
int ROWS = 11;
int COLS = 72; //not 80
int WH=ROWS*COLS;
int mem[] = new int[1024*1024];

void setup() {
  size(576, 400);
  noSmooth();
  frameRate(10);
  noLoop();
  init();
}

void setDot(int x, int y) {
  for (int j=0; j<4; j++)
    mem[BLUE + y*COLS*4+x*4 + j] = 255;
}

void init() {
  //for (int i=0; i<WH; i++) {
  //  int v = random(1)<.2 ? 255 : 0;
  //  for (int j=0; j<4; j++)
  //    mem[BLUE + i*4+j] = v;
  //}

  setDot(10, 5); //x,y
  setDot(11, 5); //x,y
  setDot(10, 4); //x,y
}

void nextgen() {

  //update cells for next gen - store info in highest bits of cell
  for (int i=0; i<WH; i++) {
    int n = countNeighboursUpTo3(i);
    int b = (n==2) ? 32 : (n==3) ? 64 : 0;
    mem[BLUE + i*4] ^= b; //xor: toggle bit 5 or 6 based on num neighbours
  }

  //redraw cells
  //for (int i=0; i<WH; i++) {
  //  int c = mem[BLUE + i*4];
  //  boolean nextState = c>=128 ? ((c&64)==0||(c&32)==0) : c>=64 ;  //alive ? n==2or3 : n==3

  //  for (int j=0; j<4; j++)
  //    mem[BLUE + i*4+j] = nextState ? 255 : 0;
  //}
}

int countNeighboursUpTo3(int p) {
  int nb[] = {-1, 1, -COLS, COLS, -COLS-1, -COLS+1, COLS-1, COLS+1};
  int n=0;
  for (int i=0; i<nb.length; i++)
    if (mem[BLUE + p*4 + nb[i]*4]>=128 && ++n>3) return n; //count to max 3 for bit7==1
  return n; //0,1 or 2
}

void draw() {
  nextgen();
  scale(3);
  image(getVRAM(), 0, 0, width, height);
}

PImage getVRAM() {
  PImage img = createImage(576, 200, RGB);
  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*img.width/2+(y%4)+int(x/8)*4;
      int r = (mem[RED+i] & bit)>0 ? 255 : 0;
      int g = (mem[GREEN+i] & bit)>0 ? 255 : 0;
      int b = (mem[BLUE+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
  return img;
}

void keyPressed() {
  if (key==' ') redraw();
  if (key=='p') noLoop();
  if (key=='P') loop();
}
