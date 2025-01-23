import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int ax, bx, cx;
int x,y;


void setup() {
  size(500, 500);
  colorMode(HSB);
  rectMode(CENTER);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  scale(2);
  
  for (int i=0; i<360; i+=15) {
    //Vec v = fromAngle(i, 100);
    ax = x = int(cos(radians(i))*100);
    bx = y = int(sin(radians(i))*100);
    print(ax,bx," ");
    atan2();
    println(ax);
    float angle = radians(ax);

    float x2 = cos(angle)*120;
    float y2 = sin(angle)*120;

    stroke(255);
    line(x, y, x2, y2);
    fill(i, 255, 255);
    noStroke();
    rect(x, y, 5, 5);
    rect(x2, y2, 5, 5);
  }

  noLoop();
}

int atan() { //input ax
  cx = ax;
  if (cx>111) {
    ax = 12321;
    ax /= cx;
    //println(ax, cx);
    ax = atan();
    bx = ax;   //recursion
    ax = 90;
    ax -= bx;
    //println("ax", ax);
  } else if (cx<-111) {
    ax = 12321;
    ax /= cx;
    ax = atan();
    bx = ax;   //recursion
    ax = -90;
    ax -= bx;
  } else {
    ax = cx;
    ax *= ax;
    bx = 333;
    ax /= bx;  //Taylor-benadering
    bx = ax;
    ax = 111;
    ax -= bx;
    bx = 180;
    ax *= bx;
    ax *= cx;
    bx = 111;
    ax /= bx;
    bx = 314;
    ax /= bx;
  }
  return ax;
}

void atan2() {
  if (ax == 0) {  //x==0
    if (bx > 0) {  //y>0
      ax=90;
      return;
    }
    if (bx <= 0) { //y<=0  eigenlijk y<0
      ax=-90;
      return;
    }
  }

  stack.push(ax); //x
  stack.push(ax); //x
  ax = bx;
  cx = 111;
  ax *= cx;
  cx = stack.pop(); //x
  ax /= cx;
  ax = atan();
  cx = stack.pop(); //x
  
  if (cx<0) {
    if (bx>=0) ax+=180;
    else if (bx<0) ax-=180;
  }
}
