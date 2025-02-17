static class Vector {
  float x, y;

  Vector() {
  }

  Vector(float x, float y) {
    set(x, y);
  }

  Vector set(float x, float y) {
    this.x = x; //int(x)
    this.y = y;
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

  Vector mult(float v) {
    return set(x*v, y*v);
  }

  Vector div(float v) {
    return set(x/v, y/v);
  }

  static Vector fromAngle(int deg, int scale) { //degrees, scale
    int x = int(cos(radians(deg))*scale);
    int y = int(sin(radians(deg))*scale);
    return new Vector(x, y);
  }

  float heading() {
    return atan2(y, x); //radians
  }

  float mag() {
    return sqrt(x * x + y * y);
  }

  Vector normalize() {
    return div(mag());
  }

  Vector limit(float max) {
    float len = mag();
    if (len > max) {
      float factor = max / len;
      return mult(factor);
    }
    return this;
  }
}

public class Particle extends Vector {
  Vector velocity = new Vector();

  void update() {
  }

  void draw() {
  }
}
