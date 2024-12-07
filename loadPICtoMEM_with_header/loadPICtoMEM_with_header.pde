byte[] memory = new byte[0x200000];
PGraphics pg;
PImage img, screen;
int R=0xf0000, G=0xC000, B=0xf4000;
Viewport view;

void settings() {
  size(1152, 800);
  noSmooth();
}

void setup() {
  surface.setLocation(755, 0);
  pg = createGraphics(576, 200); //fbo
  img = loadImage("bandit3.png");
  pg.beginDraw();
  pg.background(0);
  pg.image(img, 0, 0);
  pg.endDraw();

  setMemoryFromImage(memory,img);
  setImageFromMemory(memory,img);
  
  //getSnapshot(0, 0, 8*4, 12*4);

  image(img,0,0);
}

void draw() {
}

void setImageFromMemory(byte memory[], PImage img) {
  println(img.width, img.height);
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

void setMemoryFromImage(byte memory[], PImage img) { //expects 3-bit full R,G,B,W,C,M,Y,K
  println(img.width, img.height);
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

void keyPressed() {
  if (key=='s') {
    byte bytes[] = getSnapshot(0, 0, 8*4, 12*4);
    saveBytes("/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/data/full.bin", bytes);

    //for (int y=0, h=12; y<h; y++) {
    //  for (int x=0, w=8; x<w; x++) {
    //    saveBytes("/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/data/"+int(y*w+x)+".bin", getSnapshot(x*4, y*4, 4, 4));
    //  }
    //}
    println("saved");
  }
}
