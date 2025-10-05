PImage img, img2;
int si, di, bx, es, ds;
PGraphics pg;
int COLS=64;
int ROWS=50;
int W=COLS*4;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int colorTable[] = new int[256*4*4]; //256 colors, 4 line patterns per color, 3 color channels
//int hstep=4, vstep=256; // ; 4608;
int step=4608+4;

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);

  //loadBin("hsb-dithered.spr",0); //sprite has 2 byte header (rows/cols)

  loadBin("material16x4-dit2.pal", 0); //palette has no header
}

void effect(int t, int i, int x, int y) {
  //float zoom = .01; //0.1 * sin(t*.001);
  //float ox = (x-COLS/2) * zoom;
  //float oy = (y-ROWS/2) * zoom * 3;
  //float angle = t*.05;
  //float cx = cos(angle);
  //float sx = sin(angle);
  ////float xr = ox * cx - oy * sx;
  ////float yr = ox * sx + oy * cx;
  //float tixy = sin(ox+angle)*cos(oy+angle); //sin(xr) * cos(yr);
  //float tixy = sin(yr*xr+pow(t, sin(t*t)));
  //float tixy = cos(y/50)*sin(x/72+t/50)*255;

  //x-=36;
  //y-=25;
  
  
  bl.set(x);
  bh.set(y);

  bl.sub(COLS/2);
  bh.sub(ROWS/2);
  
  
  float zoom = map(sin(frameCount*.01),-1,1,.5,.9);
  x*=zoom;
  y*=zoom;
  
  //int zoom = 2;
  //al.mov(bl);
  //al.mul(int(zoom));
  //bl.mov(al);
  
  //bl.shl(1);
  
  //bl.mul(int(zoom));
  //bh.mul(int(zoom));
  
  float angle = t*.01;
  float ct = cos(angle);
  float st = sin(angle);
  x = int(x * ct - y * st);
  y = int(x * st + y * ct);
  
  //x = bl.get();
  //y = bh.get();
  

  al.mov(x);
  al.add(t);
  sin256();
  al.add(y*8);
  //sin256();

}

void draw() {

  for (int it=0; it<100; it++) {
    int x = di%W;
    int y = di/W;
    int i = y*COLS+x;
    int t = frameCount/5;

    effect(t, i, x, y);

    cl.mov(4);
    al.shr(cl); //scale from 0..255 to 0..15
    cl.mov(12);
    al.mul(cl);
    
    si = 0 + al.get();  //al should be between 0..16
    drawCell();

    di+=step; //hstep+vstep; //288*4*
    if (di>14400) {
      di-=14400;
    }
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}


void keyPressed() {
  if (key=='c') clearAll(); 
  //if (keyCode==LEFT) hstep-=4;
  //if (keyCode==RIGHT) hstep+=4;
  //if (keyCode==DOWN) vstep+=COLS*4;
  //if (keyCode==UP) vstep-=COLS*4;
  //println(hstep, vstep);
}
