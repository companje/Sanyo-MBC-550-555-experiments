//import java.util.ArrayDeque;
//ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
//byte slash[];
PImage img, img2;
//int si, di;
PGraphics pg;
int COLS=64;
int W=COLS*4;
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
  int x=35;
  int w=2;
  for (int i = x*4; i < x*4+w*4; i+=4) { //was i<COLS*4
    mem[channels[ch] + di + i] = v;
  }
}

void draw() {

  //for (int y=199; y>=0; y--) {
  int di0 = 35*4;
  for (int di=di0; di<di0+49*W; di+=W) {
    for (int ci=2; ci>=0; ci--) {
      //int di = (y >> 2) * 288 + (y & 3);
      int lowBits = di & 3;
      int highBits = di / 256;
      int y = (highBits << 2) | lowBits;

      int v = 0;
      for (int bar = 0; bar < 3; bar++) {
        int c = calcColor(y, frameCount * 2, ci, bar * 10);
        if (c > v) v = c;
      }
      //drawLine(di, ci, v);
      //for (int i=0; i<8; i+=4) {
      mem[channels[ci] + di ] = v;
      mem[channels[ci] + di ] = v;
      //}
    }
  }
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  noLoop();
}
