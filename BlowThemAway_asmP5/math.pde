void v_wrap(int p) {
  mem[p+0] = wrap_word(mem[p+0]);
  mem[p+1] = wrap_word(mem[p+1]);
}

int wrap_word(int v) {
  while (v>0xffff) v-=0xffff;
  while (v<0) v+=0xffff;
  return v;
}

int wrap_range(int v, int min, int max) {
  int delta = max-min;
  while (v>max) v-=delta;
  while (v<min) v+=delta;
  return v;
}

int intSqrt(int x) {
  println(x);

  int res = 0;
  int bit = 1 << 30; // Start met het hoogste mogelijke kwadraat

  while (bit > x) bit >>= 2; // Zoek de hoogste macht van vier ≤ x

  while (bit != 0) {
    if (x >= res + bit) {
      x -= res + bit;
      res = (res >> 1) + bit;
    } else {
      res >>= 1;
    }
    bit >>= 2;
  }
  return res;
}


//geen magnitude
void xy_from_angle() { //input ax=angle, output ax=x, bx=y
  stack.push(ax);
  sin_15steps();
  bx = ax;    //bx=y=sin(angle) result
  ax = stack.pop();
  cos_15steps(); //ax=x=cos(angle) result
}

void cos_15steps() { //ax=positive angle in degrees
  int v[] = {100, 96, 86, 70, 50, 25, 0, -25, -50, -70, -86, -96, -100, -96, -86, -70, -49, -25, 0, 25, 49, 70, 86, 96, 100};
  ax += 360; //make positive
  ax %= 360;
  ax /= 15;
  ax = v[ax];
}

void sin_15steps() { //ax=positive angle in degrees
  int v[] = {0, 25, 50, 70, 86, 96, 100, 96, 86, 70, 50, 25, 0, -25, -50, -70, -86, -96, -100, -96, -86, -70, -50, -25, 0};
  ax += 360;
  ax %= 360;
  ax /= 15;
  ax = v[ax];
}

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
