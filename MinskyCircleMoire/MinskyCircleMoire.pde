int d = 202;
int x = 1100;
int y = 1;

void setup() {
  size(640, 400);
  background(0);
  stroke(255);
}

void draw() {
  for (int i=0; i<10000; i++) draw2();
}

void mousePressed() {
  background(0);
  d = (int)random(400);
  println(d);
  x = 1100;
  y = 1;
}

void draw2() {
  int a = d*y;
  a >>= 14;

  int b = d*x;
  b >>= 14;

  y -= b;
  x += a;

  //if (abs(atan2(y-height/2,x-width/2)%.05)<.025) return;
  
  
  //if ((x&y)!=0) return;

  //if (!mask8(x, y)) return; //, mouseX/100)) return; // 8 sectoren (wit/zwart afwisselend)

  int xx = x >> 5;
  int yy = y >> 5;

  xx += 320;
  yy += 200;


  point(xx, yy);
}

// 8 sectoren: teken alleen als 4*x*y*(x^2 - y^2) >= 0
boolean mask8(int x, int y) {
  long xx = x, yy = y;
  long v = xx * yy * (xx * xx - yy * yy);
  return v >= 0;
}

// 6 sectoren (alternatief): teken als y*(3*x^2 - y^2) >= 0
boolean mask6(int x, int y) {
  long xx = x, yy = y;
  long v = yy * (3L * xx * xx - yy * yy);
  return v >= 0;
}

boolean maskPow2(int x, int y, int k) {
  long xr = x, yi = y;
  for (int i = 0; i < k; i++) {
    long nx = xr*xr - yi*yi;
    long ny = 2*xr*yi;
    xr = nx;
    yi = ny;
  }
  return yi >= 0;
}




//int d = 202;
//int x = 1100;
//int y = 1;

//void setup() {
//  size(640, 200);
//  background(0);
//  stroke(255);
//}

//void draw() {
//  for (int i=0; i<100; i++) draw2();
//}

//void draw2() {
//  int a = d*y; //32 bit
//  a>>=14;

//  int b = d*x;
//  b>>=14;

//  y-=b;
//  x+=a;

//  int xx=x>>5;
//  int yy=y>>5;

//  xx+=320;
//  yy+=100;

//  point(xx, yy);
//}
