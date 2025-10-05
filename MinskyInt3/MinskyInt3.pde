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
  int a = d*y; //32 bit
  a>>=14;

  int b = d*x;
  b>>=14;

  y-=b;
  x+=a;

  int xx=x>>5;
  int yy=y>>5;

  xx+=320;
  yy+=100;

  point(xx, yy);
}
