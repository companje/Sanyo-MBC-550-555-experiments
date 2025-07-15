int d=33;
int sc = 300;
int x0 = 1000;
int s = 2000;
int mask = 0xffff;

void setup() {
  size(500, 500);
  background(0);
  stroke(255);
}

void draw() {
  background(0);
  translate(width/2, height/2);

  //int d = 4; //5*frameCount + 300;  // 0.03 * SCALE = 300
  //int x = x0; // 0.1 * SCALE = 1000
  //int y = 0;

  //for (int i = 0, n = 100*4; i < n; i++) {
  //  int dx = ((d * y)&0xffff) / s;
  //  int dy = ((d * x)&0xffff) / s;

  //  x = (x + dx) & 0xffff;
  //  y = (y - dy) & 0xffff;

  //  //(x * sc) / SCALE
  //  stroke(255);
  //  point(i, (y * sc) / s);

  //  stroke(0, 255, 0);
  //  point((x * sc) / s, (y * sc) / s);
  //}
  
   int SCALE = 10000;
  int d = 300;  // 0.03 * SCALE
  int x = 1000; // 0.1 * SCALE
  int y = 0;

  for (int i = 0, n = 210; i < n; i++) {
    int dx = ((d * (y & mask)) & mask) / SCALE;
    int dy = ((d * (x & mask)) & mask) / SCALE;

    x = (x + dx) & mask;
    y = (y - dy) & mask;
println(x,y);
    point(((x * 1000) / SCALE) - 32768 / SCALE, ((y * 1000) / SCALE) - 32768 / SCALE);
  }
  
}

void keyPressed() {
  if (key=='[') d--;
  if (key==']') d++;
  if (key=='x') x0-=10;
  if (key=='X') x0+=10;
  if (key=='s') s-=10;
  if (key=='S') s+=10;
  println("d=",d,"s=",s,"x0=",x0);
}
