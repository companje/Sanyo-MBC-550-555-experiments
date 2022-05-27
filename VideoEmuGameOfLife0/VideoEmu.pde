int RED = 0xf0000;
int GREEN = 0xc0000;
int BLUE = 0xf4000;
int ROWS = 50;
int COLS = 72; //not 80
int R=4, G=2, B=1;
int mem[] = new int[1024*1024];
int c[] = new int[ROWS*COLS]; //cells
int clicked = -1;
int nb[] = {-1, 1, -COLS, COLS, -COLS-1, -COLS+1, COLS-1, COLS+1};

void setup() {
  size(576, 400);
  frameRate(100);
  init();
}

void init() {
  for (int i=0; i<c.length; i++) {
    c[i] = int(round(random(.6))*B);
  }
}

void mousePressed() {
  int x = int(float(mouseX)/width*COLS);
  int y = int(float(mouseY)/height*ROWS);
  int i = y*COLS+x;
  c[i] = ((c[i]&1)>0) ? 0 : 1;
}

void nextgen() {
    
  for (int i=0; i<c.length; i++) {
    int n = getActiveNeighbours(i).size();
    c[i] |= n==2 ? 2 : n==3 ? 4 : 0;
  }

  for (int i=0; i<c.length; i++) {
    c[i] = (c[i]&1)>0?(c[i]&2|c[i]&4)>0?1:0:(c[i]&4)>0?1:0;
  }
}


void draw() {
  nextgen();

  //spread color values to VRAM planes
  for (int i=0; i<c.length; i++) {
    for (int j=0; j<4; j++) {
      mem[i*4+j + RED] = (c[i] & R)>0 ? 255 : 0;
      mem[i*4+j + GREEN] = (c[i] & G)>0 ? 255 : 0;
      mem[i*4+j + BLUE] = (c[i] & B)>0 ? 255 : 0;
    }
  }

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
  if (key=='r') init();
  if (key==' ') nextgen();
  if (key=='p') frameRate(1);
  if (key=='P') frameRate(100);
}

ArrayList<Integer> getActiveNeighbours(int i) {
  ArrayList<Integer> result = new ArrayList();
  for (int b : nb) {
    int di = COLS * (((i+b) / COLS + ROWS) % ROWS) + ((i+b) + COLS) % COLS;
    if (0<(c[di]&1)) result.add(di);
  }
  return result;
}
