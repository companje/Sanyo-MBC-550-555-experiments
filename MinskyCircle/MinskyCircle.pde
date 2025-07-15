void setup() {
  size(500, 500);
  background(0);
  stroke(255);
}

void draw() {
  background(0);
  translate(width/2, height/2);

  float d=.03;
  float x=0.1;
  float y=0;
  for (int i=0, n=210; i<n; i++) {
    x += d * y;
    y -= d * x;
    point(x*1000, y*1000);
  }
}

//void mouseDragged() {
//  float px = (mouseX-pmouseX)*.001;

//  background(0);
//  x=0.1;
//  y=0;
//  d+=px; //map(mouseX,0,width,0,5);

//}
