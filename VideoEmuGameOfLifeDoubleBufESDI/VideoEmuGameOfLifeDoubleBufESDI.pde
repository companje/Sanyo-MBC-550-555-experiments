short DS = (short)0x0c000;
short ES = (short)0x1c000;
short SS = (short)0x0be4;
short ROWS = 50;
short COLS = 72;
short WH = (short)(ROWS*COLS);
byte mem[] = new byte[1024*1024];
PImage img = createImage(576, 200, RGB);
int shortOffset = Short.MAX_VALUE;
byte al;
short si=0, di=0, sp=-1;

void setup() {
  size(576, 400);
  surface.setLocation(840, 620);
  frameRate(50);

  short shape[] = { 0, 4, 8, 288, 580 };
  al = byte(255);
  for (byte cl=5; cl-->0; ) {
    di = shape[cl];
    stosb();
    stosb();
    stosb();
    stosb();
  }

  noLoop();
  image(getVRAM(ES), 0, 0, width, height); ////out 0x10,4 or 5
}

void stosb() {
  mem(ES + di++, al);
}

void lodsb() {
  al = mem(DS + si++);
}

void mem(int a, byte b) {
  mem[Short.MAX_VALUE + a] = b;
}

byte mem(int a) {
  return byte(mem[Short.MAX_VALUE + a]);
}

void setDot(int x, int y, boolean c) {
  for (int j=0; j<4; j++)
    mem[Short.MAX_VALUE + ES + (y*COLS+x)*4 + j] = byte(c ? 255 : 0);
}

int getDot(int x, int y) { //0 or 1
  return mem[Short.MAX_VALUE + DS + (y*COLS+x)*4]&1;
}

int countCells(int x, int y) {
  int n=0;
  for (int i=0; i<9; i++) {
    if (i==4) continue;
    int xx = (x+i%3-1+COLS) % COLS;
    int yy = (y+i/3-1+ROWS) % ROWS;
    if (getDot(xx, yy)!=0) n++;
    if (n!=0) println(n);
  }
  return n;
}

void draw() {
  short tmp=DS;  //swap
  DS=ES;
  ES=tmp;

  si=0;
  di=0;

  for (int y=0; y<ROWS; y++) {
    for (int x=0; x<COLS; x++) {
      //boolean alive = getDot(x, y)==1;
      int n = countCells(x, y);
      //setDot(x, y, (!alive && n==3) || (alive && (n==2||n==3)) );
      if (n==3) setDot(x, y, true);
      else if (n==4) setDot(x, y, getDot(x, y)==1);
      else setDot(x, y, false);
    }
  }

  image(getVRAM(ES), 0, 0, width, height); ////out 0x10,4 or 5
}


//      //setDot(x, y, n==3 ? true : n==4 ? getDot(x, y)==1 : false)

//        //int n=0;
//        //for (int ch=1; ch>=-1; ch--) {
//        //  for (int cl=1; cl>=-1; cl--) {
//        //    int yy = (y+ch+ROWS) % ROWS;
//        //    int xx = (x+cl+COLS) % COLS;

//        //    //push(si);
//        //    n+=mem(DS + (yy*COLS+xx)*4)&1;
//        //    //n+=getDot(xx, yy)?1:0;
//        //    //si=pop_();
//        //  }
//        //}

//        //n=3;

//        //if (n==3) al = -1; //byte(255);
//        //else if (n!=4) al = 0;

//        //stosb();
//        //stosb();
//        //stosb();
//        //stosb();
//    }
//  }

//  image(getVRAM(ES), 0, 0, width, height); ////out 0x10,4 or 5
//}

PImage getVRAM(int GREEN_PAGE) {
  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*img.width/2+(y%4)+int(x/8)*4;
      //op de sanyo page wisselen via out commando
      img.pixels[j] = color(0, (mem(GREEN_PAGE+i) & bit)>0 ? 255 : 0, 0);
    }
  }
  img.updatePixels();
  return img;
}

////void push(short v) {
////   mem(SS + sp--, byte(v&255)); //CHECKME
////   mem(SS + sp--, byte(v>>8)); //CHECKME
////}

////short pop_() {
////  //CHECKME
////  return (short)(mem(SS + sp++)<<8 | mem(SS + sp++));
////}
