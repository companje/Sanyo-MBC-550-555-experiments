

void copy(int p, int q) {
  mem[p+0] = mem[q+0];
  mem[p+1] = mem[q+1];
}

void add(int p, int q) {
  mem[p+0] += mem[q+0];
  mem[p+1] += mem[q+1];
}

void sub(int p, int q) {
  mem[p+0] -= mem[q+0];
  mem[p+1] -= mem[q+1];
}

void mult(int p, int x) {
  mem[p+0] *= x;
  mem[p+1] *= x;
}

void div(int p, int x) {
  mem[p+0] /= x;
  mem[p+1] /= x;
}

void limit(int p, int x) {
  while (magSq(p) > x*x) {
    mult(p,95);
    div(p,100);
  }
}

int magSq(int p) {
  return mem[p]*mem[p]+mem[p+1]*mem[p+1];
}

int cos(int a) { //a in deg
  return (100 * (90 - a) + 45) / 9;
}

int sin(int a) { //a in deg
  return (100 * a + 45) / 9; 
}

void fromAngle(int p, int angle, int mag) {
    angle = (angle + 360) % 360;

    int q = angle / 90;
    int r = angle % 90;

    int c = cos(r);
    int s = sin(r);

    int x = c;
    int y = s;

    if (q==1) {
      x = -s;
      y = c;
    } else if (q==2) {
      x = -x;
      y = -y;
    } else if (q==3) {
      x = s;
      y = -c;
    }

    mem[p+0] = x*mag;
    mem[p+1] = y*mag;
    //return new Vec(x*mag, y*mag);
  }
