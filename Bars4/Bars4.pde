PImage img, img2;
PGraphics pg;
int COLS=64;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int il; //interlace
int di;
int es;
int bp;
int v;
int xx=1;
int intensity12[] = { -1, -1, -1, -1, 0x55, 0, 0, 0, 0, 0, 0, 0x55, -1, -1, -1, -1 } ;
int t=0;
int offset;

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(500);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  es = R;
}

void draw() {
  for (int i=0; i<1000; i++) fast_draw();
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void fast_draw() {
  di+=xx;

  if (di>=12800) {
    di-=12800;
  }
  
  if (++bp==5000) {
    bp=0;
    t++;
    //t=t&8191; //4095; //1023;
  }

  if ((t&15)==0) {
    t++;
    nextEffect();
  }

  int y = ((di>>8)<<2) | di&3;
  int x = (di >> 2) & 0x3F;

  //al.set(y);

  x+=offset;
  y+=offset;

  al.set(x<<1);
  sine256();
  int v = al.get();
  al.set(y>>1);
  sine256();

  al.add(v);
  al.add(t);


  mem[es + di] = intensity12[al.get()>>4]; //(int)random(255);
}

void nextEffect() {
  xx++;
  xx%=255;

  offset = xx*10;

  for (int i=0; i<14400; i++) {
    mem[es + i] = 0;
  }

  //es ^= 0x4000;
  if (es==R) es=G;
  else if (es==G) es=B;
  else es=R;
}





////import java.util.ArrayDeque;
////ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
////byte slash[];
//PImage img, img2;
////int si, di;
//PGraphics pg;
//int COLS=64;
//int mem[] = new int[1024*1024*2];
//int R=0xf0000, G=0x0C000, B=0xf4000;
//int channels[] = {R, G, B};
//int di = 0;
//int es = R;
//int xx = 3;
////int intensity12[] = { 0, 0, 0, 0, 34, 34, 136, 170, 85, 238, 187, 119, 221, 255, 255, 255 };
//int intensity12[] = { -1, -1, -1, -1, 0x55, 0, 0, 0, 0, 0, 0, 0x55, -1, -1, -1, -1 } ;
//int t = 1;
//int x, y;
//int xoff, yoff;

//void setup() {
//  size(1280, 800, P2D);
//  noSmooth();
//  frameRate(500);
//  img = createImage(COLS*8, 200, RGB);
//  pg = createGraphics(width, height);
//  es = R;
//}

//void draw() {
//  for (int i=0; i<1000; i++)
//    fast_draw();
//  setImageFromMemory(img);
//  image(img, 0, 0, width, height);
//}

//void calc_xy() {
//  x = (di>>2) & 0x3F;
//  y = (di>>8)<<2 | di&3;
//}

//void fast_draw() {
//  di+=xx;

//  if (di>=12800) {
//    di-=12800;
//    t++;
//    t=t & 8191; //4095; //1023;
//  }

//  if (t==0) {
//    nextEffect();
//  }


//  //if (t==0) {
//  //  xx%=255;
//  //  xx++ ; // (int)random(255);
//  //  //es ^= 0x4000;

//  //  xoff = xx;
//  //  yoff = xx;

//  //  for (int i=0; i<12800; i++) {
//  //    mem[es + i] = 0;
//  //  }

//  //  if (es==R) es=G;
//  //  else if (es==G) es=B;
//  //  else es=R;
//  //}

//  calc_xy();

//  x+=xoff;
//  y+=yoff;

//  al.set(x<<1);
//  sine256();
//  int v = al.get();
//  al.set(y>>1);
//  sine256();
//  al.add(v);
//  //al.add(t<<4);
//  al.add(t>>5);

//  mem[es + di] = intensity12[al.get()>>4];



//  //    //  //es ^= 0x4000;

//  //    //  xoff = xx;
//  //    //  yoff = xx;

//  //    //  for (int i=0; i<12800; i++) {
//  //    //    mem[es + i] = 0;
//  //    //  }

//  //    //  if (es==R) es=G;
//  //    //  else if (es==G) es=B;
//  //    //  else es=R;
//  //  }

//  //x+=xoff;
//  //y+=yoff;

//  //al.set(x);

//  //al.set(x<<1);
//  //sine256();
//  //int v = al.get();
//  //al.set(y>>1);
//  //sine256();

//  //al.add(v);
//  //al.add(t>>5);


//  //mem[es + di] = intensity12[al.get()>>4]; //(int)random(255);
//}

//void nextEffect() {
//  //xx = (xx+1) % 255;
//  xx%=255;
//  xx++ ; // (int)random(255);

//  xoff = xx;
//  yoff = xx;

//  for (int i=0; i<14400; i++) {
//    mem[es + i] = 0;
//  }

//  if (es==R) es=G;
//  else if (es==G) es=B;
//  else es=R;
//}

void keyPressed() {
  //xx++;
  nextEffect();
  if (key=='p') {
    noLoop();
    redraw();
  }
}
