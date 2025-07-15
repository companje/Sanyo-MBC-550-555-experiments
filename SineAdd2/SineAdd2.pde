int c=0;
color colors[] = {color(255,0,0), color(0,255,0), color(0,0,255), color(255,0,0) };
void setup() {
  size(800, 800);
  background(0);
  stroke(255);
}

void draw() {
  float t = frameCount*.01;

  for (int x=0; x<width; x++) {
    float a = map(x, 0, width, 0, TWO_PI);
    float p = sin(a + t);
    float q = cos(a + t );
    float r = sin(x*x); 

    float y = map((p+q+r)/3, -1, 1, 0, height);
    point(x, y);
  }
  
  if ((frameCount%400)==0) {
    c = (c+1) % colors.length;
    stroke(colors[c]);
  }
}
