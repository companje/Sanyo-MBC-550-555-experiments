//import java.util.ArrayDeque;
//ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
//byte slash[];
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
  //for (int i = 800; i>=0; i--) {
  //  int y = i >> 2; //now fits in AL
  //  int ch = i & 3;

  //  if (ch >= 3) continue;
  for (int y=199; y>=0; y--) {
    for (int ci=2; ci>=0; ci--) {
      int di = (y >> 2) * 288 + (y & 3);
      //int v = calcColor(y, frameCount * 2, ci, 0);

      int v = 0;
      for (int bar = 0; bar < 3; bar++) {
        int c = calcColor(y, frameCount * 2, ci, bar * 10);
        if (c > v) v = c;
      }
      drawLine(di, ci, v);

    }
  }
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  noLoop();
}
