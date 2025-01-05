int[] memory = new int[0x200000];
int COLS=72, ROWS=50;
//int greenOffset = 0xC000;
PGraphics pg;
PImage img, bg, beker;
int R=0xf0000, G=0xC000, B=0xf4000;
Viewport view;
int rows,cols;
String input_filename = "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Keyboard-Sprite/data/player/player-rotate.png";
String output_filename = "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Keyboard-Sprite/data/player/player-rotations.bin";

void settings() {
  size(1152, 850);
  noSmooth();
}

void setup() {
  textSize(18);
  textAlign(CENTER);
  cursor(CROSS);
  surface.setLocation(755, 0);
  img = createImage(COLS*8, 200, RGB); //72*8=576
  pg = createGraphics(img.width, img.height); //fbo
  
  bg = loadImage(input_filename);
  rows = bg.height/4;
  cols = bg.width/8;
  
  print(cols,rows);
}

void keyPressed() {
  if (key=='s') {
    //byte bytes[] = getSnapshot(0, 0, 25, 44);
    //128x64 = rows,cols?
    byte bytes[] = getSnapshot(0, 0, cols, rows);
    saveBytes(output_filename, bytes);
    println("saved");
  }
}

void draw() {
  pg.beginDraw();
  pg.background(0);
  pg.image(bg, 0, 0);
  
  //for (int yi=0; yi<4; yi++) {
  //  for (int xi=0; xi<4; xi++) {
  //    pg.ellipse(4+xi*8,2+yi*4,8,4);
  //  }
  //}
    
  
  pg.endDraw();
  setMemoryFromImage(pg);
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

byte[] getSnapshot(int col, int row, int cols, int rows) { //1 row=4px, 1 col=8px
  byte[] bin = new byte[rows * cols * 4 * 3];
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      for (int y = 0; y < 4; y++) {
        int baseIndex = (row + r) * (img.width / 2) + y + (col + c) * 4;
        bin[rows * cols * 4 * 0 + (r * cols + c) * 4 + y] = (byte) memory[R + baseIndex];
        bin[rows * cols * 4 * 1 + (r * cols + c) * 4 + y] = (byte) memory[G + baseIndex];
        bin[rows * cols * 4 * 2 + (r * cols + c) * 4 + y] = (byte) memory[B + baseIndex];
      }
    }
  }
  return bin;
}


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
      if ((int(red(img.pixels[j]))&255)>50) memory[R+i] |= bit;
      else memory[R+i] &= ~bit;
      if ((int(green(img.pixels[j]))&255)>50) memory[G+i] |= bit;
      else memory[G+i] &= ~bit;
      if ((int(blue(img.pixels[j]))&255)>50) memory[B+i] |= bit;
      else memory[B+i] &= ~bit;
    }
  }
}
