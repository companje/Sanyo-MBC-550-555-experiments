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
  draw_char_xy(chrB, 12, 0, 16, 12); //width must be multiple of 8
  
  copy_red_to_green(0, 0, 3*8, 12);
  
  setImageFromMemory(img);
}

void copy_red_to_green(int ox, int oy, int w, int h) { //x and with multiples of 8
    
}


void draw_char_xy(byte[] bytes, int ox, int oy, int w, int h) {

  int y=0;
  int bp=0;
  do { //y
    int yy = y+oy;
    int ydiv4 = yy >> 2 ;
    int ymod4 = yy & 3;
    int di_base = ydiv4 * (4*COLS) + ymod4;
    int x=0;
    do { //x
      int xx = x + ox;
      int xdiv8 = xx >> 3;
      int xdiv8x4 = xdiv8 << 2;
      int xmod8 = xx & 7;
      println(bp, x,xmod8);
      
      int bpmod8 = bp & 7;
      int bpdiv8 = bp >> 3;

      int di = di_base + xdiv8x4 ;
      int dh = 128 >> xmod8; // dst bit
      int si = bpdiv8;
      int dl = 128 >> bpmod8; //src bit

      if ((bytes[si] & dl) > 0) {
        memory[R + di] |= dh; // set 
      }
      
      bp++;
    } while (++x<w);
  } while (++y<h);
}

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
