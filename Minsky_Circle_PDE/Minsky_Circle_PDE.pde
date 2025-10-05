import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int mem[] = new int[1024*1024*2];


void setup() {
  size(576, 400);
  background(0);
  frameRate(1000);
  stroke(255);
  colorMode(HSB);
}



int minX=10000;
int minY=10000;
int maxX=-10000;
int maxY=-10000;

void draw() {
  drawSpiral();
  //   if (x<minX) minX=x;
  //    if (x>maxX) maxX=x;
  //    if (y<minY) minY=y;
  //    if (y>maxY) maxY=y;
  //println(minX,maxX,minY,maxY);


  //println(x);
}

void drawSpiral() {
  background(0);

  int d0 = 300;
  int x0 = 1100;
  int d = d0; //202;
  int x = x0;
  int y = 1;
  int ax, bx, cx, dx;

  for (int i=0; i<10000; i++) {
    cx = 2<<13;

    ax = d*y; //32 bit
    ax = ax / cx;
    stack.push(ax);

    ax = d*x;
    ax = ax / cx;

    y-=ax;
    ax = stack.pop();
    x+=ax;

    bx=(x>>5) + mouseX;
    dx=(y>>5) + mouseY;

    int t = frameCount;

    float X=map(atan2(y, x), -PI, PI, 0, 255);
    float Y=100000/sqrt(x*x+y*y+1);
    float c = (X+Y+t)%255;
    //float Y=sqrt(100/(((t)%100)+x*x+y*y+1));
    //float c=X+Y;
    //float xx = (atan2(y,x)+PI)*2.546 ;
    //float yy = 999/sqrt(x*x+y*y+1);
    //float c = xx+yy;
    ////int vv = int(((t*.1)%100) + bx*bx+dx*dx+1);
    ////int Y=(999/vv); //.5;
    color cc = color(c, 255, 255); //   (((X)+(Y))+(t*.01) % 255 ));

    stroke(cc);

    point(bx, dx);
  }
}

void mouseMoved() {

  //x0++;
  //x=x0;
  //d0++;
  //d=d0;
  //x=x0;
  //println(d0);
}
