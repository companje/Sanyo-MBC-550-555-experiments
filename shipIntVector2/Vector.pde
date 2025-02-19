static int cos_table[] = {10, 9, 8, 7, 4, 2, 0, -2, -5, -7, -8, -9, -10, -9, -8, -7, -4, -2, 0, 2, 4, 7, 8, 9};
static int sin_table[] = {0, 2, 5, 7, 8, 9, 10, 9, 8, 7, 5, 2, 0, -2, -4, -7, -8, -9, -10, -9, -8, -7, -5, -2};

static class Vector {
  short x, y;

  Vector() {
  }

  Vector(int x, int y) {
    set(x, y);
  }

  Vector set(int x, int y) {
    this.x = (short)x;
    this.y = (short)y;
    return this;
  }

  Vector set(Vector p) {
    return set(p.x, p.y);
  }

  Vector copy() {
    return new Vector(x, y);
  }

  Vector add(Vector p) {
    return set(x+p.x, y+p.y);
  }

  Vector mult(int v) {
    return set(x*v, y*v);
  }

  Vector div(int v) {
    return set(x/v, y/v);
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
    return (int)degrees(atan2(y, x))+90;
  }

}
