//import java.util.ArrayDeque;
//ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
//byte slash[];
PImage img, img2;
//int si, di;
PGraphics pg;
int COLS=64;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int il; //interlace
int di;
int xx=1;
int intensity12[] = { 0,34,34,136,170,85, 238, 187, 119, 221,255,255 };

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(50);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
}

int calcColor(int y, int frame, int ch_index, int offset) {
  al.set(ch_index);
  al.add(ch_index);
  al.add(ch_index);
  al.add(frame);
  al.add(offset);
  sine256();
  int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  if (y < barY) return 0;
  if (y > barY + 10) return 0;
  return 255;
}

void drawLine(int di, int ch, int v) {
  for (int i = 0; i < COLS*4; i+=4) { //was i<COLS*4
    mem[channels[ch] + di + i] = v;
  }
}

void draw() {
  //il++;
  //il%=4;

for (int ci=0; ci<3; ci++) {
  for (int i=0; i<10000; i++) {
    di+=257;
    di%=12800;

    int lowBits = di & 3;
    int highBits = di / 256;
    int y = (highBits << 2) | lowBits;

    int v = calcColor(y, frameCount*2, ci, 0);

   //int al = (y + frameCount) >> 4;
   //al = intensity12[al%12];
 
    mem[channels[ci] + di] = v;

    //drawLine(di, 0, frameCount);
  }
}
  //for (int y=199; y>=0; y-=4) {
  //  for (int ci=2; ci>=0; ci--) {
  //    int di = (y >> 2) * 288 + (y & 3);
  //    int v = calcColor(y, frameCount * 2, ci, 0);

  //  }
  //}
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  //noLoop();
  xx++;
}
