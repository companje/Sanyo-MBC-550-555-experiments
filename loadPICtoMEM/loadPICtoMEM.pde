int[] memory = new int[0x200000];
int COLS=72, ROWS=50;
//int greenOffset = 0xC000;
PGraphics pg;
PImage img, bandit, beker;
int R=0xf0000, G=0xC000, B=0xf4000;
Viewport view;
int rows,cols;

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
  bandit = loadImage("bandit4.png");
  rows = bandit.height/4;
  cols = bandit.width/8;
  
  //beker = loadImage("beker.png");

  view = new Viewport(this, 0, 0, width, height, width, height);
}

void draw() {
  int x = int(mouseX/float(width)*COLS);
  int y = int(mouseY/float(height/2)*ROWS);

  pg.beginDraw();
  pg.background(0);
  pg.image(bandit, 0, -16*12);
  //pg.scale(1, 0.5);
  //pg.fill(255, 25, 0);
  //pg.ellipse(403, 98, 40, 40);
  pg.endDraw();

  setMemoryFromImage(pg);
  setImageFromMemory(img);

  ////view.begin();
  image(img, 0, 0, width, height);
  //image(pg, 0, 0, width, height);

  //noFill();
  //stroke(100);
  //rect(x*16, y*8, 16, 16);
  //for (int y=0; y<height; y+=4*4) {
  //  for (int x=0; x<width; x+=4*4) {
  //    line(x, 0, x, height);
  //    line(0, y, width, y);
  //  }
  //}


  //String s = x+","+y;
  //fill(0);
  //rect(mouseX-textWidth(s)/2, mouseY+10, textWidth(s), 18);
  //fill(255);
  //text(s, mouseX, mouseY+25);

  //view.end();
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

void keyPressed() {
  if (key=='s') {
    byte bytes[] = getSnapshot(0, 0, cols, rows);
    //saveBytes("/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/data/full.bin", bytes);

    for (int y=0, h=12; y<h; y++) {
      for (int x=0, w=8; x<w; x++) {
        saveBytes("data/"+int(y*w+x)+".bin", getSnapshot(x*4, y*4, 4, 4));
        ///Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/
      }
    }
    println("saved");
  }
}
