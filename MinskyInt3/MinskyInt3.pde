int mem[] = new int[1024*1024*2];
int d = 202;
int x = 1100;
int y = 1;

void setup() {
  size(640, 200);
  background(0);
  stroke(255);
}

void draw() {
  //background(0);
  //translate(width/2, height/2);
  //line(256+64, 0, 256+64, height);
  //line(0+64, 0, 0+64, height);
  //line(0, height/2, width, height/2);

  //int cx=frameCount*10;
  //int bp=0;
  //do {
  int a = d*y; //32 bit
  a>>=14; 
  //a>>=14;

  int b = d*x;
  b>>=14;
    
  //println(b);
  //exit();
  //if (true) return;

  x+=a;
  y-=b;

  int xx=x>>5;
  int yy=y>>5;

  xx+=320;
  yy+=100;

  println(x, y);

  point(xx, yy);

  //mem[xx] = yy;

  //y++;

  //bp++;
  //if (frameCount==10) exit();
  
  //} while (--cx>0);

  //for (int i=0; i<256; i++) {
  //  point(i, mem[i]);
  //}
}
