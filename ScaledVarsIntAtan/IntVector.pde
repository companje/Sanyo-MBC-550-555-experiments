static class Vec {
  int x, y, s;  //s is a data var for example for star scale
  color c;

  Vec() {
  }
  
  Vec(int _x, int _y) {
    x = _x;
    y = _y;
  }

  void add(Vec v) {
    x += v.x;
    y += v.y;
  }

  void sub(Vec v) {
    x -= v.x;
    y -= v.y;
  }

  void mult(int scaler) {
    x *= scaler;
    y *= scaler;
  }
  
  void scale(int scaler) {
    x = (x * scaler) / 100;
    y = (y * scaler) / 100;
  }

  void limit(int max) { //fixme: dit oplossen zonder loop
    while (magSq() > max*max) {
      scale(95);
    }
    
    //int lenSq = magSq();
    //int maxSq = max*max;
    
    //if (lenSq > maxSq) {
    //  x = x * maxSq / lenSq;
    //  y = y * maxSq / lenSq;
    //}
    
    //int magSq = magSq();
    //int maxSq = max*max;
    //if (magSq > maxSq) {
    //  x = (x*maxSq) / magSq;
    //  y = (y*maxSq) / magSq;
    //}
  }

  int magSq() {
    return x*x+y*y;
  }

  Vec copy() {
    return new Vec(x, y);
  }

  static Vec fromAngle(int angle, int mag) {
    angle = (angle + 360) % 360;

    int q = angle / 90;
    int r = angle % 90;

    int c = (100 * (90 - r) + 45) / 9;  //cos
    int s = (100 * r + 45) / 9;         //sin

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

    return new Vec(x*mag, y*mag);
  }
  
  String toString() {
    return x+","+y;
  }
}
