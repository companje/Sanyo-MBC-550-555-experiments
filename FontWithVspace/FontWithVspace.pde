import java.util.Deque;
import java.util.ArrayDeque;
HashMap<String, Integer> regs = new HashMap();
Deque<Integer> stack = new ArrayDeque();
int[] memory = new int[0x200000];
int COLS=72, ROWS=50;
//int greenOffset = 0xC000;
PGraphics pg;
PImage img, debug; //, bandit, beker;
int R=0xf0000, G=0x0C000, B=0xf4000; //absolute address
int rows, cols;
int ax = 0;
int cx = 0;
int si = 0;
int di = 0;
int al = 0;
int cl = 0;
int ds = 0;
int es = 0x0c00; //segment

void settings() {
  size(1152, 850);
  noSmooth();
}

void setup() {
  textSize(18);
  textAlign(CENTER);
  cursor(CROSS);
  surface.setLocation(650, 0); //755
  img = createImage(COLS*8, 200, RGB); //72*8=576
  debug = createImage(COLS*8, 200, RGB); //72*8=576


  byte[] font = loadBytes("8x4-nibble-font.bin");
  for (int i=0; i<font.length; i++) memory[i]=font[i];

  //es = G>>4;
  //di = 70*4 * 4;
  //for (int i=0; i<5*59; i++) {
  //  al=(i%59)+33;
  //  draw_char();
  //}
  
  
  
  //es = R>>4;
  //for (int i=0; i<59; i++) {
  //  al=i+33;
  //  draw_char();
  //}

  es = G>>4;
  draw_char(1,1,'A');
  draw_char(1,2,'B');

  setImageFromMemory(img);
}

void draw_string() {
}

cursor.x
cursor.y

void draw_char(int col, int row, int ch) {
  
}

//deze functie houdt nog geen rekening met een lege lijn tusse de regels
//hij kan wel op elke y positie een char tekenen maar bij het einde van de
//regel zal ie nog niet automatisch een lijn overslaan

//72 x 40
//xy db 

void draw_char() { //input si,di,al
  stack.push(di);
  al-=33;
  al<<=1; // *=2
  al<<=1; // *=2
  si=al;
  ax=di;
  ax&=3; //ax=di%4
  cx=4;
  cx-=ax;
  rep_movsb();

  if (ax>0) {
    cx=ax;
    di+=4*72-4;
    rep_movsb();
  }

  di=stack.pop();
  //println();

  di+=4;

//println(di%(4*71));

  if (di%(4*71)>=280) {
    println("nu");
    di++;
  }
}




void rep_movsb() {
  while (cx-->0) memory[(es<<4)+di++] = memory[(ds<<4)+si++];
}

void movsw() {
  memory[(es<<4)+di++] = memory[(ds<<4)+si++];
  memory[(es<<4)+di++] = memory[(ds<<4)+si++];
}

void cbw() {
}

void draw() {
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
