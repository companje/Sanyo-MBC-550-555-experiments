int[] memory = new int[0x200000];
int COLS = 72;
//int greenOffset = 0xC000;
PGraphics pg;
PImage img,bandit,beker;
int R=0xf0000,G=0xC000,B=0xf4000;

void settings() {
  size(1152, 700);
  noSmooth();
}

void setup() {
  surface.setLocation(755, 0);
  img = createImage(COLS*8, 200, RGB); //72*8=576
  pg = createGraphics(img.width, img.height); //fbo
  bandit = loadImage("bandit3.png");
  beker = loadImage("beker.png");
}

void draw() {
  pg.beginDraw();
  pg.background(0);
  pg.image(beker, 0, 0);
  pg.endDraw();

  setMemoryFromImage(pg);
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
    
  saveBytes("/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/bootpic/snapshot.bin", getSnapshotSeparated(0,0,4,4)); //(col,row,cols,rows) 1 col=8px, 1 row=4px
}

//byte[] getSnapshot(int col, int row, int cols, int rows) {
//   byte bin[] = new byte[rows*cols*4*3]; //4x4 cells x 3 colors = 32x16px x 3 colors = 192 bytes
//   for (int i=0; i<bin.length/3; i++) {
//     bin[i] = ...
//   }
//   return bin;
//}

byte[] getSnapshotSeparated(int col, int row, int cols, int rows) {
  byte[] bin = new byte[rows * cols * 4 * 3];
  int redOffset = 0, greenOffset = rows * cols * 4, blueOffset = rows * cols * 4 * 2;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      for (int y = 0; y < 4; y++) {
        int baseIndex = (row + r) * (img.width / 2) + y + (col + c) * 4;
        bin[redOffset + (r * cols + c) * 4 + y] = (byte) memory[R + baseIndex];
        bin[greenOffset + (r * cols + c) * 4 + y] = (byte) memory[G + baseIndex];
        bin[blueOffset + (r * cols + c) * 4 + y] = (byte) memory[B + baseIndex];
      }
    }
  }
  return bin;
}

//byte[] getSnapshot(int col, int row, int cols, int rows) {
//  byte[] bin = new byte[rows * cols * 4 * 3];
//  for (int r = 0; r < rows; r++) {
//    for (int c = 0; c < cols; c++) {
//      for (int y = 0; y < 4; y++) {
//        for (int chn= 0; chn < 3; chn++) {
//          int memoryOffset = (chn == 0 ? R : chn == 1 ? G : B);
//          int baseIndex = memoryOffset + (row + r) * (img.width / 2) + y + (col + c) * 4;
//          bin[(r * cols + c) * 12 + y * 3 + chn] = (byte) memory[baseIndex];
//        }
//      }
//    }
//  }
//  return bin;
//}

//byte[] getGreenSnapshot(int col, int row, int cols, int rows) {
//  byte[] bin = new byte[rows * cols * 4];
//  for (int r = 0; r < rows; r++) {
//    for (int c = 0; c < cols; c++) {
//      for (int y = 0; y < 4; y++) {
//        int baseIndex = G + (row + r) * (img.width / 2) + y + (col + c) * 4;
//        bin[(r * cols + c) * 4 + y] = (byte) memory[baseIndex];
//      }
//    }
//  }
//  return bin;
//}




void setImageFromMemory(PImage img) {
  img.loadPixels();
  for (int y=0, bit=0, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (memory[R+i] & bit)>0 ? 255 : 0;
      int g = (memory[G+i] & bit)>0 ? 255 : 0;
      int b = (memory[B+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
}

void setMemoryFromImage(PImage img) { //expects 3-bit full R,G,B,W,C,M,Y,K
  img.loadPixels();
  for (int y=0, bit=0, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      if ((int(red(img.pixels[j]))&255)>0) memory[R+i] |= bit; else memory[R+i] &= ~bit;
      if ((int(green(img.pixels[j]))&255)>0) memory[G+i] |= bit; else memory[G+i] &= ~bit;
      if ((int(blue(img.pixels[j]))&255)>0) memory[B+i] |= bit; else memory[B+i] &= ~bit;
    }
  }
}
