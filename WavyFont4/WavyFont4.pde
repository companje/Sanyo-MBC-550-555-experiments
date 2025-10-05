PImage img, img2;
int si, di, bx, es, ds, bp;
PGraphics pg;
int COLS=72;
int ROWS=50;
int ox=COLS/2;
int oy=ROWS/2;
int W=COLS*4;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0c000, B=0xf4000, rom=0xfe000, font=0xff000;
int channels[] = {R, G, B};
int colorTable[] = new int[256*4*4]; //256 colors, 4 line patterns per color, 3 color channels
//int hstep=4, vstep=4608;
int t, effect;
int step=4; //4608+4;
int NUM=4*COLS*ROWS;

//int chars[] = {3,12,48,192,192,48,12,3};
int chars[] = {7, 56, 64, 128, 128, 64, 56, 7, 128+64+32, 16+8+4, 2, 1, 1, 2, 16+8+4, 128+64+32};
//int chars[] = {255,128,128,131,255,1,1,193,131,128,128,255,193,1,1,255};
//int chars[] = {255,255,240,240,252,252,0,0,0,0,63,63,15,15,255,255};
//int chars[] = {24,24,24,24,231,231,231,231,0,255,255,0,255,0,0,255};
//int chars[] = {255,128,128,131,255,1,1,193,131,128,128,255,193,1,1,255};
//int chars[] = {0,24,0,0, 0,0,24,0};
//int chars[] = {60,255,255,60,60,195,195,60,195,0,0,195,195,60,60,195};

void setup() {
  ((PGraphicsOpenGL) g).textureSampling(2);

  size(1280, 800, P2D);
  textFont(loadFont("Ac437_SanyoMBC55x-72.vlw"), 72);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  loadBin("material16x4-dit2.pal", 0); //palette has no header
  loadBin("mbc55x-v120.rom", rom);
  loadChars(chars, font);
  
  di = 14400/2-144;

  //mem[font+0] = 3;
  //mem[font+1] = 12;
  //mem[font+2] = 48;
  //mem[font+3] = 192;

  //mem[font+4] = 192;
  //mem[font+5] = 48;
  //mem[font+6] = 12;
  //mem[font+7] = 3;
}

void draw() {
  for (int it=0; it<50; it++) {
    int x = (di%288)/4;
    int y = di/288;

    int p;


    //if (di>288) {
    //  p = mem[R+di-288]==24 ? 62 : mem[R+di-288]==96 ? 60 : 0;
    //} else {
    //  p = random(1)<.1 ? (random(1)<.5 ? 62 : 60) : 0;
    //}

    //p = (di%(t+1)==0) ? 0 : 1;
    p = (int)random(0, chars.length/4); //(random(1)<.5) ? 0 : 1;

    si = font + p*4;
    drawCell();

    boolean found = false;
    while (!found) {
      di = int(random(14400/4))*4;
      if (mem[R+di]==0) {
        if (mem[R+di-4]!=0 || mem[R+di+4]!=0 || mem[R+di-COLS*4]!=0 || mem[R+di+COLS*4]!=0) {
          found=true;
        }
      }
    }

    //di+=step;
    if (di>NUM) di-=NUM;

    bp++;
    bp&=63; //4095;
    if (bp==0) {
      t++;
      println("t",t);
      //noLoop();
      //println(t);
    }
  }
  
  //for (int i=0; i<255*8; i++) {
  //  mem[G+i] = mem[font+i];
  //}

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  //fill(255);
  text(step + " " + (step/4), 50, 100);

  img.get(0, 0, 40, 40).save("tmp.png");
}

void keyPressed() {
  if (key=='c') clearAll();
  if (key=='1') step=4;
  if (keyCode==LEFT) step-=4;
  if (keyCode==RIGHT) step+=4;
  if (keyCode==DOWN) step+=COLS*4;
  if (keyCode==UP) step-=COLS*4;
  if (key=='[') t--;
  if (key==']') t++;
  //clearAll();
  println("step", step, "t", t);
  if (step<4) step=4;
  if (step>COLS*4*ROWS) step-=COLS*4*ROWS;
  di=0;
  if (key=='p') noLoop();
  if (key=='P') loop();
}
