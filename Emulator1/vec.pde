
//void v_mult() { //ax=scaler, bx=pointer
//  push(ax);
//  push(cx);
//  mov(cx, ax);
//  mov(ax, mem(bx));  //x
//  mul(cx);
//  mov(mem(bx), ax);
//  mov(ax,mem(bx,+1)); //y
//  mul(cx);
//  mov(mem(bx,+1), ax);
//  pop(cx);
//  pop(ax);
//}

//void v_add() {  //[bx]+=[bp]
//  mov(ax,mem(bx));
//  add(ax,mem(bp));   // bx.x += bp.x
//  mov(mem(bx), ax);
//  mov(ax,mem(bx,+1));
//  add(ax,mem(bp,+1)); // bx.y += bp.y
//  mov(mem(bx,+1), ax);
//}



//void copy(int p, int q) {
//  mem(p+0).set(mem(q+0).get());
//  mem(p+1).set(mem(q+1).get());
//  //mem[p+0] = mem[q+0];
//  //mem[p+1] = mem[q+1];
//}

//void add(int p, int q) {
//  mem(p+0).set(mem(p+0).get() + mem(q+0).get());
//  mem(p+1).set(mem(p+1).get() + mem(q+1).get());
//}

//void sub(int p, int q) {
//  mem[p+0] -= mem[q+0];
//  mem[p+1] -= mem[q+1];
//}

//void mult(int p, int x) {
//  mem[p+0] *= x;
//  mem[p+1] *= x;
//}

////PVector normalize(PVector v) {
////  float mag = v.mag();
////  if (mag != 0) {
////    return new PVector(v.x / mag, v.y / mag);
////  }
////  return new PVector(0, 0);
////}

////void normalize(int p) {
////  int mag = intSqrt(magSq(p));

////  mem[p+0] = (mem[p+0] * 100) / mag;
////  mem[p+1] = (mem[p+1] * 100) / mag;
////}

//void div(int p, int x) {
//  mem[p+0] /= x;
//  mem[p+1] /= x;
//}

//void scale(int p, int x) {
//  mem[p+0] = (mem[p+0]*x) / 100;
//  mem[p+1] = (mem[p+1]*x) / 100;
//}

//void limit(int p, int x) {
//  while (magSq(p) > x*x) { // alternatief zonder loop werkt nog niet
//    scale(p, 95);
//  }
//}

//void clear(int p) {
//  mem[p+0] = 0;
//  mem[p+1] = 0;
//}

//int magSqScaled(int p) { //scaled
//  int scaler = 10;
//  int x = mem[p+0]/scaler;
//  int y = mem[p+1]/scaler;
//  int mag = x*x+y*y;
//  return 10*mag;
//}

//int magSq(int p) {
//  return magSqScaled(p);
//}

//int mag(int p) {
//  return (int)intSqrt(magSq(p));
//}

////void v_mult() { //ax=scaler, bx=pointer
////  mem[bx+0] *= ax;
////  mem[bx+1] *= ax;
////}

//void v_set() { //ax=x, bx=y, bp=pointer
//  mem(bp,+0).set(ax);
//  mem(bp,+1).set(bx);
//  //mem[bp+0] = ax;
//  //mem[bp+1] = bx;
//}

//void v_println(int p) {
//  println(mem[p+0] + "," + mem[p+1]);
//}

//void v_println(String name, int p) {
//  println(name + ": " + mem[p+0] + "," + mem[p+1]);
//}
