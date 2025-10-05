PImage img, img2;
int si, di, bx, es, ds, bp, ax;
PGraphics pg;
int COLS=72;
int ROWS=50;
int W=COLS*4;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0c000, B=0xf4000, rom=0xfe000, font=0xff000;
int channels[] = {R, G, B};
int colorTable[] = new int[256*4*4]; //256 colors, 4 line patterns per color, 3 color channels
//int hstep=4, vstep=4608;
int t=1, effect;
int step=4608+4;
int NUM=4*COLS*ROWS;

int chrs[] = { 0, 176, 177, 178, 219 };


void setup() {
  size(1280, 800, P2D);
  textFont(loadFont("Ac437_SanyoMBC55x-72.vlw"), 72);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
  loadBin("material16x4-dit2.pal", 0); //palette has no header
  loadBin("mbc55x-v120.rom", rom);
}

void draw() {
  for (int it=0; it<1000; it++) {

    ax = (di * 0xe38f) >> 16;

    int x=(ax&255)>>2;
    int y=ax>>8;

    //    mov cx,0xE38F  ; = /288 Sanyo's rrrola constant
    //;   mul cx

    //x-=36;
    //y-=25;

    ////float zoom = 2; //map(sin(frameCount*.01), -1, 1, .5, .9);
    ////x*=zoom;
    ////y*=zoom;

    ////y-=50;

    if (x<minX) minX=x;
    if (x>maxX) maxX=x;
    if (y<minY) minY=y;
    if (y>maxY) maxY=y;


    //x+=36;
    //y+=25;

    //x+=t;
    //y+=t;
    //println(t);
    //x/=t;
    //y/=t;

    //int x = (di%288)/4;
    //int y = di/288;

    int t = frameCount;

    //x/=6;
    //y/=6;




    float angle = t*.01;
    float ct = cos(angle);
    float st = sin(angle);
    x = int(x * ct - y * st);
    y = int(x * st + y * ct);

    al.set(x);
    al.set(al.get()&y);
    //al.add(t);
    //sin256();
    //sin256();
    //sin256();
    //al.add(t);

    //al.mul(y);
    //al.add(t);



    al.set(al.get()%5);
    al.set(chrs[al.get()]);
    //al.add(191);

    //al.set(al.get()%t);

    si = font + al.get()*8; //(((x*y+t)%8)+0 )*8; //(al.get()>>4)*12;
    drawCell();

    di+=step;
    if (di>NUM) di-=NUM;

    //bp++;
    //bp&=4095;
    //if (bp==0) {
    //  t++;
    //  //x+=10;
    //  //y+=10;
    //  //step+=4;
    //  //println(t);
    //}
  }

  //for (int i=0; i<255*8; i++) {
  //  mem[G+i] = mem[font+i];
  //}

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  fill(255);
  //text("", 50, 100);
  //step + " " + (step/4)
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
