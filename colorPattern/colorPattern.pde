PImage img, img2;
PGraphics pg;
int di, x, y, xx=257, channel;
int COLS=64;
int NUM=COLS*200;
int[] stability = new int[NUM];
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int bit_patterns[] = {
  0, 0, 0, 0,
  136, 0, 34, 0,
  170, 0, 170, 0,
  170, 17, 170, 68,
  170, 85, 170, 85,
  85, 238, 85, 187,
  119, 255, 221, 255,
  255, 255, 255, 255
};
int channels[] = {R, G, B};

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(10);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
}

void draw() {

  //int bit_patterns[] = { 0, 0, 0, 0, 136, 0, 34, 0, 170, 0, 170, 0, 170, 17, 170, 68, 170, 85, 170, 85, 85, 238, 85, 187, 119, 255, 221, 255, 255, 255, 255, 255 };
  //int channels[] = {R, G, B};

  //for (int p=0; p<8; p++) {
  //  for (int i=0; i<4; i++) {
  //    for (int r=1; r<8; r++) { //r=row, start at 1 to skip black
  //      if (r==1||r==3||r==5||r==7) mem[R + r*COLS*4 + p*4+i] = bit_patterns[p*4+i];
  //      if (r==2||r==3||r==6||r==7) mem[G + r*COLS*4 + p*4+i] = bit_patterns[p*4+i];
  //      if (r==4||r==5||r==6||r==7) mem[B + r*COLS*4 + p*4+i] = bit_patterns[p*4+i];
  //    }
  //  }
  //}


  //int bit_patterns[] = { 0, 0, 0, 0, 136, 0, 34, 0, 170, 0, 170, 0, 170, 17, 170, 68, 170, 85, 170, 85, 85, 238, 85, 187, 119, 255, 221, 255, 255, 255, 255, 255 };
  //int p = 4;

  //for (int i=0; i<200; i++) {
  //  int pattern = bit_patterns[p*4+i%4];
  //  //int inv_pattern = ~pattern & 0xFF;


  //  int bgR = 0b11111111;
  //  int bgG = 0b11111111;
  //  int bgB = 0b11111111;


  //  int fgR = 0b11111111;
  //  int fgG = 0b11110111;
  //  int fgB = 0b11110111;



  //  mem[R + i] = bgR & fgR;
  //  mem[G + i] = bgG & fgG;
  //  mem[B + i] = bgB & fgB;
  //}




  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}
