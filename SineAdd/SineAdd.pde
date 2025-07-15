void setup() {
  size(800, 800);
  background(0);
  stroke(255);

  for (int x=0; x<width; x++) {
    float a = map(x, 0, width, 0, TWO_PI);
    float p = sin(a);
    float q = sin(t);
    
    y = map((p+q)/2, -1,1, 0,height);
    point(x, y);
  }
}

void draw() {
}
