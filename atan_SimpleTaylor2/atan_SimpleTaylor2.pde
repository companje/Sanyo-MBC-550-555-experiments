int ax, bx;
int scale = 110;

void setup() {
  size(500, 500);
  colorMode(HSB);
  rectMode(CENTER);
  textSize(30);
}

void draw() {
  background(0);
  
  fill(255);
  text(scale,50,50);
  
  translate(width/2, height/2);
  
  scale(2);

  for (int i=0; i<360; i+=1) {
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

void keyPressed() {
  if (key=='-') scale--;
  if (key=='=') scale++;
}


int atan(int z) {
  //println(z);
  if (z>scale) {
    ax = scale*scale;
    ax /= z;
    bx = atan(ax);   //recursion
    ax = 90;
    ax -= bx;
  } else if (z<-scale) {
    ax = 12321;
    ax /= z;
    bx = atan(ax);   //recursion
    ax = -90;
    ax -= bx;
  } else {
    ax = z;
    ax *= ax;
    bx = 3*scale;
    ax /= bx;  //Taylor-benadering
    bx = ax;
    ax = scale;
    ax -= bx;
    bx = 180;
    ax *= bx;
    ax *= z;
    bx = scale;
    ax /= bx;
    bx = 314;
    ax /= bx;
  }
  return ax;
}

int atan2(int y, int x) {
  if (x!=0) {
    ax = y;
    ax *= scale;
    ax /= x;
    ax = atan(ax);
  }
  if (x < 0 && y >= 0) ax+=180;
  else if (x < 0 && y < 0) ax-=180;
  else if (x == 0 && y > 0) ax=90;
  else if (x == 0 && y < 0) ax=-90;

  return ax;
}
