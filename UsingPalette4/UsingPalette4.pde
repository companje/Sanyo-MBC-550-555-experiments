PImage img, img2;
int si, di, bx, es, ds, bp;
PGraphics pg;
int COLS=72;
int ROWS=50;
int W=COLS*4;
int NUM=4*COLS*ROWS;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int colorTable[] = new int[256*4*4]; //256 colors, 4 line patterns per color, 3 color channels
//int hstep=4, vstep=4608;
int t,effect;
int step=4; //4608+4;

//int beat, measure; //elke 4 beats verhoogt de measure. Elke 16 measures verhoogt de ...

void setup() {
  size(1280, 800, P2D);
  textFont(loadFont("Ac437_SanyoMBC55x-72.vlw"), 72);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  loadBin("material16x4-dit2.pal", 0); //palette has no header
}

void draw() {

  for (int it=0; it<100; it++) {

    int x = (di%288)/4;
    int y = di/288;

    //int i = y*COLS+x;
    //int t = frameCount/5;

    //print(y + " ");


    al.mov(y);
    al.add(t);
    sin256();
    al.add(t+x>>effect);

    si = (al.get()>>4)*12;  //al should be between 0..16

    //if (x>20 && x<150 && y>10 && y<40) {
    drawCell();
    //}

    di+=step; //hstep+vstep; //288*4*
    if (di>NUM) di-=NUM;
   
    bp++;
    bp&=4095;
    if (bp==0) {
      println(t);
      t++;
    }
    
    //if ((t&511)!=0) {
    //  effect++;
    //  t+=737; 
    //}
    
    //if (random(1)<.0001) {
    //  println("rnd");
    //  t+=int(random(1000));
    //  effect = int(random(3));
    //  //t+=737; 
    //}
    
    //if ((bp&0xfffe)!=0) {
    //  println("asdf");
    //  bp=0;
    //  t++;
    //}
    
    //if ((bp2&0xffff)!=0) {
    //  t++;
    //}
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);

  fill(255);
  text(step + " " + (step/4), 50, 100);
}

void keyPressed() {
  if (key=='c') clearAll();
  if (key=='1') step=4;
  if (keyCode==LEFT) step-=4;
  if (keyCode==RIGHT) step+=4;
  if (keyCode==DOWN) step+=COLS*4;
  if (keyCode==UP) step-=COLS*4;
  clearAll();
  println(step);
  if (step<4) step=4;
  if (step>COLS*4*ROWS) step-=COLS*4*ROWS;
  di=0;
}
