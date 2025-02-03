
int atan() { //input ax
  cx = ax;
  if (cx>111) {
    ax = 12321;
    ax /= cx;
    ax = atan();
    bx = ax;   //recursion
    ax = 90;
    ax -= bx;
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
    if (bx > 0) ax=90;  //y>0
    if (bx <= 0) ax=-90;  //y<=0  eigenlijk y<0
  } else {
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
  if (ax<0) ax+=360;
}
