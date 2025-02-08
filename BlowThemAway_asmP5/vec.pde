
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
  //PVector pp = new PVector(mem[p], mem[p+1]);
  //pp.limit(x);
  //mem[p+0] = int(pp.x);
  //mem[p+1] = int(pp.y);
  
  println("ax*ax=",x*x);
  
  //1460*1460+1460*1460
  
  println("magSq(p)=","x*x+y*y (x="+mem[p+0]+" y="+mem[p+1]+") " + magSq(p));

  while (magSq(p) > x*x) { // alternatief zonder loop werkt nog niet
    scale(p, 95);
  }
}

//void limit(int p, int max) {
//  if (magSq(p) > max*max) {
//    normalize(p);
//    mult(p,max);
//  }
//}

//int magSq(int p) { //scaled
//  int x = mem[p+0]/100;
//  int y = mem[p+1]/100;
//  int mag = x*x+y*y;
//  return 100*mag;
//}

//1460*1460+1460*1460

int magSq(int p) {
  int a = mem[p]*mem[p]+mem[p+1]*mem[p+1];
  if (a>0xffff) println("overfow magSq("+mem[p]+","+mem[p+1]+")");
  return a;
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

void v_print(int p) {
  println(mem[p+0] + "," + mem[p+1]);
}

void v_print(String name, int p) {
  println(name + ": " + mem[p+0] + "," + mem[p+1]);
}
