HashMap<String, Integer> regs = new HashMap();
int[] memory = new int[0x200000];
int COLS=72, ROWS=50;
//int greenOffset = 0xC000;
PGraphics pg;
PImage img, debug; //, bandit, beker;
int R=0xf0000, G=0xC000, B=0xf4000;
int rows, cols;
byte[] chrA, chrB;

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
  debug = createImage(COLS*8, 200, RGB); //72*8=576

  //beker = loadImage("beker.png");
  chrA = loadBytes("chr65.bin");
  chrB = loadBytes("chr66.bin");

  draw_char_xy(chrA, 0, 0, 16, 12); //width must be multiple of 8
  //draw_char_xy(chrB, 12, 0, 16, 12); //width must be multiple of 8
  setImageFromMemory(img);
}

void draw_char_xy(byte[] bytes, int ox, int oy, int w, int h) {
  int n = bytes.length*8-1;

  for (int bp = n; bp>=0; bp--) { //in case of 24 bytes (16x12 pixels) b=bit index 0..192   //16 bits (2 bytes) per line (12 lines)

    int bpdiv8 = bp/8;
    int bpmod8 = bp%8;
    int bpdivw = bp/w;
    int bpmodw = bp%w;
    int x = bpmodw + ox;
    int y = bpdivw + oy;
    int ydiv4 = y/4;
    int ymod4 = y%4;
    int xdiv8 = x/8;
    int xmod8 = x%8;

    println(bp, x, y);
  
    //; di = (y / 4) * (4 * COLS) + (y % 4) + (x / 8) * 4;

    int di = ydiv4;
    di *= 4*COLS;
    di += ymod4;
    di += xdiv8*4;
    
    if (true) {
      int dh = 128>>xmod8; //dst bit ??

      int si = bpdiv8; // source index
      int dl = 128>>bpmod8;

      if ((bytes[si]&dl)>0) {
        memory[R + di] ^= dh; // Set the bit
      } else {
        memory[R + di] &= ~dh; // Clear the bit
      }
    }
  }
}



//void draw_char_xy(byte[] bytes, int ox, int oy, int w, int h) {
//  _mov("bp",bytes.length * 8-1);
//  do {

//    _mov("ax","bp");
//    _div("ax",w); //al=quotient, ah=rest

//  } while (bp-->0);
//}


void draw() {
  //scale(3, 3);
  image(img, 0, 0, width, height);
}

void setImageFromMemory(PImage img) {
  img.loadPixels();
  for (int y=0, bit=128, j=0, w=img.width, h=img.height; y<h; y++) {
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
