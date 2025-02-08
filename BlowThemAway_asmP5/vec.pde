
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

//PVector normalize(PVector v) {
//  float mag = v.mag();
//  if (mag != 0) {
//    return new PVector(v.x / mag, v.y / mag);
//  }
//  return new PVector(0, 0);
//}

//void normalize(int p) {
//  int mag = intSqrt(magSq(p));

//  mem[p+0] = (mem[p+0] * 100) / mag;
//  mem[p+1] = (mem[p+1] * 100) / mag;
//}

void div(int p, int x) {
  mem[p+0] /= x;
  mem[p+1] /= x;
}

void scale(int p, int x) {
  mem[p+0] = (mem[p+0]*x) / 100;
  mem[p+1] = (mem[p+1]*x) / 100;
}

void limit(int p, int x) {
  while (magSq(p) > x*x) { // alternatief zonder loop werkt nog niet
    //print("scaling p="+mem[p+0]+","+mem[p+1]+" (magSq=" + magSq(p)+") by 95%. ");
    scale(p, 95);
    //print("result p="+mem[p+0]+","+mem[p+1]+". magSq is now " + magSq(p));
    //println(" <= "+(x*x)+" "+(magSq(p)<=x*x));
  }
}

void clear(int p) {
  mem[p+0] = 0;
  mem[p+1] = 0;
}

//int heading(int p) {
//  ax = mem[VEL+0]; //vx
//  bx = mem[VEL+1]; //vy
//  atan2();
//  return ax;
//}

//void limit(int p, int max) {
//  if (magSq(p) > max*max) {
//    normalize(p);
//    mult(p,max);
//  }
//}

int magSqScaled(int p) { //scaled
  int scaler = 10;
  int x = mem[p+0]/scaler;
  int y = mem[p+1]/scaler;
  int mag = x*x+y*y;
  return 10*mag;
}

//1460*1460+1460*1460

int magSq(int p) {
  return magSqScaled(p);
  //int a = mem[p]*mem[p]+mem[p+1]*mem[p+1];
  //if (a>0xffff) println("overfow magSq("+mem[p]+","+mem[p+1]+")");
  //return a;
}

int mag(int p) {
  return (int)intSqrt(magSq(p));
}

void v_mult() { //ax=scaler, bx=pointer
  mem[bx+0] *= ax;
  mem[bx+1] *= ax;
}

void v_set() { //ax=x, bx=y, bp=pointer
  mem[bp+0] = ax;
  mem[bp+1] = bx;
}

void v_println(int p) {
  println(mem[p+0] + "," + mem[p+1]);
}

void v_println(String name, int p) {
  println(name + ": " + mem[p+0] + "," + mem[p+1]);
}
