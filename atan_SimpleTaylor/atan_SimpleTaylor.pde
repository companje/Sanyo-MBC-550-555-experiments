int ax, bx;

void setup() {
  size(500, 500);
  colorMode(HSB);
  rectMode(CENTER);
}

void draw() {
  background(0);
  translate(width/2, height/2);

  for (int i=0; i<360; i+=15) {
    //Vec v = fromAngle(i, 100);
    int x = int(cos(radians(i))*100);
    int y = int(sin(radians(i))*100);
    float angle = radians(atan2(y, x));

    float x2 = cos(angle)*120;
    float y2 = sin(angle)*120;

    stroke(255);
    line(x, y, x2, y2);
    fill(i, 255, 255);
    noStroke();
    rect(x, y, 5, 5);
    rect(x2, y2, 5, 5);
  }
}

int atan(int z) {
  if (z>111) {
    ax = 12321;
    ax /= z;
    bx = atan(ax);   //recursion
    ax = 90;
    ax -= bx;
  } else if (z<-111) {
    ax = 12321;
    ax /= z;
    bx = atan(ax);   //recursion
    ax = -90;
    ax -= bx;
  } else {
    ax = z;
    ax *= ax;
    ax /= 333;  //Taylor-benadering 
    bx = ax;
    ax = 111;
    ax -= bx;
    ax *= 180;
    ax *= z;
    ax /= 111;
    ax /= 314;
  }
  return ax;
}

int atan2(int y, int x) {
  if (x!=0) {
    ax = y;
    ax *= 111;
    ax /= x;
    ax = atan(ax);
  }
  if (x < 0 && y >= 0) ax+=180;
  else if (x < 0 && y < 0) ax-=180;
  else if (x == 0 && y > 0) ax=90;
  else if (x == 0 && y < 0) ax=-90;
  
  return ax;
}
