//PImage img, img2;
//PGraphics pg;
//float COLS=72;
//float mem[] = new int[1024*1024*2];
//float R=0xf0000, G=0x0C000, B=0xf4000;
//float xx, yy;
int w=99;
int step=1;
int i=0;
int t=47; //start time
int m=2;
int c=0; //frame counter
int n=w*50; //w*ROWS
int primes[] = get_primes();

void setup() {
  size(800, 488);
  frameRate(60);
  background(0);
  fill(255);
  smooth();
  noStroke();
}

void draw() {
  scale(8);
  for (int j=0; j<1000; j++) draw2();
}

void draw2() {
  int x = i%w; // Ray direction in world space.
  int y = i/w;

  float a=x*.02-1;
  float b=1-y*.025;

  float s=b; //bg
  float d=1; //light

  float X=t, Y=1, Z=2;

  // Ray tracing!
  for (; Z<w; Z++) {
    if (isThereAnythingAt(X, Y, Z, t)) { //Hit model, now continue ray tracing toward the light
      float last_d = d;
      s=(int(X)&int(Y)&int(Z))%3; //The texture.
      s/=Z; // Fog.
      a=b=1; // New direction, toward the light.
      d=Z/w;
      if (last_d < 1) break;
    }
    X+=a;
    Y-=b;
  }
  float darkness = d * d - s;

  fill((darkness)*255);
  rect(x, y, 1, 1);

  if (c++>n) { //pixel counter
    c=0;
    t++;
  }

  i+=step;
  if (i>n) i-=n;
}

boolean isThereAnythingAt(float X, float Y, float Z, float t) {

  if (m==0) {
    Z-=5;
    return Z%50>30 && (Y+110)%50<20 && X%50<20;
  } else if (m==1) {
    X-=t;
    Z-=110; //height/2-mouseY/2;
    return sqrt(X*X+Y*Y+Z*Z) < 30;
  } else if (m==2) {
    int GROUND_PLANE = 6;
    int CITY_DISTANCE = 34;
    int AVENUE_WIDTH = 27;
    float AVENUE_PERIOD = 99;
    float BUILDING_WIDTH = 9;
    float BUILDING_DEPTH = 8;
    float BUILDING_HEIGHT = 45;

    int xi = (int)(X / BUILDING_WIDTH);
    int zi = (int)(Z / BUILDING_DEPTH);

    boolean condition1 = CITY_DISTANCE < Z;
    boolean condition2 = AVENUE_WIDTH < (X % AVENUE_PERIOD);
    boolean condition3 = (xi ^ zi) != 0;

    boolean combined = condition1 && condition2 && condition3;

    int modifier = combined ? ((xi ^ zi) * 8) % (int)(BUILDING_HEIGHT + 1) : 0;

    return Y >= GROUND_PLANE - modifier;
  } else {
    X -= t;
    Z -= 70;
    Y += 10;
    float r[] = rot(X, Y, t/50);
    X = r[0];
    Y = r[1];
    r = rot(Y, Z, t/20);
    Y = r[0];
    Z = r[1];
    float q = dist(0, 0, X, Z)-20;
    return dist(0, 0, q, Y)-10 < 0;
  }
}

float[] rot(float x, float y, float theta) {
  float s = sin(theta);
  float c = cos(theta);
  float r[] = {c*x+s*y, c*y-s*x};
  return r;
}

void mousePressed() {
  println(t);
}

void mouseMoved() {
  int index = int(float(mouseX)/width*primes.length);
  println(index);
  step = primes[index];
}

void keyPressed() {
  if (key=='m') m=(m+1)%4;
  //if (key=='t') t++;
  if (key=='x') step++;
  if (key=='X') step--;
  if (key=='y') step+=w;
  if (key=='Y') step-=w;
  println(step);
}
