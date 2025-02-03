class Star {
  float x, y, s;
  int c;

  Star(float x, float y) {
    this.x = x;
    this.y = y;
    this.s = random(2, 6);
    this.c = color(255);
  }
}
