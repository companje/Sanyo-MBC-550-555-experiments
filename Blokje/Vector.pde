static int cos_table[] = {10, 9, 8, 7, 4, 2, 0, -2, -5, -7, -8, -9, -10, -9, -8, -7, -4, -2, 0, 2, 4, 7, 8, 9};
static int sin_table[] = {0, 2, 5, 7, 8, 9, 10, 9, 8, 7, 5, 2, 0, -2, -4, -7, -8, -9, -10, -9, -8, -7, -5, -2};

void v_set() { //[bx] = ax:dx
  //mem(bx).set(ax);
  //mem(bx,2).set(dx);
}

void v_add() { // [bx]+=[bp]

}

static class Vector {
  Mem16 x = new Mem16();
  Mem16 y = new Mem16();

  Vector() {
  }

  Vector(int x, int y) {
    set(x, y);
  }

  Vector set(int x, int y) {
    this.x.set(x);
    this.y.set(y);
    return this;
  }

  Vector set(Vector p) {
    return set(p.x.get(), p.y.get());
  }

  Vector copy() {
    return new Vector(x.get(), y.get());
  }

  Vector add(Vector p) {
    return set(x.get()+p.x.get(), y.get()+p.y.get());
  }

  Vector mult(int v) {
    return set(x.get()*v, y.get()*v);
  }

  Vector div(int v) {
    return set(x.get()/v, y.get()/v);
  }

  static Vector fromAngle(int deg) { //degrees, scale
    while (deg<0) deg+=360;
    deg %= 360;
    deg /= 15;
    return new Vector(cos_table[deg], sin_table[deg]);
  }

  String toString() {
    return x+","+y;
  }

  int heading() {
    return (int)degrees(atan2(y.get(), x.get()))+90;
  }

}
